.data
SYSIN = 0
STDIN = 0
SYSOUT = 1
STDOUT = 1
BUFLEN = 512
SYSEXIT = 60
EXIT_SUCCESS = 0
ASCII_a = 97
ASCII_c = 99

.bss
.comm textin, 512

.text
.global main
main:

mov $SYSIN, %rax
mov $STDIN, %rdi
mov $textin, %rsi
mov $BUFLEN, %rdx
syscall

dec %rax
mov %rax, %r8    # string length

call func

mov $SYSEXIT, %rax
mov $EXIT_SUCCESS, %rdi
syscall

func:
	mov $0, %rcx
	sub $2, %r8
	mov $1, %rdx
	check_loop:
		mov textin(, %rcx, 1), %bl
		inc %rdx
		mov textin(, %rdx, 1), %bh	
		cmp %r8, %rcx
		jl check_first
		mov $-1, %rcx
		jmp before_return
			check_first:
				cmp $ASCII_a, %bl
				je check_second
				inc %rcx
				jmp check_loop
			check_second:
				cmp $ASCII_c, %bh
				je before_return
				inc %rcx
				jmp check_loop
	before_return:
	mov %rcx, %rax	
	ret
