%include 'inc/func.inc'
%include 'inc/gui.inc'
%include 'inc/font.inc'
%include 'class/class_text.inc'
%include 'class/class_string.inc'
%include 'class/class_vector.inc'

	def_function class/text/draw
		;inputs
		;r0 = view object
		;r1 = ctx object
		;trashes
		;all but r0, r4

		ptr inst, ctx, txt
		pptr words, words_end
		ulong length
		long x

		;save inputs
		push_scope
		retire {r0, r1}, {inst, ctx}

		;draw text
		if {inst->text_string && inst->text_font}
			assign {inst->text_words->vector_array}, {words}
			static_call vector, get_length, {inst->text_words}, {length}
			assign {&words[length * ptr_size]}, {words_end}
			assign {0}, {x}
			loop_start
				static_call gui_font, text, {inst->text_font, &(*words)->string_data}, {txt}
				if {txt}
					static_call gui_ctx, blit, {ctx, txt->ft_text_texture, inst->text_text_color, \
												x, 0, txt->ft_text_width, txt->ft_text_height}
					assign {x + txt->ft_text_width + (txt->ft_text_height >> 2)}, {x}
				endif
				assign {words + ptr_size}, {words}
			loop_until {words == words_end}
		endif

		eval {inst}, {r0}
		pop_scope
		return

	def_function_end
