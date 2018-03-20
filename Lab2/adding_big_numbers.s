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
MAX_SIZE = 65
file1: .ascii "file1.txt\0"
file2: .ascii "file2.txt\0"
file3: .ascii "file3.txt\0"

.bss
.comm number1, 1024
.comm number2, 1024
.comm endian_number1, 512
.comm endian_number2, 512
.comm sum, 513
.comm before_quad, 1026
.comm quad_number, 2052
.comm textout, 2052
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
mov $0, %rdi	# counter
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
cmp $MAX_SIZE, %rdi
jl add_numbers

mov $0, %rdi
mov $0, %rcx
mov $16, %rbx
xor %rdx, %rdx
xor %rax, %rax

div_bits:
mov sum(, %rdi, 1), %al
div %rbx
mov %al, before_quad(, %rcx, 1)
inc %rcx
mov %dl, before_quad(, %rcx, 1)
inc %rcx
inc %rdi
xor %rdx, %rdx
cmp $513, %rdi
jl div_bits

mov $0, %rdi
mov $0, %rcx
mov $4, %rbx

hex_to_quad:
mov before_quad(, %rdi, 1), %al
div %rbx
mov %al, quad_number(, %rcx, 1)
inc %rcx
mov %dl, quad_number(, %rcx, 1)
inc %rcx
inc %rdi
xor %rdx, %rdx
cmp $1026, %rdi
jl hex_to_quad

mov $0, %rcx
mov $0, %rax

encode_number:
mov quad_number(, %rcx, 1), %al
add $ASCII_0, %al
mov %al, textout(, %rcx, 1)
inc %rcx
cmp $2046, %rcx
jl encode_number

mov $SYSOPEN, %rax
mov $file3, %rdi
mov $FWRITE, %rsi
mov $0, %rdx
syscall

mov %rax, %r8

mov $SYSWRITE, %rax
mov %r8, %rdi
mov $textout, %rsi
mov $BUFLEN, %rdx
syscall

mov $SYSCLOSE, %rax
mov %r8, %rdi
syscall

mov $SYSEXIT, %rax
mov $EXIT_SUCCESS, %rdi
syscall
