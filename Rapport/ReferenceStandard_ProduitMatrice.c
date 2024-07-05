#include <stdio.h>
#define N 4

int x[N] = {1, 2, 3, 4};
int y[N] = {0, 0, 0, 0};

//int mat_A[N][N] = { {1, 2, 3, 4},
//						 {5, 6, 7, 8},
//					 	 {9, 10, 11, 12},
//						{13, 14, 15, 16}};
// est équivalent à :
int mat_A[N*N] = { 1, 2, 3, 4,
				5, 6, 7, 8,
				9, 10, 11, 12,
				13, 14, 15, 16};	

void main(void){

	for (int i = 0; i < N; i++) {
		y[i]=0;
		for (int j = 0; j < N; j++) {
			y[i]=y[i]+mat_A[i * 4 + j] * x[j]; // ou mat_A[i][j]
		}
		printf("%d, ", y[i]); // absent de l'assembleur
	}
	printf("\n"); // absent de l'assembleur
}