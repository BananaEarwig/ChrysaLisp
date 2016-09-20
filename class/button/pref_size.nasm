%include 'inc/func.inc'
%include 'class/class_button.inc'

	def_function class/button/pref_size
		;inputs
		;r0 = button object
		;outputs
		;r10 = prefered width
		;r11 = prefered height
		;trashes
		;all but r0, r4

		p_call button, pref_size, {r0}, {r10, r11}
		vp_add button_border_size * 2, r10
		vp_add button_border_size * 2, r11
		vp_ret

	def_function_end
