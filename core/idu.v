`include "define.v"


module idu (
    input            clk          ,
    input            rstn         ,

    input  [31:0]    id_pc        ,
    input  [31:0]    id_inst      ,
    input            wb_rd_en     ,
    input  [4:0]     wb_rd_idx    ,
    input  [31:0]    wb_rd_data   ,
    input  [4:0]     exe_rd_idx   ,
    input            exe_rd_en    ,
    input            exe_load     ,



    output           rs1_en       ,
    output           rs2_en       ,
    output           rd_en        ,
    output [4:0]     rs1_idx      ,
    output [4:0]     rs2_idx      ,
    output [4:0]     rd_idx       ,
    output [11:0]    csr_addr     ,
    output           jal          , 
    output           jalr         , 
    output           bjp          , 
    output           alu          , 
    output           alui         , 
    output           lui          , 
    output           auipc        , 
    output           ls           ,
    output           load         , 
    output           csr          ,
    output           speci        ,
    output [31:0]    rs1_data     ,
    output [31:0]    rs2_data     ,
    output [`DECODE_INFO_LEN-1:0] dec_info ,
    output [`DECODE_XLEN-1:0]     dec_imm  ,
    output [31:0]    jppc         ,
    output           j_flush      ,
    output           stall        ,
    output           lu_flush

);
    
    
    
    wire       rs1_en,rs2_en,rd_en;
    wire [4:0] rs1_idx, rs2_idx, rd_idx;
    wire       jal, jalr, bjp, alu, alui, lui, auipc, ls, csr, speci;
    wire [`DECODE_INFO_LEN-1:0] dec_info;
    wire [`DECODE_XLEN-1:0]     dec_imm;
    
    decode decode_m0 (
    .inst_32(id_inst),
    
    
    .rs1_en(rs1_en),
    .rs2_en(rs2_en),
    .rd_en(rd_en),
    .rs1_idx(rs1_idx),
    .rs2_idx(rs2_idx),
    .rd_idx(rd_idx),
    .csr_addr(csr_addr),
    .jal(jal),
    .jalr(jalr),
    .bjp(bjp),
    .alu(alu),
    .alui(alui),
    .lui(lui),
    .auipc(auipc),
    .ls(ls),
    .load(load),
    .csr(csr),
    .speci(speci),
    .dec_info(dec_info),
    .dec_imm(dec_imm)
    );


    wire [31:0]  rs1_data, rs2_data;
    wire         wb_rd_en;
    wire [4:0]   wb_rd_idx;
    wire [31:0]  wb_rd_data;


    regfile regfile_m0(
    .clk(clk),
    .rstn(rstn),

    .rs1_idx(rs1_idx),
    .rs2_idx(rs2_idx),
    .wb_rd_en(wb_rd_en),
    .wb_rd_idx(wb_rd_idx),
    .wb_rd_data(wb_rd_data),


    .rs1_data(rs1_data),
    .rs2_data(rs2_data)
    );



    wire [31:0]  jpc, jrpc;

    
    jaddr_gen jaddr_gen_m0(
    .pc(id_pc),
    .jal(jal),
    .jalr(jalr),
    .bjp(bjp),
    .dec_imm(dec_imm),
    .rs1_data(rs1_data),

    .jpc(jpc),
    .jrpc(jrpc)
    );

    
    wire [31:0]  jppc;
    wire         j_flush;
    wire         jhazard;


    jhazard jhazard_m0 (
    .jal(jal),
    .jalr(jalr),
    .jpc(jpc),
    .jrpc(jrpc),

    .j_flush(j_flush),
    .jppc(jppc)
    );


    wire [4:0] exe_rd_idx;
    wire       exe_rd_en;
    wire       exe_load;
    wire       stall;
    wire       lu_flush;


    luhazard luhazard_m0 (
    .exe_rd_idx (exe_rd_idx) ,
    .exe_rd_en  (exe_rd_en),
    .exe_load   (exe_load),
    .rs1_idx   (rs1_idx),
    .rs2_idx   (rs2_idx),
    .rs1_en    (rs1_en),
    .rs2_en    (rs2_en),

    .stall     (stall),
    .lu_flush  (lu_flush)
    );




    
endmodule