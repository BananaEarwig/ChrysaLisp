;module
(env-push)

(defun line-words (line)
	(map (# (cat %0 " ")) (split line " ")))

(defun line-flow (&optional size)
	(def (defq flow (Flow)) :flow_flags +flow_right_fill)
	(if size (def flow :font (create-font "fonts/OpenSans-Regular.ctf" size)))
	(. page :add_child flow)
	flow)

(defun heading (words &optional size)
	(defq cnt 0 state nil page_width (get :min_width page)
		flow (line-flow size))
	(each (lambda (word)
		(. flow :add_child (defq text (Text)))
		(if (starts-with "`" word)
			(setq state t word (slice 1 -1 word)))
		(if state (def text :ink_color +argb_blue))
		(if (find "`" word)
			(setq state nil word (apply cat (split word "`"))))
		(def text :text word)
		(bind '(w _) (. text :pref_size))
		(when (> (setq cnt (+ cnt w)) page_width)
			(setq flow (line-flow size))
			(. flow :add_child text)
			(setq cnt w))) words))

(defun paragraph (words &optional size)
	(defq cnt 0 state nil index 0 page_width (get :min_width page)
		flow (line-flow size))
	(when (and (> (length words) 0)
			(eql (elem 0 words) "* "))
		;needs a bullet and indent
		(def (defq text (Text))
			:text (cat (num-to-utf8 0xe95f) "    ") 
			:font (create-font "fonts/Entypo.ctf" 10))
		(. flow :add_child text)
		(setq index 1 cnt (defq indent_width (elem 0 (. text :pref_size)))))
	(each! index -1 (lambda (word)
		(. flow :add_child (defq text (Text)))
		(if (starts-with "`" word)
			(setq state t word (slice 1 -1 word)))
		(if state (def text :ink_color +argb_blue))
		(if (find "`" word)
			(setq state nil word (apply cat (split word "`"))))
		(def text :text word)
		(bind '(w _) (. text :pref_size))
		(when (> (setq cnt (+ cnt w)) page_width)
			(setq flow (line-flow size))
			(when (> index 0)
				;indent
				(def (defq indent (Backdrop)) :min_width indent_width)
				(. flow :add_child indent)
				(setq w (+ w indent_width)))
			(. flow :add_child text)
			(setq cnt w))) (list words)))

(defun blank-line ()
	(def (defq text (Text)) :text "")
	(. page :add_child text))

(defun under-line (size)
	(def (defq backdrop (Backdrop)) :color +argb_black :min_height size)
	(. page :add_child backdrop))

(defun handler (state page line)
	; (handler state page line) -> state
	(defq words '())
	(cond
		((starts-with "```" line)
			;section start
			(if (eql (setq state (sym (cat ":" (slice 3 -1 line)))) :) :code state))
		(t	;body text
			(cond
				((eql line "")
					;body paragraph end
					(when (> (length words) 0)
						(paragraph words)
						(blank-line)
						(clear words)))
				((starts-with "#### " line)
					(heading (line-words (slice 5 -1 line)) 22)
					(blank-line))
				((starts-with "### " line)
					(heading (line-words (slice 4 -1 line)) 26)
					(blank-line))
				((starts-with "## " line)
					(heading (line-words (slice 3 -1 line)) 30)
					(under-line 2)
					(blank-line))
				((starts-with "# " line)
					(heading (line-words (slice 2 -1 line)) 34)
					(under-line 4)
					(blank-line))
				(t	(each (lambda (word)
						(push words word)) (line-words line))))
			state)))

;module
(export (penv)
	handler)
(env-pop)