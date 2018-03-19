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
.comm sum, 1024

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

decode_right1:
dec %rcx
cmp $0, %rcx
jl next_number
mov number1(, %rcx, 1), %bl
cmp $ASCII_A, %bl
jge sub_right_A1
jl sub_right_01

decode_left1:
cmp $0, %rcx
jl before_encode1
dec %rcx
mov number1(, %rcx, 1), %al
cmp $ASCII_A, %al
jge sub_left_A1
jl sub_left_01

sub_right_A1:
sub $ASCII_A, %bl
jmp decode_left1

sub_right_01:
sub $ASCII_0, %bl
jmp decode_left1

sub_left_A1:
sub $ASCII_A, %al
mul %r8
add %bl, %al
mov %al, endian_number1(, %rdi, 1)
inc %rdi
jmp decode_right1

sub_left_01:
sub $ASCII_0, %al
mul %r8
add %bl, %al
mov %al, endian_number1(, %rdi, 1)
inc %rdi
jmp decode_right1

before_encode1:
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
mov $16, %r8

decode_right2:
dec %rcx
cmp $0, %rcx
jl before_adding
mov number2(, %rcx, 1), %bl
cmp $ASCII_A, %bl
jge sub_right_A2
jl sub_right_02

decode_left2:
cmp $0, %rcx
jl before_encode2
dec %rcx
mov number2(, %rcx, 1), %al
cmp $ASCII_A, %al
jge sub_left_A2
jl sub_left_02

sub_right_A2:
sub $ASCII_A, %bl
jmp decode_left2

sub_right_02:
sub $ASCII_0, %bl
jmp decode_left2

sub_left_A2:
sub $ASCII_A, %al
mul %r8
add %bl, %al
mov %al, endian_number2(, %rdi, 1)
inc %rdi
jmp decode_right2

sub_left_02:
sub $ASCII_0, %al
mul %r8
add %bl, %al
mov %al, endian_number2(, %rdi, 1)
inc %rdi
jmp decode_right2

before_encode2:
mov %bl, endian_number2(, %rdi, 1)
jmp before_adding

before_adding:
mov $0, %rdi
clc
pushfq
jmp add_numbers

add_numbers:
mov endian_number1(, %rdi, 8), %rax
mov endian_number2(, %rdi, 8), %rbx
popfq
adc %rbx, %rax
pushfq
mov %rax, sum(, %rdi, 8)
inc %rdi
cmp $15, %rdi
jl add_numbers

mov $SYSEXIT, %rax
mov $EXIT_SUCCESS, %rdi
syscall
