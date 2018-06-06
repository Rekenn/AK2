#include <stdio.h>
#define SIZE 101
#define COMPONENT 5
#define MULTIPLER 10

void fillArray(int array[]);
void display(int array[]);
void add(int array[]);
void multiply(int array[]);
unsigned long long rdtsc(void);

int main() {
	int array1[SIZE];
	int array2[SIZE];
	long long start, stop;

	printf("Rozpoczynam wypelnianie tablicy numer 1...\n");
	start = rdtsc();
	fillArray(array1);
	stop = rdtsc();
	printf("Wypelnienie tablicy zajelo %llu nano sekund\n\n", stop - start);
	
	printf("Rozpoczynam wypelnianie tablicy numer 2...\n");
	start = rdtsc();
	fillArray(array2);
	stop = rdtsc();
	printf("Wypelnienie tablicy zajelo %llu nano sekund\n\n", stop - start);

	printf("Tablica numer1\n");
	start = rdtsc();
	display(array1);
	stop = rdtsc();
	printf("Wyswietlanie tablicy zajelo %llu nano sekund\n\n",stop - start);

	
	printf("Tablica numer2\n");
	start = rdtsc();
	display(array2);
	stop = rdtsc();
	printf("Wyswietlanie tablicy zajelo %llu nano sekund\n\n",stop - start);

	printf("\nDodaje stala rowna 5 do tablicy numer 1\n");
	start = rdtsc();
	add(array1);
	stop = rdtsc();
	display(array1);
	printf("\nDodanie stalej zajelo %llu nano sekund\n\n",stop - start);
	
	printf("\nMnoze przez stala rowna 10 do tablicy numer 2\n");
	start = rdtsc();
	multiply(array2);
	stop = rdtsc();
	display(array2);
	printf("\nMnozenie zajelo %llu nano sekund\n\n",stop - start);
	
}

void display(int array[]) {
	printf("[ ");
	for ( int i = 0; i < SIZE; i++ )
		printf("%d, ", array[i]);
	printf("]\n");
}

void fillArray(int array[]) {
	for ( int i = 0; i < SIZE; i++ )
		array[i] = i;
}

void add(int array[]) {
	for ( int i = 0; i < SIZE; i++ )
		array[i] += COMPONENT;
}

void multiply(int array[]) {
	for ( int i = 0; i < SIZE; i++ )
		array[i] *= MULTIPLER;
}
