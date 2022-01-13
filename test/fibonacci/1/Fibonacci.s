	.file	"Fibonacci.c"
	.option nopic
	.text
	.align	2
	.globl	Fibonacci
	.type	Fibonacci, @function
Fibonacci:
	addi	sp,sp,-48
	sw	s0,44(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	li	a5,2
	sw	a5,-24(s0)
	sw	zero,-28(s0)
	li	a5,1
	sw	a5,-20(s0)
	sw	zero,-36(s0)
	lw	a5,-36(s0)
	beqz	a5,.L2
	sw	zero,-20(s0)
	j	.L3
.L2:
	li	a5,1
	sw	a5,-36(s0)
	li	a5,1
	sw	a5,-20(s0)
.L3:
	lw	a5,-20(s0)
	mv	a0,a5
	lw	s0,44(sp)
	addi	sp,sp,48
	jr	ra
	.size	Fibonacci, .-Fibonacci
	.section	.rodata
	.align	2
.LC0:
	.string	"%d"
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	li	a5,10
	sw	a5,-20(s0)
	lw	a0,-20(s0)
	call	Fibonacci
	sw	a0,-24(s0)
	lw	a1,-24(s0)
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	printf
	li	a5,0
	mv	a0,a5
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: (GNU MCU Eclipse RISC-V Embedded GCC, 64-bits) 7.2.0"
