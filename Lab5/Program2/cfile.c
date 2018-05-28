#include <stdio.h>

extern double logarithm(double x, int i);

int main() {
	int n;
	double x;
	printf("Enter x: ");
	scanf("%lf", &x);
	printf("Steps: ");
	scanf("%d", &n);
	printf("Result: %lf\n", logarithm(x, n));
}
