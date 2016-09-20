%include 'inc/func.inc'
%include 'class/class_view.inc'

	def_function class/view/dirty
		;inputs
		;r0 = view object
		;trashes
		;all but r0, r4

		;paste dirty region
		s_jmp view, add_dirty, {r0, 0, 0, [r0 + view_w], [r0 + view_h]}

	def_function_end
