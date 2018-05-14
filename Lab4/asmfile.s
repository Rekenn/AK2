.data
.text
.global strong_code

.type strong_code, @function

# int strong_code (char * txt, int len)
strong_code:
	push %rbp
	mov %rsp, %rbp
	
	mov 16(%rbp), %rcx		# len
	mov 24(%rbp), %r10		# txt
	mov $0, %r8				# decoded number here
	mov $1, %r9				# multipler	
	mov $1, %rbx			# incr
	
	dec %rcx
	
	decode_loop:
		mov $0, %rax
		mov (%r10, %rcx, 1), %al
		sub $0x30, %al
		mul %r9
		add %rax, %r8

		mov %r9, %rax
		mul %rbx
		mov %rax, %r9
		inc %rbx
		
		dec %rcx
		cmp $0, %rcx
		jge decode_loop

	mov %r8, %rax
	mov %rbp, %rsp
	pop %rbp
	ret
