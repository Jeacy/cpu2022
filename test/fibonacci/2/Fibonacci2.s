        addi x7,x0,10   
	addi x2,x0,0    
	addi x1,x0,1    
	bne x7,x0,6     
	addi x8,x0,0    
	jalr x10,x0,32  
	addi x3,x0,0    
	bne x7,x1,6     
	addi x8,x0,1    
	jalr x10,x0,32  
	beq x7,x1,12    
	addi x7,x7,-1   
	add x8,x2,x3    
	addi x2,x3,0    
	addi x3,x8,0    
	jalr x10,x0,20  
	nop      