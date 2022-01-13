`include "define.v"


module bru (
    input    [31:0]                    op_rs1        ,
    input    [31:0]                    op_rs2  ,
    input    [`DECODE_INFO_LEN-1:0]    exe_dec_info  ,
    input                              exe_bjp       ,
    input    [31:0]                    exe_pc        ,
    input    [31:0]                    exe_imm       ,
  

    output    [31:0]                   bpc           ,
    output                             bjmp
);


  wire  beq   =  exe_bjp &  exe_dec_info[`BRU_BEQ ] ;
  wire  bne   =  exe_bjp &  exe_dec_info[`BRU_BNE ] ;
  wire  blt   =  exe_bjp &  exe_dec_info[`BRU_BLT ] ;
  wire  bgt   =  exe_bjp &  exe_dec_info[`BRU_BGE ] ;
  wire  bltu  =  exe_bjp &  exe_dec_info[`BRU_BLTU] ;
  wire  bgtu  =  exe_bjp &  exe_dec_info[`BRU_BGEU] ;

  
  wire signd_lt =            (op_rs1[31] == 1 && op_rs2[31] == 0) |
                             (op_rs1[31] == 1 && op_rs2[31] == 1 && op_rs1[30:0] > op_rs2[30:0]) |
                             (op_rs1[31] == 0 && op_rs2[31] == 0 && op_rs1[30:0] < op_rs2[30:0]);
  wire signd_ge = ~signd_lt;
  
  assign bpc  = exe_bjp  ? (exe_pc+ exe_imm) : 32'b0;
 
  assign  bjmp =  beq   &  (op_rs1 == op_rs2) |
                  bne   &  (op_rs1 != op_rs2) |
                  blt   &  (signd_lt        ) |
                  bgt   &  (signd_ge        ) |
                  bltu  &  (op_rs1 <  op_rs2) |
                  bgtu  &  (op_rs1 >= op_rs2) ;

    
endmodule