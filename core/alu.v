`include "define.v"
module alu (
    input       [31:0]                    op_rs1        ,  
    input       [31:0]                    op_rs2        ,
    input       [31:0]                    exe_imm       ,   
    input       [`DECODE_INFO_LEN-1:0]    exe_dec_info  ,
    input                                 exe_alu       ,
    input                                 exe_alui      ,


    output      [31:0]                    alu_result 
);  
    
 wire [31:0] op2 = exe_alu ? op_rs2 : (exe_alui ?  op_rs1 : 32'b0);



  wire  add       =  exe_alu &  exe_dec_info[`ALU_ADD ] ;
  wire  sub       =  exe_alu &  exe_dec_info[`ALU_SUB ] ;
  wire  sll       =  exe_alu &  exe_dec_info[`ALU_SLL ] ;
  wire  slt       =  exe_alu &  exe_dec_info[`ALU_SLT ] ;
  wire  sltu      =  exe_alu &  exe_dec_info[`ALU_SLTU] ;
  wire  inst_xor  =  exe_alu &  exe_dec_info[`ALU_XOR ] ;
  wire  srl       =  exe_alu &  exe_dec_info[`ALU_SRL ] ;
  wire  sra       =  exe_alu &  exe_dec_info[`ALU_SRA ] ;
  wire  inst_or   =  exe_alu &  exe_dec_info[`ALU_OR  ] ;
  wire  inst_and  =  exe_alu &  exe_dec_info[`ALU_AND ] ;

  
  wire  addi   =  exe_alui &  exe_dec_info[`ALU_ADDI ] ;
  wire  slti   =  exe_alui &  exe_dec_info[`ALU_SLTI ] ;
  wire  sltiu  =  exe_alui &  exe_dec_info[`ALU_SLTIU] ;
  wire  xori   =  exe_alui &  exe_dec_info[`ALU_XORI ] ;
  wire  ori    =  exe_alui &  exe_dec_info[`ALU_ORI  ] ;
  wire  andi   =  exe_alui &  exe_dec_info[`ALU_ANDI ] ;
  wire  slli   =  exe_alui &  exe_dec_info[`ALU_SLLI ] ;
  wire  srli   =  exe_alui &  exe_dec_info[`ALU_SRLI ] ;
  wire  srai   =  exe_alui &  exe_dec_info[`ALU_SRAI ] ;



  wire [4:0] shamt = op_rs2 [4:0];


  wire  signd_lt = (op_rs1[31] == 1 & op2[31] == 1'b0) |
                             (op_rs1[31] == 1 & op2[31] == 1 & op_rs1[30:0] > op2[30:0]) |
                             (op_rs1[31] == 0 & op2[31] == 0 & op_rs1[30:0] < op2[30:0]);
  wire signd_ge = ~signd_lt;
  
  wire [32:0] signed_op_rs1_pre = (-{op_rs1[31],op_rs1[31:0]}) ;
  wire [31:0] signed_op_rs1 = signed_op_rs1_pre[31:0];

  assign alu_result = ({32{add     }}  &  (op_rs1 + op_rs2           ) )|
                  ({32{sub     }}  &  (op_rs1 - op_rs2           ) )|
                  ({32{sll     }}  &  (op_rs1 << shamt           ) )|
                  ({32{slt     }}  &  (signd_lt                  ) )|
                  ({32{sltu    }}  &  (op_rs1 < op_rs2           ) )|
                  ({32{inst_xor}}  &  (op_rs1 ^ op_rs2           ) )|
                  ({32{srl     }}  &  (op_rs1 >> shamt           ) )|
                  ({32{sra     }}  &  (signed_op_rs1 >> shamt    ) )| 
                  ({32{inst_or }}  &  (op_rs1 | op_rs2           ) )|
                  ({32{inst_and}}  &  (op_rs1 & op_rs2           ) )|
                  ({32{addi    }}  &  (op_rs1 + exe_imm          ) )|
                  ({32{slti    }}  &  (signd_lt                  ) )|
                  ({32{sltiu   }}  &  (op_rs1 < exe_imm          ) )|
                  ({32{xori    }}  &  (op_rs1 ^ exe_imm          ) )|
                  ({32{ori     }}  &  (op_rs1 ^ exe_imm          ) )|
                  ({32{andi    }}  &  (op_rs1 & exe_imm          ) )|
                  ({32{slli    }}  &  (op_rs1 << exe_imm         ) )|
                  ({32{srli    }}  &  (op_rs1 >> exe_imm         ) )|
                  ({32{srai    }}  &  (signed_op_rs1 >> exe_imm  ) );
                 




   


endmodule

