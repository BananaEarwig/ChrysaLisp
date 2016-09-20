%include 'inc/func.inc'
%include 'inc/gui.inc'

	def_function gui/region_copy_rect
		;inputs
		;r0 = region heap pointer
		;r1 = source region listhead pointer
		;r2 = dest region listhead pointer
		;r8 = x (pixels)
		;r9 = y (pixels)
		;r10 = x1 (pixels)
		;r11 = y1 (pixels)
		;trashes
		;r1-r2, r5-r15

		;check for any obvious errors in inputs
		if r10, >, r8
			if r11, >, r9
				;run through source region list
				vp_cpy r2, r5
				loop_flist_forward r1, r7, r7
					;not in contact ?
					vp_cpy_i [r7 + gui_rect_x], r12
					continueif r12, >=, r10
					vp_cpy_i [r7 + gui_rect_y], r13
					continueif r13, >=, r11
					vp_cpy_i [r7 + gui_rect_x1], r14
					continueif r8, >=, r14
					vp_cpy_i [r7 + gui_rect_y1], r15
					continueif r9, >=, r15

					s_call sys_heap, alloc, {r0}, {r1}
					continueif r1, ==, 0
					ln_add_fnode r5, r1, r2

					;jump to correct splitting code
					vp_jmpif r12, >=, r8, copy_split1
					vp_jmpif r13, >=, r9, copy_split2
					vp_jmpif r10, >=, r14, copy_split4
					vp_jmpif r11, >=, r15, copy_xyx1

				copy_xyx1y1:
					;r8 + r9 + r10 + r11 inside
					vp_cpy_i r8, [r1 + gui_rect_x]
					vp_cpy_i r9, [r1 + gui_rect_y]
					vp_cpy_i r10, [r1 + gui_rect_x1]
					vp_cpy_i r11, [r1 + gui_rect_y1]
					continue

				copy_split1:
					;jump to correct splitting code
					vp_jmpif r13, >=, r9, copy_split3
					vp_jmpif r10, >=, r14, copy_split5
					vp_jmpif r11, >=, r15, copy_yx1

				copy_yx1y1:
					;r9 + r10 + r11 inside
					vp_cpy_i r12, [r1 + gui_rect_x]
					vp_cpy_i r9, [r1 + gui_rect_y]
					vp_cpy_i r10, [r1 + gui_rect_x1]
					vp_cpy_i r11, [r1 + gui_rect_y1]
					continue

				copy_split2:
					;jump to correct splitting code
					vp_jmpif r10, >=, r14, copy_split6
					vp_jmpif r11, >=, r15, copy_xx1

				copy_xx1y1:
					;r8 + r10 + r11 inside
					vp_cpy_i r8, [r1 + gui_rect_x]
					vp_cpy_i r13, [r1 + gui_rect_y]
					vp_cpy_i r10, [r1 + gui_rect_x1]
					vp_cpy_i r11, [r1 + gui_rect_y1]
					continue

				copy_split3:
					;jump to correct splitting code
					vp_jmpif r10, >=, r14, copy_split7
					vp_jmpif r11, >=, r15, copy_x1

				copy_x1y1:
					;r10 + r11 inside
					vp_cpy_i r12, [r1 + gui_rect_x]
					vp_cpy_i r13, [r1 + gui_rect_y]
					vp_cpy_i r10, [r1 + gui_rect_x1]
					vp_cpy_i r11, [r1 + gui_rect_y1]
					continue

				copy_split4:
					;jump to correct splitting code
					vp_jmpif r11, >=, r15, copy_xy

				copy_xyy1:
					;r8 + r9 + r11 inside
					vp_cpy_i r8, [r1 + gui_rect_x]
					vp_cpy_i r9, [r1 + gui_rect_y]
					vp_cpy_i r14, [r1 + gui_rect_x1]
					vp_cpy_i r11, [r1 + gui_rect_y1]
					continue

				copy_split5:
					;jump to correct splitting code
					vp_jmpif r11, >=, r15, copy_y

				copy_yy1:
					;r9 + r11 inside
					vp_cpy_i r12, [r1 + gui_rect_x]
					vp_cpy_i r9, [r1 + gui_rect_y]
					vp_cpy_i r14, [r1 + gui_rect_x1]
					vp_cpy_i r11, [r1 + gui_rect_y1]
					continue

				copy_split6:
					;jump to correct splitting code
					vp_jmpif r11, >=, r15, copy_x

				copy_xy1:
					;r8 + r11 inside
					vp_cpy_i r8, [r1 + gui_rect_x]
					vp_cpy_i r13, [r1 + gui_rect_y]
					vp_cpy_i r14, [r1 + gui_rect_x1]
					vp_cpy_i r11, [r1 + gui_rect_y1]
					continue

				copy_split7:
					;jump to correct splitting code
					vp_jmpif r11, >=, r15, copy_encl

				copy_y1:
					;r11 inside
					vp_cpy_i r12, [r1 + gui_rect_x]
					vp_cpy_i r13, [r1 + gui_rect_y]
					vp_cpy_i r14, [r1 + gui_rect_x1]
					vp_cpy_i r11, [r1 + gui_rect_y1]
					continue

				copy_xyx1:
					;r8 + r9 + r10 inside
					vp_cpy_i r8, [r1 + gui_rect_x]
					vp_cpy_i r9, [r1 + gui_rect_y]
					vp_cpy_i r10, [r1 + gui_rect_x1]
					vp_cpy_i r15, [r1 + gui_rect_y1]
					continue

				copy_encl:
					;region is enclosed
					vp_cpy_i r12, [r1 + gui_rect_x]
					vp_cpy_i r13, [r1 + gui_rect_y]
					vp_cpy_i r14, [r1 + gui_rect_x1]
					vp_cpy_i r15, [r1 + gui_rect_y1]
					continue

				copy_x:
					;r8 inside
					vp_cpy_i r8, [r1 + gui_rect_x]
					vp_cpy_i r13, [r1 + gui_rect_y]
					vp_cpy_i r14, [r1 + gui_rect_x1]
					vp_cpy_i r15, [r1 + gui_rect_y1]
					continue

				copy_y:
					;r9 inside
					vp_cpy_i r12, [r1 + gui_rect_x]
					vp_cpy_i r9, [r1 + gui_rect_y]
					vp_cpy_i r14, [r1 + gui_rect_x1]
					vp_cpy_i r15, [r1 + gui_rect_y1]
					continue

				copy_xy:
					;r8 + r9 inside
					vp_cpy_i r8, [r1 + gui_rect_x]
					vp_cpy_i r9, [r1 + gui_rect_y]
					vp_cpy_i r14, [r1 + gui_rect_x1]
					vp_cpy_i r15, [r1 + gui_rect_y1]
					continue

				copy_x1:
					;r10 inside
					vp_cpy_i r12, [r1 + gui_rect_x]
					vp_cpy_i r13, [r1 + gui_rect_y]
					vp_cpy_i r10, [r1 + gui_rect_x1]
					vp_cpy_i r15, [r1 + gui_rect_y1]
					continue

				copy_xx1:
					;r8 + r10 inside
					vp_cpy_i r8, [r1 + gui_rect_x]
					vp_cpy_i r13, [r1 + gui_rect_y]
					vp_cpy_i r10, [r1 + gui_rect_x1]
					vp_cpy_i r15, [r1 + gui_rect_y1]
					continue

				copy_yx1:
					;r9 + r10 inside
					vp_cpy_i r12, [r1 + gui_rect_x]
					vp_cpy_i r9, [r1 + gui_rect_y]
					vp_cpy_i r10, [r1 + gui_rect_x1]
					vp_cpy_i r15, [r1 + gui_rect_y1]
				loop_end
			endif
		endif
		vp_ret

	def_function_end
