#include <stdio.h>
extern int strong_code(char *, int);

int main() {
	char txt[] = "111";
	int len = 3;
	int x = strong_code(txt, len);

	return 0;
}
