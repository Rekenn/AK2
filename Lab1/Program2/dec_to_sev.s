.data
SYSREAD = 0
STDIN = 0
SYSWRITE = 1
STDOUT = 1
SYSEXIT = 60
EXIT_SUCCESS = 0
BUFLEN = 512
ASCII_ZERO = 48

.bss
.comm textin, 512
.comm textout, 512

.text
.global main

main:

mov $SYSREAD, %rax
mov $STDIN, %rdi
mov $textin, %rsi
mov $BUFLEN, %rdx
syscall

sub $2, %rax
mov %rax, %rcx
mov %rax, %r13 # last index of number
mov %rax, %r14 # index for '\n'
inc %r14
mov $1, %r9 # multipler
xor %r8, %r8 # here will be decoded number
mov $7, %r10

change_number:
mov textin(, %rcx, 1), %al
sub $ASCII_ZERO, %al
mul %r9
add %rax, %r8
mov %r9, %rax
mul %r10
mov %rax, %r9
dec %rcx
xor %rax, %rax
cmp $0, %rcx
jge change_number

mov $10, %r10
mov %r8, %rax

encode_number:
div %r10
add $ASCII_ZERO, %dl
mov %dl, textout(, %r13, 1)
xor %rdx, %rdx
dec %r13
cmp $0, %rax
jg encode_number

mov $'\n', %dl
mov %dl, textout(, %r14, 1)

mov $SYSWRITE, %rax
mov $STDOUT, %rdi
mov $textout, %rsi
mov $BUFLEN, %rdx
syscall

mov $SYSEXIT, %rax
mov $EXIT_SUCCESS, %rdi
syscall
