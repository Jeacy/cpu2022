#include <stdio.h>

void bubble_sort(int arr[], int n) {
    int i, j, temp;
    for (i = 0; i < n; ++i) {
        for (j = 0; j < n - i - 1; ++j) {
            if (arr[j] > arr[j + 1]) {
                temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }
}

int main() {
    int i;
    int arr[10] = {5, 2, 3, 8, 1, 2, 6, 9, 3, 7};
    bubble_sort(arr, 10);
    for (i = 0; i < 10; ++i) {
        printf("%d ", arr[i]);
    }
    return 0;
}


main:   
        li   s2,4
        li   s3,800
        li   s4,1
        sw   s4,0(s3)
        li   s4,2
        sw   s4,4(s3)
        li   s4,3
        sw   s4,8(s3)
        li   s4,4
        sw   s4,12(s3)
        li   s4,0
        li   s5,0
        j    .L1
        nop

.L1     
        li   s6,0
        addi s7,s1,-1
        blt  s4,s6,.L2
        j    .L5
.L2     
        sub  s8,s7,s2
        blt  s6,s8,.L3
        addi s3,s3,1
        j    .L1
.L3     
        lw   s9,0(s3)
        addi s3,s3,4
        lw   s10,0(s3)
        blt  s9,s10,.L4
        addi s6,s6,1
        j    .L2
.L4
        addi s5,s9,0
        addi s9,s10,0
        addi s10,s5,0
        sw   s9,-4(s3)
        sw   s10,0(s3)
        addi s6,s6,1
        j    .L2
.L5
        li   s10,0
        addi a0,s10 




