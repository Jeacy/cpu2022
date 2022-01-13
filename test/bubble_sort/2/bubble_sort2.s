
addi x7,x0,10          
addi x1,x0,0           
bge  x1,x7,30          
sub  x4,x7,x1          
addi x3,x0,0           
addi x2,x0,0           
addi x4,x4,-1          
addi x1,x1,1           
bge  x2,x4,-12         
addi x2,x2,1           
lw   x5,x3,0           
lw   x6,x3,4           
blt  x5,x6,6           
sw   x5,x3,4           
sw   x6,x3,0
addi x3,x3,4           
jalr x10,x0,16         
nop                    