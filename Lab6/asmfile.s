.text
.globl rdtsc
rdtsc:
	xor %rax, %rax
	rdtsc
	ret
