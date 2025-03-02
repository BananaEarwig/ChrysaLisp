;common imports
(import "././login/env.inc")
(import "gui/lisp.inc")

;debug options
(case :nil
(0 (import "lib/debug/frames.inc"))
(1 (import "lib/debug/profile.inc"))
(2 (import "lib/debug/debug.inc")))

(cond   ;pick number format :t/:nil
	(:t ;reals
		(defmacro vec (&rest _) `(reals ~_))
		(defmacro i2n (_) `(n2r ,_))
		(defmacro f2n (_) `(n2r ,_)))
	(:t ;fixed point
		(defmacro vec (&rest _) `(fixeds ~_))
		(defmacro i2n (_) `(n2f ,_))
		(defmacro f2n (_) _)))

(defmacro vec-n2f (&rest _)
	(static-qq (fixeds ~(map (lambda (_) (list 'n2f _)) _))))

(defmacro vec-i2n (&rest _)
	(static-qq (vec ~(map (lambda (_) (list 'i2n _)) _))))

(defmacro vec-f2n (&rest _)
	(static-qq (vec ~(map (lambda (_) (list 'f2n _)) _))))

(enums +dlist 0
	(enum mask light_pos layer1_canvas layer1_verts))

(enums +path 0
	(enum mode color radius path))

(enums +vertex 0
	(enum p v r c))

(defq box_size 500 focal_len 1 max_vel 5 num_bubbles 50 bubble_radius 70
	light_pos (vec-i2n (neg box_size) (neg box_size) (neg (* box_size 4))))
