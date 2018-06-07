.text
.globl rdtsc
rdtsc:
	push %rbp
	mov %rsp, %rbp

	xor %rax, %rax
	rdtsc

	mov %rbp, %rsp
	pop %rbp
	ret
