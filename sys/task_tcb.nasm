%include 'inc/func.inc'
%include 'inc/task.inc'

	def_function sys/task_tcb
		;outputs
		;r0 = current task tcb

		s_bind sys_task, statics, r0
		vp_cpy [r0 + tk_statics_current_tcb], r0
		vp_ret

	def_function_end
