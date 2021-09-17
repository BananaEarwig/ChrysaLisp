(import "sys/lisp.inc")
(import "class/lisp.inc")
(import "lib/consts/chars.inc")
(import "lib/math/mesh.inc")
(import "./app.inc")

(enums +select 0
	(enum main timeout))

(defun create-mesh (key mbox name command)
	(defq mesh (exec (elem 0 (read (string-stream command) +char_space)))
		verts (. mesh :get_verts) norms (. mesh :get_norms) tris (. mesh :get_tris)
		reply_list (list))
	(push reply_list
		(char key +long_size)
		(char (length verts) +int_size)
		(char (length norms) +int_size)
		(char (length tris) +int_size)
		name)
	(each (# (each (# (push reply_list (char %1 +long_size))) %0)) verts)
	(each (# (each (# (push reply_list (char %1 +long_size))) %0)) norms)
	(each (# (each (# (push reply_list (char %1 +int_size))) %0)) tris)
	(mail-send mbox (apply cat reply_list)))

(defun main ()
	(defq select (alloc-select +select_size) running t +timeout 5000000)
	(while running
		(mail-timeout (elem +select_timeout select) +timeout 0)
		(defq msg (mail-read (elem (defq idx (mail-select select)) select)))
		(cond
			((or (= idx +select_timeout) (eql msg ""))
				;timeout or quit
				(setq running nil))
			((= idx +select_main)
				;main mailbox, reset timeout and reply with mesh data
				(mail-timeout (elem +select_timeout select) 0 0)
				(defq key (getf msg +job_key)
					reply (getf msg +job_reply)
					name (slice +job_name +job_command msg)
					command (slice +job_command -1 msg))
				(create-mesh key reply name command))))
	(free-select select))
