;;;;;;;;;;;;;;;
; scroll widget
;;;;;;;;;;;;;;;

(import "gui/slider/lisp.inc")

;scroll flags
(defq +scroll_flag_vertical+ 1 +scroll_flag_horizontal+ 2)

;scroll flag combos
(defq +scroll_flag_both+ (logior +scroll_flag_vertical+ +scroll_flag_horizontal+))

(defclass Scroll (flags)
	; (Scroll flags) -> scroll
	; overide the default 'this' env with a scroll component
	; inherit from View !
	(def (defq this (View)) :vslider nil :hslider nil :child nil)
	(when (/= 0 (logand flags +scroll_flag_vertical+))
		(def this :vslider (defq slider (Slider)))
		(component-connect slider (component-get-id this))
		(. this :add_front slider))
	(when (/= 0 (logand flags +scroll_flag_horizontal+))
		(def this :hslider (defq slider (Slider)))
		(component-connect slider (component-get-id this))
		(. this :add_front slider))

	(defmethod :add_child (this child)
		; (. scroll :add_child child) -> scroll
		(if (defq old_child (get :child this))
			(. old_child :sub))
		(. this :add_back (set this :child child)))

	(defmethod :action (this data)
		; (. scroll :action data) -> scroll
		(.-> this :layout (:set_flags +view_flag_dirty_all+ +view_flag_dirty_all+)))

	(defmethod :pref_size (this)
		; (. scroll :pref_size) -> (width height)
		(defq hslider (get :hslider this) vslider (get :vslider this)
			mw (get :min_width this) mh (get :min_height this))
		(setd mw 0 mh 0)
		(if vslider
			(setq mw (+ mw (pop (. vslider :pref_size)))))
		(if hslider
			(setq mh (+ mh (pop (. hslider :pref_size)))))
		(list mw mh))

	(defmethod :layout (this)
		; (. scroll :layout) -> scroll
		(defq hslider (get :hslider this) vslider (get :vslider this)
			child (get :child this) sw 0 sh 0)

		;position any sliders
		(bind '(w h) (. this :get_size))
		(when vslider
			(bind '(sw _) (. vslider :pref_size))
			(. vslider :change (- w sw) 0 sw h))
		(when hslider
			(bind '(sh _) (. hslider :pref_size))
			(. hslider :change 0 (- h sh) (- w sw) sh))

		;position any child
		(when child
			(defq vval 0 hval 0)
			(bind '(cw ch) (. child :get_size))
			(when vslider
				(unless (setq vval (get :value vslider)) (setq vval 0))
				(defq mo (max 0 (- ch (- h sh))))
				(def vslider :maximum mo :portion (- h sh) :value (setq vval (min vval mo))))
			(when hslider
				(unless (setq hval (get :value hslider)) (setq hval 0))
				(defq mo (max 0 (- cw (- w sw))))
				(def hslider :maximum mo :portion (- w sw) :value (setq hval (min hval mo))))
			(. child :set_bounds (neg hval) (neg vval) cw ch))
		this)
	)