(import "././login/env.inc")
(import "sys/lisp.inc")
(import "class/lisp.inc")
(import "gui/lisp.inc")
(import "lib/text/files.inc")

(enums +event 0
	(enum close)
	(enum prev next))

(enums +select 0
	(enum main tip))

(defq images (sort cmp (all-files "apps/images/data" '(".cpm" ".tga" ".svg")))
	index (some (# (if (eql "apps/images/data/tiger.svg" %0) _)) images)
	id :t)

(ui-window *window* ()
	(ui-title-bar window_title "" (0xea19) +event_close)
	(ui-tool-bar main_toolbar ()
		(ui-buttons (0xe91d 0xe91e) +event_prev))
	(ui-scroll image_scroll +scroll_flag_both))

(defun win-refresh (_)
	(defq file (elem-get (setq index _) images))
	(bind '(w h) (. (defq canvas (Canvas-from-file file 0)) :pref_size))
	(def image_scroll :min_width w :min_height h)
	(def window_title :text (cat "Images -> " (slice (inc (find-rev "/" file)) -1 file)))
	(. image_scroll :add_child canvas)
	(. window_title :layout)
	(bind '(x y w h) (apply view-fit (cat (. *window* :get_pos) (. *window* :pref_size))))
	(def image_scroll :min_width 32 :min_height 32)
	(. *window* :change_dirty x y w h))

(defun tooltips ()
	(def *window* :tip_mbox (elem-get +select_tip select))
	(tool-tips main_toolbar
		'("prev" "next")))

(defun main ()
	(defq select (alloc-select +select_size))
	(tooltips)
	(bind '(x y w h) (apply view-locate (. (win-refresh index) :get_size)))
	(gui-add-front (. *window* :change x y w h))
	(while id
		(defq *msg* (mail-read (elem-get (defq idx (mail-select select)) select)))
		(cond
			((= idx +select_tip)
				;tip time mail
				(if (defq view (. *window* :find_id (getf *msg* +mail_timeout_id)))
					(. view :show_tip)))
			((= (setq id (getf *msg* +ev_msg_target_id)) +event_close)
				(setq id :nil))
			((<= +event_prev id +event_next)
				(win-refresh (% (+ index (dec (* 2 (- id +event_prev))) (length images)) (length images))))
			(:t (. *window* :event *msg*))))
	(free-select select)
	(gui-sub *window*))
