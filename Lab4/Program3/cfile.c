#include <stdio.h>
extern long strong_code(char *, int);

int main() {
	char txt[] = "1111";
	int len = 4;
	long x = strong_code(txt, len);

	printf("%ld\n", x);

	return 0;
}
