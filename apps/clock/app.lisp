;imports
(import 'apps/login/pupa.inc)
(import 'sys/lisp.inc)
(import 'class/lisp.inc)
(import 'gui/lisp.inc)

;add event id etc
(defq clock_size 256 clock_scale 1)

;define events we will use
(structure 'event 0
	(byte 'win_close))

;create a window
(ui-window window ()
	(ui-flow _ ('flow_flags flow_down_fill)
		(ui-flow _ ('flow_flags flow_left_fill 'font (create-font "fonts/Entypo.ctf" 22) 'color *env_title_col*)
			(ui-buttons (0xea19) (const event_win_close))
			(ui-title _ ('text "Clock" 'font (create-font "fonts/OpenSans-Regular.ctf" 18))))
		(ui-canvas clock clock_size clock_size clock_scale)
		(ui-label display ('text "00:00:00" 'color argb_black 'ink_color argb_red
			'flow_flags (logior flow_flag_align_hcenter flow_flag_align_vcenter)
			'font (create-font "fonts/Hack-Regular.ctf" 48)))))

(defun-bind main ()
	;clear clock face
	(canvas-set-flags (canvas-fill clock 0) 1)
	(gui-add (apply view-change (cat (list window 164 16) (view-pref-size window))))
	;create child and send args
	(mail-send (list display clock (* clock_size 1.0) (* clock_scale 1.0))
		(defq mbox (open-child "apps/clock/child.lisp" kn_call_open)))
	;main app loop
	(while (cond
		((= (get-long (defq msg (mail-read (task-mailbox))) ev_msg_target_id) event_win_close)
			nil)
		(t (view-event window msg))))
	;close child and window
	(mail-send "" mbox)
	(view-hide window))
