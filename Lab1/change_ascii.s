.data
SYSREAD = 0
STDIN = 0
STDOUT = 1
SYSWRITE = 1
SYSEXIT = 60
EXIT_SUCCESS = 0
BUFLEN = 512
ASCII_CODE_0 = 48
ASCII_CODE_9 = 57
ASCII_CODE_A = 65
ASCII_CODE_Z = 90

.bss
.comm textin, 512
.comm textout, 512

.text
.global main
main:

movq $SYSREAD, %rax
movq $STDIN, %rdi
movq $textin, %rsi
movq $BUFLEN, %rdx
syscall

movq $0, %rdi

change_ascii_code:

movb textin(, %rdi, 1), %bh

cmp $ASCII_CODE_0, %bh
jge than_48
jmp same_code

than_48:
cmp $ASCII_CODE_9, %bh
jle add_5
cmp $ASCII_CODE_A, %bh
jge than_A
jmp same_code

than_A:
cmp $ASCII_CODE_Z, %bh
jle add_3
jmp same_code

add_5:
add $5, %bh
movb %bh, textout(, %rdi, 1)
inc %rdi
cmp %rax, %rdi
jl change_ascii_code

add_3:
add $3, %bh
movb %bh, textout(, %rdi, 1)
inc %rdi
cmp %rax, %rdi
jl change_ascii_code

same_code:
movb %bh, textout(, %rdi, 1)
inc %rdi
cmp %rax, %rdi
jl change_ascii_code

mov $SYSWRITE, %rax
mov $STDOUT, %rdi
mov $textout, %rsi
mov $BUFLEN, %rdx
syscall

mov $SYSEXIT, %rax
mov $EXIT_SUCCESS, %rdi
syscall
