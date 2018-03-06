.data
SYSREAD = 0
STDIN = 0
SYSWRITE = 1
STDOUT = 1
SYSEXIT = 60
EXIT_SUCCESS = 0
BUFLEN = 512
ASCII_ZERO = 0x30
ASCII_NINE = 0x39
ERROR: .ascii "Please input number only!\n"

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
mov %rax, %r15
mov %rax, %rcx
xor %rax, %rax
xor %r8, %r8 	# here will be decoded number
mov $1, %r9		# multipler
mov $10, %r10
mov $1, %r11 	# odd number

check_if_number:
mov textin(, %rcx, 1), %al
cmp $ASCII_ZERO, %al
jge less_than_9
jmp error_msg

less_than_9:
cmp $ASCII_NINE, %al
jle next_number
jmp error_msg

next_number:
dec %rcx
cmp $0, %rcx
jge check_if_number

mov %r15, %rcx
xor %rax, %rax

decode_number:
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
jge decode_number

mov $-1, %rcx 		# here will be square root

square_loop:
sub %r11, %r8
inc %rcx
add $2, %r11
cmp $0, %r8
jge square_loop

mov %rcx, %rax
mov $0, %r12 	# counter

square_length:
div %r10
xor %rdx, %rdx
inc %r12
cmp $0, %rax
jg square_length

mov %rcx, %rax
inc %r12
mov $'\n', %dl
mov %dl, textout(, %r12, 1)
dec %r12
xor %rdx, %rdx

encode_number:
div %r10
add $ASCII_ZERO, %dl
mov %dl, textout(, %r12, 1)
xor %rdx, %rdx
dec %r12
cmp $0, %r12
jg encode_number

mov $SYSWRITE, %rax
mov $STDOUT, %rdi
mov $textout, %rsi
mov $BUFLEN, %rdx
syscall
jmp end_label

error_msg:
mov $SYSWRITE, %rax
mov $STDOUT, %rdi
mov $ERROR, %rsi
mov $BUFLEN, %rdx
syscall

end_label:
mov $SYSEXIT, %rax
mov $EXIT_SUCCESS, %rdi
syscall
