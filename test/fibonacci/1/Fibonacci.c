/* run this program using the console pauser or add your own getch, system("pause") or input loop */
#include <stdio.h> 

int Fibonacci(int n)
{
    int i = 2, a = 0, b = 1;
    if(n=0)
        b = 0;
    else if (n=1)
        b = 1;
    else
    {
        while ( i < n ) {
		b = a + b;
		a = b - a;
		i ++;
		} 
	}
    return b;
	 
}

int main() {
	int n, f;
	
	n = 10;
	f = Fibonacci(n);
    printf("%d",f);
	
	return 0;
}


main:  
        li   s2,0
        li   s3,1
        li   s4,10
        li   s5,2


.L1:    bge  s5,s4,.L2
        add  s6,s2,s3
        addi s5,s5,1
        addi s2,s3,0
        addi s3,s6,0
        j    .L1

.L2:    li   s7,0
        addi a0,s7