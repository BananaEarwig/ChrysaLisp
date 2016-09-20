%include 'inc/func.inc'
%include 'inc/mail.inc'
%include 'class/class_string.inc'

	def_function sys/task_open_remote
		;inputs
		;r0 = name string object
		;r1 = cpu target
		;outputs
		;r0, r1 = mailbox id
		;trashes
		;all but r4

		ptr name, msg
		ulong cpu
		struct id, id
		struct mailbox, mailbox

		;save task info
		push_scope
		retire {r0, r1}, {name, cpu}

		;init temp mailbox
		static_call sys_mail, init_mailbox, {&mailbox}

		;start task
		static_call sys_mail, alloc, {}, {msg}
		assign {name->string_length + 1 + kn_msg_child_size}, {msg->msg_length}
		assign {0}, {msg->msg_dest.id_mbox}
		assign {cpu}, {msg->msg_dest.id_cpu}
		assign {&mailbox}, {msg->kn_msg_reply_id.id_mbox}
		static_call sys_cpu, id, {}, {msg->kn_msg_reply_id.id_cpu}
		assign {kn_call_task_child}, {msg->kn_msg_function}
		static_call sys_mem, copy, {&name->string_data, &msg->kn_msg_child_pathname, \
									name->string_length + 1}, {_, _}
		static_call sys_mail, send, {msg}

		;wait for reply
		static_call sys_mail, read, {&mailbox}, {msg}
		assign {msg->kn_msg_reply_id.id_mbox}, {id.id_mbox}
		assign {msg->kn_msg_reply_id.id_cpu}, {id.id_cpu}
		static_call sys_mem, free, {msg}

		;return ids array
		eval {id.id_mbox, id.id_cpu}, {r0, r1}
		pop_scope
		vp_ret

	def_function_end
