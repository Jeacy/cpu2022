
module imem (
    input        [31:0]      pc   ,
    output       [31:0]      inst
);
   
   
   reg[7:0] imem [0 : 65536 - 1];  //字节寻址
   integer i;
   initial begin
   for(i = 0; i < 65535; i=i+1) 
        imem[i] = 0;
     $readmemh("C:\\Users\\12847\\Desktop\\core\\bubb-handwritten.hex", imem); 

    end



    assign inst = {imem[pc + 3],imem[pc + 2],imem[pc + 1],imem[pc]};


        
endmodule