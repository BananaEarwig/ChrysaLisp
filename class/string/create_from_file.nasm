%include 'inc/func.inc'
%include 'inc/load.inc'
%include 'inc/string.inc'
%include 'class/class_string.inc'

	def_function class/string/create_from_file
		;inputs
		;r0 = c string pointer
		;outputs
		;r0 = 0 if error, else object
		;trashes
		;r1-r3, r5-r7

		;save c string pointer
		vp_cpy r0, r6

		;get size of string from file size
		s_bind sys_load, statics, r7
		vp_add ld_statics_stat_buffer, r7
		sys_stat r0, r7
		if r0, !=, 0
		exit:
			;no such file
			vp_xor r0, r0
			vp_ret
		endif

		;test for regular file only
		vp_cpy_us [r7 + stat_mode], r0
		vp_and s_ifmt, r0
		vp_jmpif r0, !=, s_ifreg, exit

		;create new string object
		vp_cpy [r7 + stat_fsize], r1
		s_call string, new, {&[r1 + string_size + 1]}, {r0}
		if r0, !=, 0
			;init the object
			slot_function class, string
			s_call string, init2, {r0, @_function_, r6, [r7 + stat_fsize]}, {r1}
			if r1, ==, 0
				;error with init
				m_call string, delete, {r0}, {}, r1
				vp_xor r0, r0
			endif
		endif
		vp_ret

	def_function_end
