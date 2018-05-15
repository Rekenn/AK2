#include <stdio.h>

int main(void) {
	char number[] = "300";
	int len = 2;
	long result;

	asm("mov $0, %%r8;\
		 mov $1, %%r9;\
		 mov $7, %%rbx;\
		 decode_loop:;\
			mov $0, %%rax;\
		 	mov (%%rdi, %%rsi, 1), %%al;\
			sub $0x30, %%al;\
			mul %%r9;\
			add %%rax, %%r8;\
			mov %%rbx, %%rax;\
			mul %%r9;\
			mov %%rax, %%r9;\
			dec %%rsi;\
			cmp $0, %%rsi;\
			jge decode_loop;\
			mov %%r8, %%rax;\
			params:"
			: "=a"(result)
			: "D"(number), "S"(len)
);
	printf("%ld\n", result);
	return 0;
}
