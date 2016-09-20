%include 'inc/func.inc'
%include 'class/class_title.inc'

	def_function class/title/pref_size
		;inputs
		;r0 = flow object
		;outputs
		;r10 = prefered width
		;r11 = prefered height
		;trashes
		;all but r0, r4

		p_call title, pref_size, {r0}, {r10, r11}
		vp_add title_border_size * 2, r10
		vp_add title_border_size * 2, r11
		vp_ret

	def_function_end
