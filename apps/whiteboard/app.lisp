(import "lib/math/math.inc")
(import "./app.inc")

(enums +select 0
	(enum main picker timer))

(bits +layer 0
	(bit commited overlay))

(defun trans (_)
	;transparent colour
	(+ (logand 0xffffff _) 0x60000000))

(defq canvas_width 1024 canvas_height 768 min_width 320 min_height 240 eps 0.25 tol 3.0
	radiuss (map i2f '(2 6 12)) stroke_radius (elem 0 radiuss) then (pii-time)
	palette (list +argb_black +argb_white +argb_red +argb_green +argb_blue +argb_cyan +argb_yellow +argb_magenta)
	palette (cat palette (map trans palette)) undo_stack (list) redo_stack (list)
	stroke_col (elem 0 palette) stroke_mode +event_pen commited_polygons (list) overlay_paths (list)
	picker_mbox nil picker_mode nil select (list (task-mailbox) (mail-alloc-mbox) (mail-alloc-mbox))
	rate (/ 1000000 60) +layer_all (+ +layer_commited +layer_overlay))

(ui-window mywindow ()
	(ui-title-bar _ "Whiteboard" (0xea19 0xea1b 0xea1a) +event_close)
	(ui-flow _ (:flow_flags +flow_right_fill)
		(ui-tool-bar _ () (ui-buttons (0xea07 0xe9e9 0xe970 0xe9fe 0xe99d) +event_save))
		(ui-tool-bar style_toolbar () (ui-buttons (0xe976 0xe9a3 0xe9d4 0xe9f0) +event_grid))
		(ui-tool-bar radius_toolbar () (ui-buttons (0xe979 0xe97d 0xe97b) +event_radius1))
		(ui-tool-bar mode_toolbar () (ui-buttons (0xe9ec 0xe9d8 0xe917 0xea20 0xe9f6 0xe94b 0xe960 0xe95f) +event_pen)))
	(ui-tool-bar ink_toolbar (:font *env_medium_toolbar_font* :color (const *env_toolbar2_col*))
		(each (lambda (col)
			(. (ui-button __ (:ink_color col :text
				(if (< _ 8) (const (num-to-utf8 0xe982)) (const (num-to-utf8 0xea04))))) :connect
					(+ _ +event_black))) palette))
	(ui-scroll image_scroll (logior +scroll_flag_vertical +scroll_flag_horizontal)
			(:min_width canvas_width :min_height canvas_height)
		(ui-backdrop mybackdrop (:color 0xffF8F8FF :ink_color 0xffADD8E6)
			(ui-canvas overlay_canvas canvas_width canvas_height 1)
			(ui-canvas commited_canvas canvas_width canvas_height 1))))

(defun radio-select (toolbar idx)
	(each (lambda (button)
			(undef (. button :dirty) :color)
			(if (= _ idx) (def button :color *env_radio_col*)))
		(. toolbar :children)) idx)

(defun flatten ((mode col rad pnts))
	;flatten path to polygon
	(list col (cond
		((< (length pnts) 2)
			;a runt so nothing
			'())
		((= 2 (length pnts))
			;just a point
			(list (path-gen-arc (elem 0 pnts) (elem 1 pnts) 0.0 +fp_2pi rad (const eps) (path))))
		(t	;is a polyline draw
			(bind '(x y x1 y1 &rest _) pnts)
			(cond
				((= mode +event_arrow1)
					;flatten to arrow1
					(path-stroke-polylines (list) rad (const eps) +join_bevel +cap_butt +cap_arrow (list pnts)))
				((= mode +event_arrow2)
					;flatten to arrow2
					(path-stroke-polylines (list) rad (const eps) +join_bevel +cap_arrow +cap_arrow (list pnts)))
				((= mode +event_box)
					;flatten to box
					(path-stroke-polygons (list) rad (const eps) +join_miter (list (path x y x1 y x1 y1 x y1))))
				((= mode +event_circle)
					;flatten to circle
					(path-stroke-polygons (list) rad (const eps) +join_bevel
						(list (path-gen-arc x y 0.0 +fp_2pi (vec-length (vec-sub (path x y) (path x1 y1)))
							(const eps) (path)))))
				((= mode +event_fbox)
					;flatten to filled box
					(list (path x y x1 y x1 y1 x y1)))
				((= mode +event_fcircle)
					;flatten to filled circle
					(list (path-gen-arc x y 0.0 +fp_2pi (vec-length (vec-sub (path x y) (path x1 y1)))
						(const eps) (path))))
				(t	;flatten to pen stroke
					(path-stroke-polylines (list) rad (const eps) +join_bevel +cap_round +cap_round (list pnts))))))))

(defun snapshot ()
	;take a snapshot of the canvas state
	(push undo_stack (cat commited_polygons))
	(clear redo_stack))

(defun redraw-layers (mask)
	;redraw layer/s
	(elem-set +dlist_commited_polygons dlist (cat commited_polygons))
	(elem-set +dlist_overlay_paths dlist (cat overlay_paths))
	(elem-set +dlist_mask dlist (logior (elem +dlist_mask dlist) mask)))

(defun undo ()
	;move state from undo to redo stack and restore old state
	(when (/= 0 (length undo_stack))
		(push redo_stack commited_polygons)
		(setq commited_polygons (pop undo_stack))
		(redraw-layers +layer_commited)))

(defun redo ()
	;move state from redo to undo stack and restore old state
	(when (/= 0 (length redo_stack))
		(push undo_stack commited_polygons)
		(setq commited_polygons (pop redo_stack))
		(redraw-layers +layer_commited)))

(defun commit (p)
	;commit a stroke to the canvas
	(push commited_polygons (flatten p)))

(defun fpoly (canvas col mode _)
	;draw a polygon on a canvas
	(. canvas :set_color col)
	(. canvas :fpoly 0.0 0.0 mode _))

(defun redraw (dlist)
	;redraw layer/s
	(when (/= 0 (logand (elem +dlist_mask dlist) +layer_commited))
		(defq canvas (elem +dlist_commited_canvas dlist))
		(. canvas :fill 0)
		(each (lambda ((col poly))
			(fpoly canvas col +winding_none_zero poly)) (elem +dlist_commited_polygons dlist))
		(. canvas :swap))
	(when (/= 0 (logand (elem +dlist_mask dlist) +layer_overlay))
		(defq canvas (elem +dlist_overlay_canvas dlist))
		(. canvas :fill 0)
		(each (lambda (p)
			(bind '(col poly) (flatten p))
			(fpoly canvas col +winding_none_zero poly)) (elem +dlist_overlay_paths dlist))
		(. canvas :swap))
	(elem-set +dlist_mask dlist 0))

(defun main ()
	;ui tree initial setup
	(defq dlist (list +layer_all commited_canvas overlay_canvas (list) (list)))
	(. commited_canvas :set_canvas_flags +canvas_flag_antialias)
	(. overlay_canvas :set_canvas_flags +canvas_flag_antialias)
	(. mybackdrop :set_size canvas_width canvas_height)
	(radio-select ink_toolbar 0)
	(radio-select mode_toolbar 0)
	(radio-select radius_toolbar 0)
	(radio-select style_toolbar 0)
	(bind '(x y w h) (apply view-locate (. mywindow :pref_size)))
	(gui-add-front (. mywindow :change x y w h))
	(def image_scroll :min_width min_width :min_height min_height)

	;main event loop
	(defq last_state :u last_point nil last_mid_point nil id t)
	(mail-timeout (elem +select_timer select) rate 0)
	(while id
		(defq msg (mail-read (elem (defq idx (mail-select select)) select)))
		(cond
			((= idx +select_main)
				;main mailbox
				(cond
					((= (setq id (getf msg +ev_msg_target_id)) +event_close)
						;close button
						(setq id nil))
					((= id +event_min)
						;min button
						(bind '(x y w h) (apply view-fit (cat (. mywindow :get_pos) (. mywindow :pref_size))))
						(. mywindow :change_dirty x y w h))
					((= id +event_max)
						;max button
						(def image_scroll :min_width canvas_width :min_height canvas_height)
						(bind '(x y w h) (apply view-fit (cat (. mywindow :get_pos) (. mywindow :pref_size))))
						(. mywindow :change_dirty x y w h)
						(def image_scroll :min_width min_width :min_height min_height))
					((<= +event_black id +event_tmagenta)
						;ink pot
						(setq stroke_col (elem (radio-select ink_toolbar (- id +event_black)) palette)))
					((<= +event_pen id +event_fcircle)
						;draw mode
						(setq stroke_mode (+ (radio-select mode_toolbar (- id +event_pen)) +event_pen)))
					((<= +event_radius1 id +event_radius3)
						;stroke radius
						(setq stroke_radius (elem (radio-select radius_toolbar (- id +event_radius1)) radiuss)))
					((<= +event_grid id +event_lines)
						;styles
						(def (. mybackdrop :dirty) :style (elem (radio-select style_toolbar (- id +event_grid)) '(nil :grid :lines :axis))))
					((= id +event_save)
						;save
						(if picker_mbox (mail-send picker_mbox ""))
						(mail-send (setq picker_mode t picker_mbox (open-child "apps/files/child.lisp" +kn_call_open))
							(list (elem +select_picker select) "Save Whiteboard..." "." "")))
					((= id +event_load)
						;load
						(if picker_mbox (mail-send picker_mbox ""))
						(mail-send (setq picker_mode nil picker_mbox (open-child "apps/files/child.lisp" +kn_call_open))
							(list (elem +select_picker select) "Load Whiteboard..." "." ".cwb")))
					((= id +event_clear)
						;clear
						(snapshot)
						(clear commited_polygons)
						(redraw-layers +layer_commited))
					((= id +event_undo)
						;undo
						(undo))
					((= id +event_redo)
						;undo
						(redo))
					((and (= id (. overlay_canvas :get_id)) (= (getf msg +ev_msg_type) +ev_type_mouse))
						;mouse event for canvas
						(defq new_point (path (i2f (getf msg +ev_msg_mouse_rx))
							(i2f (getf msg +ev_msg_mouse_ry))))
						(cond
							((/= (getf msg +ev_msg_mouse_buttons) 0)
								;mouse button is down
								(case last_state
									(:d	;was down last time, what draw mode ?
										(cond
											((= stroke_mode +event_pen)
												;pen mode, so extend last stroke ?
												(defq stroke (elem +path_path (elem -2 overlay_paths))
													mid_vec (vec-sub new_point last_point))
												(when (>= (vec-length-squared mid_vec) (* stroke_radius stroke_radius))
													(defq mid_point (vec-add last_point (vec-scale mid_vec 0.5)))
													(path-gen-quadratic
														(elem 0 last_mid_point) (elem 1 last_mid_point)
														(elem 0 last_point) (elem 1 last_point)
														(elem 0 mid_point) (elem 1 mid_point)
														(const eps) stroke)
													(path-filter (const tol) stroke stroke)
													(setq last_point new_point last_mid_point mid_point)
													(redraw-layers +layer_overlay)))
											(t	;a shape mode
												(elem-set +path_path (elem -2 overlay_paths) (cat last_point new_point))
												(redraw-layers +layer_overlay)))
										)
									(:u	;was up last time, so start new stroke
										(setq last_state :d last_point new_point last_mid_point new_point)
										(push overlay_paths (list stroke_mode stroke_col stroke_radius new_point))
										(redraw-layers +layer_overlay))))
							(t	;mouse button is up
								(case last_state
									(:d	;was down last time, so last point and commit stroke
										(snapshot)
										(setq last_state :u)
										(defq stroke (elem +path_path (elem -2 overlay_paths)))
										(push stroke (elem 0 new_point) (elem 1 new_point))
										(path-filter 0.5 stroke stroke)
										(each commit overlay_paths)
										(clear overlay_paths)
										(redraw-layers +layer_all))
									(:u	;was up last time, so we are hovering
										t)))))
					(t	(. mywindow :event msg))))
			((= idx +select_picker)
				;save/load picker responce
				(mail-send picker_mbox "")
				(setq picker_mbox nil)
				(cond
					;closed picker
					((eql msg ""))
					;save whiteboard
					(picker_mode
						(save (str (list "CWB Version 1.0" commited_polygons))
							(cat (slice 0 (if (defq i (find-rev "." msg)) i -1) msg) ".cwb")))
					;load whiteboard
					(t	(when (ends-with ".cwb" msg)
							(bind '(data _) (read (file-stream msg) (ascii-code " ")))
							(when (eql (elem 0 data) "CWB Version 1.0")
								(snapshot)
								(setq commited_polygons (map (lambda ((c p))
									(list c (map (lambda (_)
										(apply path _)) p))) (elem 1 data)))
								(redraw-layers +layer_commited))))))
			(t	;timer event
				(mail-timeout (elem +select_timer select) rate 0)
				(redraw dlist))))
	;close window
	(each mail-free-mbox (slice 1 -1 select))
	(if picker_mbox (mail-send picker_mbox ""))
	(gui-sub mywindow)
	(profile-report "Whiteboard App"))
