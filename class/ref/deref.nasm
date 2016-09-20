%include 'inc/func.inc'
%include 'class/class_ref.inc'

	def_function class/ref/deref
		;inputs
		;r0 = object
		;trashes
		;all but r4

		;dec ref count
		vp_cpy [r0 + ref_count], r1
		vp_dec r1
		vp_cpy r1, [r0 + ref_count]

		;destroy if 0
		if r1, ==, 0
			s_jmp ref, destroy, {r0}
		endif
		vp_ret

	def_function_end
