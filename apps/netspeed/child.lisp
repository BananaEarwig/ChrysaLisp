;jit compile apps native functions
(jit "apps/netspeed/" "lisp.vp" '("vops"))

(import "./app.inc")

;native versions
(ffi vops "apps/netspeed/vops" 0)

(enums +select 0
	(enum main timeout))

(defun main ()
	(defq select (alloc-select +select_size) running :t +timeout 5000000)
	(while running
		(mail-timeout (elem-get +select_timeout select) +timeout 0)
		(defq msg (mail-read (elem-get (defq idx (mail-select select)) select)))
		(cond
			((or (= idx +select_timeout) (eql msg ""))
				;timeout or quit
				(setq running :nil))
			((= idx +select_main)
				;main mailbox, reset timeout and reply with info
				(mail-timeout (elem-get +select_timeout select) 0 0)
				(bind '(vops_regs vops_memory vops_reals) (vops))
				(mail-send msg (setf-> (str-alloc +reply_size)
					(+reply_node (slice +long_size -1 (task-netid)))
					(+reply_vops_regs vops_regs)
					(+reply_vops_memory vops_memory)
					(+reply_vops_reals vops_reals))))))
	(free-select select))
