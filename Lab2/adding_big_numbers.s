.data
SYSREAD = 0
STDIN = 0
SYSWRITE = 1
STDOUT = 1
SYSOPEN = 2
SYSCLOSE = 3
FREAD = 0
FWRITE = 1
SYSEXIT = 60
EXIT_SUCCESS = 0
BUFLEN = 512
ASCII_A = 55
ASCII_0 = 48
file1: .ascii "file1.txt\0"
file2: .ascii "file2.txt\0"

.bss
.comm number1, 1024
.comm number2, 1024
.comm endian_number1, 1024
.comm endian_number2, 1024

.text
.global main
main:

mov $SYSOPEN, %rax
mov $file1, %rdi
mov $FREAD, %rsi
mov $0, %rdx
syscall

mov %rax, %r8 		# file1 descriptor

mov $SYSREAD, %rax
mov %r8, %rdi
mov $number1, %rsi
mov $BUFLEN, %rdx
syscall

mov %rax, %r9

mov $SYSCLOSE, %rax
mov %r8, %rdi
syscall

dec %r9
mov %r9, %rcx 		# number length
xor %rax, %rax	
xor %rdx, %rdx
mov $16, %r8		# multipler
mov $0, %rdi		# counter (endian_number)

decode_right:
dec %rcx
cmp $0, %rcx
jl next_number
mov number1(, %rcx, 1), %bl
cmp $ASCII_A, %bl
jge sub_right_A
jl sub_right_0

decode_left:
cmp $0, %rcx
jl before_encode
dec %rcx
mov number1(, %rcx, 1), %al
cmp $ASCII_A, %al
jge sub_left_A
jl sub_left_0

sub_right_A:
sub $ASCII_A, %bl
jmp decode_left

sub_right_0:
sub $ASCII_0, %bl
jmp decode_left

sub_left_A:
sub $ASCII_A, %al
mul %r8
add %bl, %al
mov %al, endian_number1(, %rdi, 1)
inc %rdi
jmp decode_right

sub_left_0:
sub $ASCII_0, %al
mul %r8
add %bl, %al
mov %al, endian_number1(, %rdi, 1)
inc %rdi
jmp decode_right

before_encode:
mov %bl, endian_number1(, %rdi, 1)
jmp next_number

next_number:

mov $SYSOPEN, %rax
mov $file2, %rdi
mov $FREAD, %rsi
mov $0, %rdx
syscall

mov %rax, %r8 		# file1 descriptor

mov $SYSREAD, %rax
mov %r8, %rdi
mov $number2, %rsi
mov $BUFLEN, %rdx
syscall

mov %rax, %r9

mov $SYSCLOSE, %rax
mov %r8, %rdi
syscall

dec %r9
mov %r9, %rcx 		# number length
xor %rax, %rax	
xor %rdx, %rdx
mov $0, %rdi		# counter (endian_number)











mov $SYSEXIT, %rax
mov $EXIT_SUCCESS, %rdi
syscall
