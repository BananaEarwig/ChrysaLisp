;;;;;;;;;;;;;;;;;;;;
; text buffer object
;;;;;;;;;;;;;;;;;;;;

(import "lib/text/syntax.inc")
(import "lib/consts/chars.inc")

;module
(env-push)

(defmacro mutate-buffer (&rest _)
	`(progn
		(bind '(x y) (. this :get_cursor))
		(bind '(x y) (. this :constrain x y))
		(defq buffer (get :buffer this)
			buffer_colored (get :buffer_colored this)
			buffer_states (get :buffer_states this)
			h (length buffer))
		~_
		(clear (get :redo_stack this))
		(set this :buffer buffer :buffer_colored buffer_colored
			:buffer_states buffer_states :dirty t)
		(. this :set_cursor x y)))

(defmacro select-buffer (&rest _)
	`(progn
		(bind '(x y) (. this :get_cursor))
		(bind '(sx sy) (. this :constrain x y))
		(bind '(sx1 sy1) (. this :constrain anchor_x anchor_y))
		(if (> sy sy1)
			(defq sx (logxor sx sx1) sx1 (logxor sx sx1) sx (logxor sx sx1)
				sy (logxor sy sy1) sy1 (logxor sy sy1) sy (logxor sy sy1)))
		(and (= sy sy1) (> sx sx1)
			(defq sx (logxor sx sx1) sx1 (logxor sx sx1) sx (logxor sx sx1)))
		(cond
			((and (= sx sx1) (= sy sy1)) "")
			(t	~_))))

(defun redo ()
	(. this :set_cursor x y)
	(case state
		(:break (. this :break))
		(:backspace (. this :backspace data))
		(:insert (. this :insert data))
		(:cursor (push undo_stack (list :cursor x y)))))

(defun undo ()
	(redo)
	(push redo_stack (pop undo_stack)))

(defclass Buffer () nil
	; (Buffer) -> buffer
	(def this :buffer (list) :buffer_colored (list) :buffer_states (list)
		:dirty nil :syntax (Syntax) :undo_stack (list) :redo_stack (list)
		:cursor_x 0 :cursor_y 0 :max_width 0 :tab_width 4)

	(defmethod :set_cursor (this x y)
		; (. buffer :set_cursor x y) -> buffer
		(set this :cursor_x x :cursor_y y)
		this)

	(defmethod :get_cursor (this)
		; (. buffer :get_cursor) -> (x y)
		(list (get :cursor_x this) (get :cursor_y this)))

	(defmethod :get_size (this)
		; (. buffer :get_size) -> (width height)
		(list (get :max_width this) (length (get :buffer this))))

	(defmethod :file_load (this filepath)
		; (. buffer :file_load filepath) -> buffer
		(defq syntax (get :syntax this)
			buffer (list) buffer_colored (list) buffer_states (list)
			max_width 0 tab_width (get :tab_width this))
		(each-line (lambda (line)
				(setq line (. syntax :expand_tabs
						(trim line (const (char +char_cr))) tab_width)
					max_width (max max_width (length line)))
				(push buffer line)
				(push buffer_colored line)
				(push buffer_states '(nil nil)))
			(file-stream filepath))
		(clear (get :undo_stack this) (get :redo_stack this))
		(set this :buffer buffer :buffer_colored buffer_colored
			:buffer_states buffer_states :max_width max_width
			:cursor_x 0 :cursor_y 0 :dirty t)
		this)

	(defmethod :file_save (this filepath)
		; (. buffer :file_save filepath) -> buffer
		(defq syntax (get :syntax this) tab_width (get :tab_width this)
			stream (file-stream filepath +file_open_write))
		(each (lambda (line)
				(write-line stream (. syntax :compress_tabs line tab_width)))
			(get :buffer this))
		this)

	(defmethod :trim (this)
		; (. buffer :trim) -> buffer
		(when (> (length (get :buffer this)) 0)
			(bind '(x y) (. this :get_cursor))
			(bind '(x y) (. this :constrain x y))
			(push (defq undo_stack (get :undo_stack this)) '(:mark) (list :cursor x y))
			;trim front
			(while (and (> (length (get :buffer this)) 0) (eql (elem 0 (get :buffer this)) ""))
				(.-> this (:set_cursor 0 0) :delete))
			;trim end
			(while (and (> (length (get :buffer this)) 0) (eql (elem -2 (get :buffer this)) ""))
				(.-> this (:set_cursor 0 (dec (length (get :buffer this)))) :backspace))
			;trim lines
			(each (lambda (line)
				(unless (eql (defq trimed_line (trim-end line)) line)
					(.-> this
						(:set_cursor (length trimed_line) _)
						(:delete (- (length line) (length trimed_line)))))) (get :buffer this))
			(push undo_stack '(:mark))
			(. this :set_cursor x y)))

	(defmethod :vdu_load (this vdu scroll_x scroll_y)
		; (. buffer :vdu_load vdu scroll_x scroll_y) -> buffer
		(when (get :dirty this)
			(defq syntax (get :syntax this)
				buffer (get :buffer this)
				buffer_colored (get :buffer_colored this)
				buffer_states (get :buffer_states this)
				state :text max_width 0)
			(each (lambda (line line_array (start_state end_state))
					(setq max_width (max max_width (length line)))
					(cond
						((and (array? line_array) (eql state start_state))
							(setq state end_state))
						(t	(elem-set _ buffer_colored
								(.-> syntax (:set_state state) (:colorise line)))
							(elem-set _ buffer_states
								(list state (setq state (. syntax :get_state)))))))
				buffer buffer_colored buffer_states)
			(set this :max_width max_width :dirty nil))
		(. vdu :load
			(get :buffer_colored this)
			scroll_x scroll_y (get :cursor_x this) (get :cursor_y this))
		this)

	(defmethod :constrain (this x y)
		; (. buffer :constrain x y) -> (list x y)
		(defq buffer (get :buffer this) h (length buffer))
		(cond
			((< y 0) (setq x 0 y 0))
			((>= y h) (setq x 0 y h))
			((< x 0) (setq x 0))
			((> x (length (elem y buffer))) (setq x (length (elem y buffer)))))
		(list x y))

	(defmethod :left (this)
		; (. buffer :left) -> buffer
		(bind '(x y) (. this :get_cursor))
		(if (< (setq x (dec x)) 0)
			(if (< (setq y (dec y)) 0)
				(setq x 0)
				(setq x +max_int)))
		(bind '(x y) (. this :constrain x y))
		(. this :set_cursor x y))

	(defmethod :right (this)
		; (. buffer :right) -> buffer
		(bind '(x y) (. this :get_cursor))
		(defq buffer (get :buffer this) h (length buffer)
			w (if (>= y h) 0 (length (elem y buffer))))
		(if (> (setq x (inc x)) w)
			(if (> (setq y (inc y)) h)
				(setq x +max_int)
				(setq x 0)))
		(bind '(x y) (. this :constrain x y))
		(. this :set_cursor x y))

	(defmethod :down (this)
		; (. buffer :down) -> buffer
		(bind '(x y) (. this :get_cursor))
		(bind '(x y) (. this :constrain x (inc y)))
		(. this :set_cursor x y))

	(defmethod :up (this)
		; (. buffer :up) -> buffer
		(bind '(x y) (. this :get_cursor))
		(bind '(x y) (. this :constrain x (dec y)))
		(. this :set_cursor x y))

	(defmethod :break (this)
		; (. buffer :break) -> buffer
		(mutate-buffer
			(cond
				((>= y h)
					(setq buffer (insert buffer y '("")))
					(setq buffer_colored (insert buffer_colored y '("")))
					(setq buffer_states (insert buffer_states y '((nil nil)))))
				(t	(defq front (slice 0 x (elem y buffer))
						back (slice x -1 (elem y buffer)))
					(elem-set y buffer front)
					(elem-set y buffer_colored front)
					(elem-set y buffer_states '(nil nil))
					(setq buffer (insert buffer (inc y) (list back)))
					(setq buffer_colored (insert buffer_colored (inc y) (list back)))
					(setq buffer_states (insert buffer_states (inc y) '((nil nil))))))
			(setq x 0 y (inc y))
			(push (get :undo_stack this) (list :backspace x y))))

	(defmethod :backspace (this &optional num)
		; (. buffer :backspace &optional num) -> buffer
		(mutate-buffer
			(setd num 1)
			(cond
				((and (<= x 0) (<= y 0)))
				((>= y h)
					(setq y (dec y) x (length (elem y buffer)))
					(when (<= x 0)
						(pop buffer) (pop buffer_colored) (pop buffer_states)
						(push (get :undo_stack this) (list :break x y))))
				((<= x 0)
					(setq y (dec y) x (length (elem y buffer)))
					(elem-set y buffer (cat (elem y buffer) (elem (inc y) buffer)))
					(elem-set y buffer_colored (elem y buffer))
					(setq buffer (erase buffer (inc y) (+ y 2)))
					(setq buffer_colored (erase buffer_colored (inc y) (+ y 2)))
					(setq buffer_states (erase buffer_states (inc y) (+ y 2)))
					(push (get :undo_stack this) (list :break x y)))
				(t	(defq undo (slice (- x num) x (elem y buffer)))
					(elem-set y buffer (erase (elem y buffer) (- x num) x))
					(elem-set y buffer_colored (elem y buffer))
					(setq x (- x num))
					(push (get :undo_stack this) (list :insert x y undo))))))

	(defmethod :delete (this &optional num)
		; (. buffer :delete &optional num) -> buffer
		(mutate-buffer
			(setd num 1)
			(cond
				((>= y h))
				((>= x (length (elem y buffer)))
					(when (< y (dec h))
						(elem-set y buffer (cat (elem y buffer) (elem (inc y) buffer)))
						(elem-set y buffer_colored (elem y buffer))
						(setq buffer (erase buffer (inc y) (+ y 2)))
						(setq buffer_colored (erase buffer_colored (inc y) (+ y 2)))
						(setq buffer_states (erase buffer_states (inc y) (+ y 2)))
						(push (get :undo_stack this) (list :break x y))))
				(t	(defq undo (slice x (+ x num) (elem y buffer)))
					(elem-set y buffer (erase (elem y buffer) x (+ x num)))
					(elem-set y buffer_colored (elem y buffer))
					(push (get :undo_stack this) (list :insert x y undo))))))

	(defmethod :insert (this string)
		; (. buffer :insert string) -> buffer
		(mutate-buffer
			(cond
				((>= y h)
					(setq buffer (insert buffer y (list string)))
					(setq buffer_colored (insert buffer_colored y (list string)))
					(setq buffer_states (insert buffer_states y '((nil nil)))))
				(t	(elem-set y buffer (insert (elem y buffer) x string))
					(elem-set y buffer_colored (elem y buffer))))
			(setq x (+ x (length string)))
			(push (get :undo_stack this) (list :backspace x y (length string)))))

	(defmethod :cut (this anchor_x anchor_y)
		; (. buffer :cut anchor_x anchor_y) -> string
		(select-buffer
			(push (defq undo_stack (get :undo_stack this)) '(:mark) (list :cursor x y))
			(defq lines (list))
			(. this :set_cursor sx sy)
			(cond
				((= sy sy1)
					(push lines (slice sx sx1 (elem sy (get :buffer this))))
					(. this :delete (- sx1 sx)))
				(t	(while (<= sy (setq sy1 (dec sy1)))
						(push lines (slice sx -1 (elem sy (get :buffer this))) (ascii-char +char_lf))
						(if (> (defq gap (- (length (elem sy (get :buffer this))) sx)) 0)
							(. this :delete gap))
						(. this :delete))
					(when (and (> sx1 0) (< sy (length (get :buffer this))))
						(push lines (slice sx (+ sx sx1) (elem sy (get :buffer this))))
						(. this :delete sx1))))
			(push undo_stack '(:mark))
			(apply cat lines)))

	(defmethod :copy (this anchor_x anchor_y)
		; (. buffer :copy anchor_x anchor_y) -> string
		(select-buffer
			(defq buffer (get :buffer this))
			(cond
				((= sy sy1)
					(slice sx sx1 (elem sy buffer)))
				(t	(defq lines
						(list (slice sx -1 (elem sy buffer)) (ascii-char +char_lf)))
					(while (< (setq sy (inc sy)) sy1)
						(push lines (elem sy buffer) (ascii-char +char_lf)))
					(apply cat (push lines
						(if (>= sy (length buffer))
							(ascii-char +char_lf)
							(slice 0 sx1 (elem sy buffer)))))))))

	(defmethod :paste (this string)
		; (. buffer :paste string) -> this
		(push (defq undo_stack (get :undo_stack this)) '(:mark))
		(while (defq idx (find (ascii-char +char_lf) string))
			(when (> idx 0)
				(. this :insert (slice 0 idx string)))
			(. this :break)
			(setq string (slice (inc idx) -1 string)))
		(if (> (length string) 0) (. this :insert string))
		(push undo_stack '(:mark))
		this)

	(defmethod :undo (this)
		; (. buffer :undo) -> buffer
		(when (defq data (pop (defq undo_stack (get :undo_stack this))))
			(defq redo_stack (cat (get :redo_stack this)))
			(bind '(state &optional x y data) data)
			(cond
				((eql state :mark)
					(push redo_stack '(:mark))
					(bind '(state &optional x y data) (pop undo_stack))
					(until (eql state :mark)
						(undo)
						(bind '(state &optional x y data) (pop undo_stack)))
					(push redo_stack '(:mark)))
				(t	(undo)))
			(set this :redo_stack redo_stack))
		this)

	(defmethod :redo (this)
		; (. buffer :redo) -> buffer
		(when (defq data (pop (defq redo_stack (get :redo_stack this))))
			(defq undo_stack (get :undo_stack this) redo_stack (cat redo_stack))
			(bind '(state &optional x y data) data)
			(cond
				((eql state :mark)
					(push undo_stack '(:mark))
					(bind '(state &optional x y data) (pop redo_stack))
					(until (eql state :mark)
						(redo)
						(bind '(state &optional x y data) (pop redo_stack)))
					(push undo_stack '(:mark)))
				(t	(redo)))
			(set this :redo_stack redo_stack))
		this)
	)

;module
(export (penv)
	*class_Buffer* Buffer Buffer?)
(env-pop)