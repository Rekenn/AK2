.data
SYSIN = 0
STDIN = 0
SYSOUT = 1
STDOUT = 1
SYSEXIT = 60
EXIT_SUCCESS = 0

.text
.global main
main:

push $4
call func

mov $SYSEXIT, %rax
mov $EXIT_SUCCESS, %rdi
syscall

# f(n) = f(n-1) - 7*f(n-2)
# f(0) = 0
# f(1) = 3
#      -8                    +16
# [ locals ][ rbp ][ ret ][ args ]
func:
	push %rbp
	mov %rsp, %rbp
	mov 16(%rbp), %rax 		# rcx = args[0]

	cmp $0, %rax
	je ret_0	
	cmp $1, %rax
	je ret_3

	mov $0, %rcx
	dec %rax		   		# decrement args[0]

	push %rcx
	push %rax
	call func
	pop %rax
	pop %rcx
	add %rbx, %rcx

	dec %rax
	mov $0, %r9

	push %rcx
	push %rax
	call func
	pop %rax
	pop %rcx
	sub %rbx, %rcx

	push %rcx
	push %rax
	call func
	pop %rax
	pop %rcx
	sub %rbx, %rcx

	push %rcx
	push %rax
	call func
	pop %rax
	pop %rcx
	sub %rbx, %rcx

	push %rcx
	push %rax
	call func
	pop %rax
	pop %rcx
	sub %rbx, %rcx

	push %rcx
	push %rax
	call func
	pop %rax
	pop %rcx
	sub %rbx, %rcx

	push %rcx
	push %rax
	call func
	pop %rax
	pop %rcx
	sub %rbx, %rcx

	push %rcx
	push %rax
	call func
	pop %rax
	pop %rcx
	sub %rbx, %rcx

	mov %rcx, %rbx
	mov %rbp, %rsp
	pop %rbp
	ret

	ret_0:
		mov $0, %rbx
		mov %rbp, %rsp
		pop %rbp
		ret
	
	ret_3:
		mov $3, %rbx
		mov %rbp, %rsp
		pop %rbp
		ret
