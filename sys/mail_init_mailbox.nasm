%include 'inc/func.inc'

	def_function sys/mail_init_mailbox
		;outputs
		;r0 = mailbox address
		;trashes
		;r1-r2

		ml_init r0, r1, r2
		vp_ret

	def_function_end
