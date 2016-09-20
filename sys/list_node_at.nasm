%include 'inc/func.inc'
%include 'inc/list.inc'

	def_function sys/list_node_at
		;inputs
		;r0 = list head
		;r1 = index
		;outputs
		;r0 = 0, else list node
		;trashes
		;r1, r2

		lh_get_head r0, r2
		loop_start
			vp_cpy r2, r0
			ln_get_succ r2, r2
			if r2, ==, 0
				vp_xor r0, r0
				vp_ret
			endif
			breakif r1, ==, 0
			vp_dec r1
		loop_end
		vp_ret

	def_function_end
