%include 'inc/func.inc'

	def_function sys/string_length
		;inputs
		;r0 = string
		;outputs
		;r0 = string
		;r1 = string len
		;trashes
		;r2

		vp_cpy r0, r1
		loop_start
			vp_cpy_ub [r1], r2
			breakif r2, ==, 0
			vp_inc r1
		loop_end
		vp_sub r0, r1
		vp_ret

	def_function_end
