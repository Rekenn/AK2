.data
status_word: .short 0
control_word: .short 0

.text
.global set, check
.type set, @function
.type check, @function

set:
	push %rbp
	mov %rsp, %rbp

	mov $0, %rax
	fstcw control_word

	mov control_word, %ax

	xor %rdi, %rax

	mov %ax, control_word
	fldcw control_word


	mov %rbp, %rsp
	pop %rbp
	ret

check:
	push %rbp
	mov %rsp, %rbp

	fclex

	cmp $2, %rdi
	je div_0
	jmp no_exception

	div_0:
		fldz
		fld1
		fdiv %st, %st(1)

	no_exception:
		mov $0, %rax
		fstsw status_word
		mov status_word, %ax

		and $127, %ax

	mov %rbp, %rsp
	pop %rbp
	ret
