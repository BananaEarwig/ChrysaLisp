%include 'inc/func.inc'
%include 'class/class_window.inc'
%include 'class/class_flow.inc'

	def_function class/window/pref_size
		;inputs
		;r0 = window object
		;outputs
		;r10 = prefered width
		;r11 = prefered height
		;trashes
		;all but r0, r4

		def_structure local
			ptr local_inst
		def_structure_end

		;save inputs
		vp_sub local_size, r4
		set_src r0
		set_dst [r4 + local_inst]
		map_src_to_dst

		m_call flow, pref_size, {[r0 + window_flow]}, {r10, r11}
		vp_add window_border_size * 2, r10
		vp_add window_border_size * 2, r11

		vp_cpy [r4 + local_inst], r0
		vp_add local_size, r4
		vp_ret

	def_function_end
