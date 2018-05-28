.data
minus: .double -1.0
denominator: .double 1.0

.text
.global logarithm
.type logarithm, @function

logarithm:
	push %rbp
	mov %rsp, %rbp

	sub $8, %rsp
	movsd %xmm0, (%rsp)
	fldl (%rsp)
	fld %st
	fld %st

	fwait

	mov $0, %rsi

	count_steps:
		cmp %rdi, %rsi
		je exit
		inc %rsi

	fmul %st(2), %st
	fmull minus

	fld %st

	fldl denominator
	fld1

	fadd %st, %st(1)
	fstp %st

	fld %st

	fstpl denominator

	fdivr %st, %st(1)

	fstp %st

	fadd %st, %st(2)

	fstp %st

	jmp count_steps

	exit:
	fstp %st
	fstpl (%rsp)
	movsd (%rsp), %xmm0
	

	mov %rbp, %rsp
	pop %rbp
	ret
