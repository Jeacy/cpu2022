`include "define.v"

module id_exe (
    input            clk          ,
    input            rstn         ,

    input  [31:0]    id_pc            ,
    input  [31:0]    id_inst          ,
    input            rs1_en           ,
    input            rs2_en           ,
    input            rd_en            ,
    input  [4:0]     rs1_idx          ,
    input  [4:0]     rs2_idx          ,
    input  [4:0]     rd_idx           ,
    input  [11:0]    csr_addr         ,
    input            jal              , 
    input            jalr             , 
    input            bjp              , 
    input            alu              , 
    input            alui             , 
    input            lui              , 
    input            auipc            , 
    input            ls               ,
    input            load             , 
    input            csr              ,
    input            speci            ,
    input  [31:0]    rs1_data         ,
    input  [31:0]    rs2_data         ,
    input  [`DECODE_INFO_LEN-1:0] dec_info ,
    input  [`DECODE_XLEN-1:0]     dec_imm  ,
    input            lu_flush         ,
    input            b_flush          ,


    output [31:0]    exe_pc           ,
    output [31:0]    exe_inst         ,
    output           exe_rs1_en       ,
    output           exe_rs2_en       ,
    output           exe_rd_en        ,
    output [4:0]     exe_rs1_idx      ,
    output [4:0]     exe_rs2_idx      ,
    output [4:0]     exe_rd_idx       ,
    output [11:0]    exe_csr_addr     ,
    output           exe_jal          , 
    output           exe_jalr         , 
    output           exe_bjp          , 
    output           exe_alu          , 
    output           exe_alui         , 
    output           exe_lui          , 
    output           exe_auipc        , 
    output           exe_ls           ,
    output           exe_load         ,  
    output           exe_csr          ,
    output           exe_speci        ,
    output [31:0]    exe_rs1_data     ,
    output [31:0]    exe_rs2_data     ,
    output [`DECODE_INFO_LEN-1:0] exe_dec_info ,
    output [`DECODE_XLEN-1:0]     exe_imm      

);

    reg  [31:0]    exe_pc           ;
    reg  [31:0]    exe_inst         ;
    reg            exe_rs1_en       ;
    reg            exe_rs2_en       ;
    reg            exe_rd_en        ;
    reg  [4:0]     exe_rs1_idx      ;
    reg  [4:0]     exe_rs2_idx      ;
    reg  [4:0]     exe_rd_idx       ;
    reg  [11:0]    exe_csr_addr     ;
    reg            exe_jal          ; 
    reg            exe_jalr         ; 
    reg            exe_bjp          ; 
    reg            exe_alu          ; 
    reg            exe_alui         ; 
    reg            exe_lui          ; 
    reg            exe_auipc        ; 
    reg            exe_ls           ;
    reg            exe_load         ;  
    reg            exe_csr          ;
    reg            exe_speci        ;
    reg  [31:0]    exe_rs1_data     ;
    reg  [31:0]    exe_rs2_data     ;
    reg  [`DECODE_INFO_LEN-1:0] exe_dec_info ;
    reg  [`DECODE_XLEN-1:0]     exe_imm      ;



 always @(posedge clk or negedge rstn) begin
     if (~rstn) begin
         exe_pc          <=  32'b0 ;
         exe_inst        <=  32'b0 ;
         exe_rs1_en      <=  1'b0  ;
         exe_rs2_en      <=  1'b0  ;
         exe_rd_en       <=  1'b0  ;
         exe_rs1_idx     <=  5'b0  ;
         exe_rs2_idx     <=  5'b0  ;
         exe_rd_idx      <=  5'b0  ;
         exe_csr_addr    <=  11'b0 ;
         exe_jal         <=  1'b0  ;
         exe_jalr        <=  1'b0  ;
         exe_bjp         <=  1'b0  ;
         exe_alu         <=  1'b0  ;
         exe_alui        <=  1'b0  ;
         exe_lui         <=  1'b0  ;
         exe_auipc       <=  1'b0  ;
         exe_ls          <=  1'b0  ;
         exe_load        <=  1'b0  ;
         exe_csr         <=  1'b0  ;
         exe_speci       <=  1'b0  ;
         exe_rs1_data    <=  32'b0 ;
         exe_rs2_data    <=  32'b0 ;
         exe_dec_info    <=  {`DECODE_INFO_LEN{1'b0}};
         exe_imm         <=  {`DECODE_XLEN{1'b0}}    ;
         
     end
     else if (lu_flush|b_flush) begin
         exe_pc          <=  32'b0 ;
         exe_inst        <=  32'b0 ;
         exe_rs1_en      <=  1'b0  ;
         exe_rs2_en      <=  1'b0  ;
         exe_rd_en       <=  1'b0  ;
         exe_rs1_idx     <=  5'b0  ;
         exe_rs2_idx     <=  5'b0  ;
         exe_rd_idx      <=  5'b0  ;
         exe_csr_addr    <=  11'b0 ;
         exe_jal         <=  1'b0  ;
         exe_jalr        <=  1'b0  ;
         exe_bjp         <=  1'b0  ;
         exe_alu         <=  1'b0  ;
         exe_alui        <=  1'b0  ;
         exe_lui         <=  1'b0  ;
         exe_auipc       <=  1'b0  ;
         exe_ls          <=  1'b0  ;
         exe_load        <=  1'b0  ;
         exe_csr         <=  1'b0  ;
         exe_speci       <=  1'b0  ;
         exe_rs1_data    <=  32'b0 ;
         exe_rs2_data    <=  32'b0 ;
         exe_dec_info    <=  {`DECODE_INFO_LEN{1'b0}};
         exe_imm         <=  {`DECODE_XLEN{1'b0}}    ;
       end
    else begin
         exe_pc          <=     id_pc    ;
         exe_inst        <=     id_inst  ;
         exe_rs1_en      <=     rs1_en   ;
         exe_rs2_en      <=     rs2_en   ;
         exe_rd_en       <=     rd_en    ;
         exe_rs1_idx     <=     rs1_idx  ;
         exe_rs2_idx     <=     rs2_idx  ;
         exe_rd_idx      <=     rd_idx   ;
         exe_csr_addr    <=     csr_addr ;
         exe_jal         <=     jal      ;
         exe_jalr        <=     jalr     ;
         exe_bjp         <=     bjp      ;
         exe_alu         <=     alu      ;
         exe_alui        <=     alui     ;
         exe_lui         <=     lui      ;
         exe_auipc       <=     auipc    ;
         exe_ls          <=     ls       ;
         exe_load        <=     load     ;
         exe_csr         <=     csr      ;
         exe_speci       <=     speci    ;
         exe_rs1_data    <=     rs1_data ;
         exe_rs2_data    <=     rs2_data ;
         exe_dec_info    <=     dec_info;
         exe_imm         <=     dec_imm     ;
    end
     
 end



    
endmodule