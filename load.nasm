%include "vp.inc"
%include "code.inc"
%include "syscall.inc"
%include "func.inc"

;;;;;;;;;;;
; load code
;;;;;;;;;;;

	SECTION .text

	LD_BLOCK_SIZE	equ 16384

ld_init_loader:
	vp_cpy ld_function_list, r0
	lh_init r0, r1
	vp_ret

ld_deinit_loader:
	vp_cpy r0, r2
	vp_cpy ld_block_list, r1
	vp_cpy [r1], r1
	loopstart
		breakif r1, ==, 0
		vp_cpy [r1], r3
		sys_munmap r1, LD_BLOCK_SIZE
		vp_cpy r3, r1
	loopend
	vp_ret

ld_strcmp_callback:
	;callback
	;inputs
	;r0 = list head
	;r1 = user callback
	;r2 = user data pointer
	;r3 = list node
	;outputs
	;r0 = list head
	;r1 = user callback
	;r2 = user data pointer
	;r5 = 0, else function entry
	;trashes
	;r3

	vp_push r0
	vp_push r1
	vp_push r2
	vp_cpy r3, r5
	vp_cpy r2, r0
	vp_lea [r3 + FN_HEADER_PATHNAME], r1
	vp_call string_compare
	if r0, ==, 0
		xor r5, r5
	else
		vp_add [r5 + FN_HEADER_ENTRY], r5
	endif
	vp_pop r2
	vp_pop r1
	vp_pop r0
	vp_ret

ld_load_function:
	;input
	;r0 = function path name
	;output
	;r0 = 0 else, function entry pointer
	;trashes
	;r1-r3, r5-r7

	;save pathname
	vp_cpy r0, r7

	;check if function allready present !
	vp_cpy r0, r2
	vp_cpy ld_function_list, r0
	vp_cpy ld_strcmp_callback, r1
	vp_call lh_enumerate_forwards
	if r5, !=, 0
		;found function allready loaded
		vp_cpy r5, r0
		vp_ret
	endif

	;get length of function on disk
	sys_stat r7, ld_stat_buffer
	if r0, !=, 0
		;no such file
		xor r0, r0
		vp_ret
	endif

	;ensure space for new function
	vp_cpy ld_block_start, r1
	vp_cpy [r1], r1
	vp_cpy ld_block_end, r2
	vp_cpy [r2], r2
	vp_sub r1, r2
	vp_cpy ld_stat_buffer, r0
	vp_cpy [r0 + STAT_FSIZE], r0
	if r2, <, r0
		;not enough so allcate new function buffer
		sys_mmap 0, LD_BLOCK_SIZE, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANON, -1, 0

		;add to block list for freeing
		vp_cpy ld_block_list, r1
		vp_cpy [r1], r3
		vp_cpy r3, [r0]
		vp_cpy r0, [r1]

		;set block pointers for loading
		vp_add 8, r0
		vp_cpy ld_block_start, r1
		vp_cpy r0, [r1]
		vp_add LD_BLOCK_SIZE - 8, r0
		vp_cpy ld_block_end, r1
		vp_cpy r0, [r1]
	endif

	;open function file
	sys_open r7, O_RDONLY, 0
	vp_cpy r0, r12

	;read into buffer
	vp_cpy ld_block_start, r1
	vp_cpy ld_stat_buffer, r2
	vp_cpy [r1], r3
	sys_read r12, r3, [r2 + STAT_FSIZE]

	;close function file
	sys_close r12

	;add to function list
	vp_cpy ld_function_list, r0
	lh_add_at_head r0, r3, r1

	;adjust block start
	vp_cpy r3, r0
	vp_cpy ld_block_start, r1
	vp_add [r2 + STAT_FSIZE], r0
	vp_cpy r0, [r1]

	;load and link function references
	vp_cpy r3, r0
	vp_add [r3 + FN_HEADER_LINKS], r0
	loopstart
		vp_cpy [r0], r1
		breakif r1, ==, 0
		vp_lea [r0 + 8], r0
		vp_push r0
		vp_push r3
		vp_call ld_load_function
		vp_cpy r0, r1
		vp_pop r3
		vp_pop r0
		vp_cpy r1, [r0 - 8]
		vp_call string_length
		vp_add r1, r0
		vp_add 7, r0
		vp_and -8, r0
	loopend

	;return function address
	vp_cpy r3, r0
	vp_add [r3 + FN_HEADER_ENTRY], r0
	vp_ret

;;;;;;;;;;;
; load data
;;;;;;;;;;;

	SECTION .data

	lh_list_object ld_function_list
ld_block_list:
	dq	0
ld_block_start:
	dq	0
ld_block_end:
	dq	0
ld_stat_buffer:
	times STAT_SIZE db 0
