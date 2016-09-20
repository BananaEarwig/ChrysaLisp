%include 'inc/func.inc'

	def_function sys/string_compare
		;inputs
		;r0 = string1
		;r1 = string2
		;outputs
		;r0 = 0 if same, else -, +
		;trashes
		;r0-r3

		loop_start
			vp_cpy_ub [r0], r2
			vp_cpy_ub [r1], r3
			vp_sub r3, r2
			breakif r2, !=, 0
			breakif r3, ==, 0
			vp_inc r0
			vp_inc r1
		loop_end
		vp_cpy r2, r0
		vp_ret

	def_function_end
