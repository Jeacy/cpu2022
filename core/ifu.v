
module ifu (
    input         clk        ,
    input         rstn        ,
    input         j_flush    ,
    input  [31:0] jppc       ,
    input         b_flush    ,
    input  [31:0] bpc        ,
    input         stall      ,
    output [31:0] if_pc      ,
    output [31:0] if_inst
);
    wire [31:0] pc,npc,if_pc,pc4;
    wire [31:0] inst,if_inst;
    
    assign if_pc = pc;

    assign if_inst = inst;

    assign pc4 = pc + 4;

    pc pc_m0(
    .clk(clk),
    .rstn(rstn),
    .stall(stall),
    .npc(npc),
    .pc(pc)
  );

    npc npc_m0(
    .clk(clk),
    .rstn(rstn),
    .pc4(pc4),
    .bpc(bpc),
    .jppc(jppc),
    .j_flush(j_flush),
    .b_flush(b_flush),
    .npc(npc)
);

    imem imem_m0 (
    .pc(pc),
    .inst(inst)
);


   






endmodule