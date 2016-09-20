%include 'inc/func.inc'
%include 'class/class_view.inc'

	def_function class/view/pref_size
		;inputs
		;r0 = view object
		;outputs
		;r10 = prefered width
		;r11 = prefered height
		;trashes
		;all but r0, r4

		vp_cpy [r0 + view_w], r10
		vp_cpy [r0 + view_h], r11
		vp_ret

	def_function_end
