%include 'inc/func.inc'
%include 'inc/heap.inc'

	def_function sys/heap_init
		;inputs
		;r0 = heap
		;r1 = cell size
		;r2 = block size
		;outputs
		;r0 = heap
		;r1 = cell size
		;r2 = block size

		vp_cpy_cl 0, [r0 + hp_heap_free_flist]
		vp_cpy_cl 0, [r0 + hp_heap_block_flist]
		vp_add ptr_size - 1, r1
		vp_and -ptr_size, r1
		vp_cpy r1, [r0 + hp_heap_cellsize]
		vp_cpy r2, [r0 + hp_heap_blocksize]
		vp_ret

	def_function_end
