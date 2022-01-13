`include "define.v"

module decode (
    input  [31:0]  inst_32,
    

    output         rs1_en,
    output         rs2_en,
    output         rd_en,
    output [4:0]   rs1_idx,
    output [4:0]   rs2_idx,
    output [4:0]   rd_idx,
    output [11:0]  csr_addr,

    output         jal,
    output         jalr,
    output         bjp,
    output         alu,
    output         alui,
    output         lui,
    output         auipc,
    output         ls,
    output         load,
    output         csr,
    output         speci,

    output [`DECODE_INFO_LEN-1:0] dec_info,
    output [`DECODE_XLEN-1:0]     dec_imm

    //output [31:0]  jalpc,
    //output [31:0]  jarlpc,
 );

 wire [31:0] inst = inst_32;
  
  wire [6:0] opcode = inst[6:0];



  wire opcode_0110111 = (opcode == 7'b0110111);  // LUI
  wire opcode_0010111 = (opcode == 7'b0010111);  // AUIPC
  wire opcode_1101111 = (opcode == 7'b1101111);  // JAL
  wire opcode_1100111 = (opcode == 7'b1100111);  // JALR
  wire opcode_1100011 = (opcode == 7'b1100011);  // BJP
  wire opcode_0000011 = (opcode == 7'b0000011);  // LOAD
  wire opcode_0100011 = (opcode == 7'b0100011);  // STORE
  wire opcode_0010011 = (opcode == 7'b0010011);  // ALUI
  wire opcode_0110011 = (opcode == 7'b0110011);  // ALU
  wire opcode_1110011 = (opcode == 7'b1110011);  // CSR
  wire opcode_0001111 = (opcode == 7'b0001111);  // FENCE



  

  
  wire [2:0] func3 = inst[14:12];

  wire func3_000 = (func3 == 3'b000);
  wire func3_001 = (func3 == 3'b001);
  wire func3_010 = (func3 == 3'b010);
  wire func3_011 = (func3 == 3'b011);
  wire func3_100 = (func3 == 3'b100);
  wire func3_101 = (func3 == 3'b101);
  wire func3_110 = (func3 == 3'b110);
  wire func3_111 = (func3 == 3'b111);


  
  wire [6:0] func7 = inst[31:25];
  
  wire func7_0000000 = (func7 == 7'b0000000);
  wire func7_0100000 = (func7 == 7'b0100000);
  wire func7_0000001 = (func7 == 7'b0000001);
  wire func7_0000101 = (func7 == 7'b0000101);
  wire func7_0001001 = (func7 == 7'b0001001);
  wire func7_0001101 = (func7 == 7'b0001101);
  wire func7_0010101 = (func7 == 7'b0010101);
  wire func7_0001000 = (func7 == 7'b0001000);
  wire func7_0011000 = (func7 == 7'b0011000);

  
  //lui
  assign lui    =    opcode_0110111;   
  wire [31:0] imm_lui   = {inst[31:12],12'b0};
  
  
  //auipc
  assign auipc  =    opcode_0010111;
  wire [31:0] imm_auipc = {inst[31:12],12'b0};


  //jal
  assign jal    =    opcode_1101111;
  wire [31:0] imm_jal   = {{11{inst[31]}},inst[31],inst[19:12],inst[20],inst[30:21],1'b0};


  //jalr
  assign jalr   =    opcode_1100111;
  wire [31:0] imm_jalr   = {{20{inst[31]}} , inst[31:20]};

  //bjp
  assign bjp    =    opcode_1100011;
  wire [31:0] imm_bjp   = {{19{inst[31]}},inst[31],inst[7],inst[30:25],inst[11:8],1'b0};


  wire beq      = bjp & func3_000;
  wire bne      = bjp & func3_001;
  wire blt      = bjp & func3_100;
  wire bgt      = bjp & func3_101;
  wire bltu     = bjp & func3_110;
  wire bgtu     = bjp & func3_111;


  wire [`BRU_INFO_LEN-1:0] bjp_info;

  assign bjp_info[`BRU_BEQ ] = beq ;       
  assign bjp_info[`BRU_BNE ] = bne ;
  assign bjp_info[`BRU_BLT ] = blt ;
  assign bjp_info[`BRU_BGE ] = bgt ;
  assign bjp_info[`BRU_BLTU] = bltu;
  assign bjp_info[`BRU_BGEU] = bgtu;
  

  
  //load
  assign load   =    opcode_0000011;
  wire [31:0] imm_load   = {{20{inst[31]}}, inst[31:20]};


  wire lb       = load   & func3_000;
  wire lh       = load   & func3_001;
  wire lw       = load   & func3_010;
  wire lbu      = load   & func3_100;
  wire lhu      = load   & func3_101;



  //store
  wire store  =    opcode_0100011;
  assign ls     =    load | store;
  wire [31:0] imm_store  = {{20{inst[31]}},inst[31:25],inst[11:7]};


  wire sb       = store  & func3_000;
  wire sh       = store  & func3_001;
  wire sw       = store  & func3_010;

  
  wire [`LSU_INFO_LEN-1:0] ls_info;

  assign ls_info[`LSU_LB ] = lb ;       
  assign ls_info[`LSU_LH ] = lh ;
  assign ls_info[`LSU_LW ] = lw ;
  assign ls_info[`LSU_LBU] = lbu;
  assign ls_info[`LSU_LHU] = lhu;
  assign ls_info[`LSU_SB ] = sb;
  assign ls_info[`LSU_SH ] = sh;
  assign ls_info[`LSU_SW ] = sw;
  



  //alui
  assign alui   =    opcode_0010011;
  wire alui_shift  =    slli | srli | srai;
  wire alui_nshift =    alui & (~alui_shift);  

  wire [31:0] imm_alui_nshift   = {{20{inst[31]}} , inst[31:20]};  
  wire [31:0] imm_alui_shift    = {27'b0,inst[24:20]};


  wire addi     = alui & func3_000;
  wire slti     = alui & func3_010;
  wire sltiu    = alui & func3_011;
  wire xori     = alui & func3_100;
  wire ori      = alui & func3_110;
  wire andi     = alui & func3_111;

  
  wire slli     = alui & func3_001 & (inst[31:26] == 6'b000000);          // ilegal problem need to be considerated
  wire srli     = alui & func3_101 & (inst[31:26] == 6'b000000);
  wire srai     = alui & func3_101 & (inst[31:26] == 6'b010000);


  wire [`ALUI_INFO_LEN-1:0] alui_info;

  assign alui_info[`ALU_ADDI ] = addi ;       
  assign alui_info[`ALU_SLTI ] = slti ;
  assign alui_info[`ALU_SLTIU] = sltiu;
  assign alui_info[`ALU_XORI ] = xori ;
  assign alui_info[`ALU_ORI  ] = ori  ;
  assign alui_info[`ALU_ANDI ] = andi ;
  assign alui_info[`ALU_SLLI ] = slli ;
  assign alui_info[`ALU_SRLI ] = srli ;
  assign alui_info[`ALU_SRAI ] = srai ;





  //alu
  assign alu    =    opcode_0110011;

  wire add       = alu  &  func3_000 & func7_0000000;
  wire sub       = alu  &  func3_000 & func7_0100000;
  wire sll       = alu  &  func3_001 & func7_0000000;
  wire slt       = alu  &  func3_010 & func7_0000000;
  wire sltu      = alu  &  func3_011 & func7_0000000;
  wire inst_xor  = alu  &  func3_100 & func7_0000000;
  wire srl       = alu  &  func3_101 & func7_0000000;
  wire sra       = alu  &  func3_101 & func7_0100000;
  wire inst_or   = alu  &  func3_110 & func7_0000000;
  wire inst_and  = alu  &  func3_111 & func7_0000000;


  wire [`ALU_INFO_LEN-1:0] alu_info;

  assign alu_info[`ALU_ADD ] = add     ;
  assign alu_info[`ALU_SUB ] = sub     ;
  assign alu_info[`ALU_SLL ] = sll     ;
  assign alu_info[`ALU_SLT ] = slt     ;
  assign alu_info[`ALU_SLTU] = sltu    ;
  assign alu_info[`ALU_XOR ] = inst_xor;
  assign alu_info[`ALU_SRL ] = srl     ;
  assign alu_info[`ALU_SRA ] = sra     ;
  assign alu_info[`ALU_OR  ] = inst_or ;
  assign alu_info[`ALU_AND ] = inst_and;




  //csr
  assign csr    =    opcode_1110011;
  wire csri   =    csrrwi | csrrsi | csrrci;
  wire csr_ni =    csr & (~csri);
  wire e_i    =    ebreak | ecall;
  wire [31:0] imm_csri    = {27'b0,inst[19:15]}; 

  wire csrrw    = csr & func3_001; 
  wire csrrs    = csr & func3_010; 
  wire csrrc    = csr & func3_011; 
  wire csrrwi   = csr & func3_101; 
  wire csrrsi   = csr & func3_110; 
  wire csrrci   = csr & func3_111;

  


  assign ifence  =    opcode_0001111;


 

  wire [`CSR_INFO_LEN-1:0] csr_info;

  assign csr_info[`CSR_CSRRW ] = csrrw   ;
  assign csr_info[`CSR_CSRRS ] = csrrs   ;
  assign csr_info[`CSR_CSRRC ] = csrrc   ;
  assign csr_info[`CSR_CSRRWI] = csrrwi  ;
  assign csr_info[`CSR_CSRRSI] = csrrsi  ;
  assign csr_info[`CSR_CSRRCI] = csrrci  ;




  //speci
  
  assign fence    = ifence & func3_000;
  wire fence_i  = ifence & func3_001;
  wire ecall    = csr & func3_000 & (inst[31:20] == 12'b0000_0000_0000);
  wire ebreak   = csr & func3_000 & (inst[31:20] == 12'b0000_0000_0001);
  wire uref     = csr & (inst[24:20] == 5'b0001_0) & func7_0000000;
  wire sret     = csr & (inst[24:20] == 5'b0001_0) & func7_0001000;
  wire mret     = csr & (inst[24:20] == 5'b0001_0) & func7_0011000;
  wire wfi      = csr & (inst[24:20] == 5'b0010_1) & func7_0001000; 

  

assign speci = fence_i|ecall|ebreak|uref|sret|mret|wfi;

  wire [`SPECI_INFO_LEN-1:0] speci_info;

  assign speci_info[`SPECI_FENCE ] = fence    ;
  assign speci_info[`SPECI_FENCEI] = fence_i  ;
  assign speci_info[`SPECI_EBREAK] = ebreak   ;
  assign speci_info[`SPECI_ECALL ] = ecall    ;
  assign speci_info[`SPECI_UREF  ] = uref     ;
  assign speci_info[`SPECI_SRET  ] = sret     ;
  assign speci_info[`SPECI_MRET  ] = mret     ;
  assign speci_info[`SPECI_WFI   ] = wfi      ;




  //assign [`DECODE_INFO_LEN-1:0] dec_info;

  assign dec_info = ({{`DECODE_INFO_LEN{bjp}} & {(`DECODE_INFO_LEN-`BRU_INFO_LEN){1'b0},bjp_info}})|
                    ({{`DECODE_INFO_LEN{ls}} & {(`DECODE_INFO_LEN-`LSU_INFO_LEN){1'b0},ls_info}})|
                    ({{`DECODE_INFO_LEN{alu}} & {(`DECODE_INFO_LEN-`ALU_INFO_LEN){1'b0},alu_info}})|
                    ({{`DECODE_INFO_LEN{alui}} & {(`DECODE_INFO_LEN-`BRU_INFO_LEN){1'b0},alui_info}})|
                    ({{`DECODE_INFO_LEN{csr}} & {(`DECODE_INFO_LEN-`CSR_INFO_LEN){1'b0},csr_info}})|
                    ({{`DECODE_INFO_LEN{speci}} & {(`DECODE_INFO_LEN-`SPECI_INFO_LEN){1'b0},speci_info}});


  //assign [31:0] dec_imm;

  assign dec_imm = ({32{lui}} & imm_lui)|
                   ({32{auipc}} & imm_auipc)|
                   ({32{jal}} & imm_jal)|
                   ({32{jalr}} & imm_jalr)|
                   ({32{bjp}} & imm_bjp)|
                   ({32{load}} & imm_load)|
                   ({32{store}} & imm_store)|
                   ({32{alui_nshift}} & imm_alui_nshift)|
                   ({32{alui_shift}} & imm_alui_shift)|
                   ({32{csri}} & imm_csri);





   assign rs1_en    = (~lui) & (~auipc) & (~jal) & (~csr) & (~ifence);

   assign rs2_en    = bjp | store | alu;

   assign rd_en     = (~bjp) & (~store) & (~ifence) & (~e_i);

   assign rs1_idx   = inst[19:15];

   assign rs2_idx   = inst[24:20];

   assign rd_idx    = inst[11:7];

     
   assign csr_addr  = inst[31:20];




endmodule