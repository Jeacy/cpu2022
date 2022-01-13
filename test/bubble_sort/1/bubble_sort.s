	.file	"bubble_sort.c"
	.option nopic
	.text
	.align	2
	.globl	bubble_sort
	.type	bubble_sort, @function
bubble_sort:
	addi	sp,sp,-48
	sw	s0,44(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	sw	zero,-20(s0)
	j	.L2
.L6:
	sw	zero,-24(s0)
	j	.L3
.L5:
	lw	a5,-24(s0)
	slli	a5,a5,2
	lw	a4,-36(s0)
	add	a5,a4,a5
	lw	a4,0(a5)
	lw	a5,-24(s0)
	addi	a5,a5,1
	slli	a5,a5,2
	lw	a3,-36(s0)
	add	a5,a3,a5
	lw	a5,0(a5)
	ble	a4,a5,.L4
	lw	a5,-24(s0)
	slli	a5,a5,2
	lw	a4,-36(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	sw	a5,-28(s0)
	lw	a5,-24(s0)
	addi	a5,a5,1
	slli	a5,a5,2
	lw	a4,-36(s0)
	add	a4,a4,a5
	lw	a5,-24(s0)
	slli	a5,a5,2
	lw	a3,-36(s0)
	add	a5,a3,a5
	lw	a4,0(a4)
	sw	a4,0(a5)
	lw	a5,-24(s0)
	addi	a5,a5,1
	slli	a5,a5,2
	lw	a4,-36(s0)
	add	a5,a4,a5
	lw	a4,-28(s0)
	sw	a4,0(a5)
.L4:
	lw	a5,-24(s0)
	addi	a5,a5,1
	sw	a5,-24(s0)
.L3:
	lw	a4,-40(s0)
	lw	a5,-20(s0)
	sub	a5,a4,a5
	addi	a5,a5,-1
	lw	a4,-24(s0)
	blt	a4,a5,.L5
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L2:
	lw	a4,-20(s0)
	lw	a5,-40(s0)
	blt	a4,a5,.L6
	nop
	lw	s0,44(sp)
	addi	sp,sp,48
	jr	ra
	.size	bubble_sort, .-bubble_sort
	.section	.rodata
	.align	2
.LC1:
	.string	"%d "
	.align	2
.LC0:
	.word	5
	.word	2
	.word	3
	.word	8
	.word	1
	.word	2
	.word	6
	.word	9
	.word	3
	.word	7
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-64
	sw	ra,60(sp)
	sw	s0,56(sp)
	addi	s0,sp,64
	lui	a5,%hi(.LC0)
	lw	t3,%lo(.LC0)(a5)
	addi	a4,a5,%lo(.LC0)
	lw	t1,4(a4)
	addi	a4,a5,%lo(.LC0)
	lw	a7,8(a4)
	addi	a4,a5,%lo(.LC0)
	lw	a6,12(a4)
	addi	a4,a5,%lo(.LC0)
	lw	a0,16(a4)
	addi	a4,a5,%lo(.LC0)
	lw	a1,20(a4)
	addi	a4,a5,%lo(.LC0)
	lw	a2,24(a4)
	addi	a4,a5,%lo(.LC0)
	lw	a3,28(a4)
	addi	a4,a5,%lo(.LC0)
	lw	a4,32(a4)
	addi	a5,a5,%lo(.LC0)
	lw	a5,36(a5)
	sw	t3,-60(s0)
	sw	t1,-56(s0)
	sw	a7,-52(s0)
	sw	a6,-48(s0)
	sw	a0,-44(s0)
	sw	a1,-40(s0)
	sw	a2,-36(s0)
	sw	a3,-32(s0)
	sw	a4,-28(s0)
	sw	a5,-24(s0)
	addi	a5,s0,-60
	li	a1,10
	mv	a0,a5
	call	bubble_sort
	sw	zero,-20(s0)
	j	.L8
.L9:
	lw	a5,-20(s0)
	slli	a5,a5,2
	addi	a4,s0,-16
	add	a5,a4,a5
	lw	a5,-44(a5)
	mv	a1,a5
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	printf
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L8:
	lw	a4,-20(s0)
	li	a5,9
	ble	a4,a5,.L9
	li	a5,0
	mv	a0,a5
	lw	ra,60(sp)
	lw	s0,56(sp)
	addi	sp,sp,64
	jr	ra
	.size	main, .-main
	.ident	"GCC: (GNU MCU Eclipse RISC-V Embedded GCC, 64-bits) 7.2.0"
