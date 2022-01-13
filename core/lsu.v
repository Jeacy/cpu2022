
module lsu (
    input   [31:0]       exe_imm     ,
    input   [31:0]       op_rs1      ,
    input                exe_ls      ,

    output  [31:0]       maddr       
 //   output  [1:0]        mem_size


);

assign maddr = exe_ls ? op_rs1 + exe_imm : 32'b0;


    
endmodule