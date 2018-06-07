#include <stdio.h>

extern int set(int);
extern int check(int);

int main() {
	int choice = 0;
	int mask = 0;

	do {
		printf("\n1. Wyswietl status word.\n");
		printf("2. Wygeneruj wyjatek i wyswietl status word.\n");
		printf("3. Zmien maske wyjatku.\n");
		printf("4. Wyjscie\n\n");

		scanf("%d", &choice);
		if ( choice == 1 || choice == 2 ) {
			int result = check(choice);
			if ( result > 0 ) {
				printf("Wystapil wyjatek.\n\n");
			} else if ( result == 0 ) {
				printf("Brak wyjatkow.\n\n");
			}
		} else if ( choice == 3 ) {
			do {
				printf("Wybierz liczbe aby zmienic maske\n");
				printf("0. Invalid operation Mask\n");
				printf("1. Denormalized operand Mask\n");
				printf("2. Zero divide Mask\n");
				printf("3. Overflow Mask\n");
				printf("4. Underflow Mask\n");
				printf("5. Precision Mask\n");
				printf("6. Wyjscie\n\n");

				scanf("%d", &mask);
				switch(mask) {
					case 0:
						set(1);
						break;
					case 1:
						set(2);
					case 2:
						set(4);
						break;
					case 3:
						set(8);
					case 4:
						set(16);
						break;
					case 5:
						set(32);
						break;
					default:
						break;
				}
			} while ( mask != 6 );
		}
	} while ( choice != 4 );

	return 0;
}
