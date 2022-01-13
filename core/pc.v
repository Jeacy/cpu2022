

module pc(
    input         clk,
    input         rstn,
    input         stall,
    input [31:0]  npc,
    output [31:0] pc
);

 wire en;
 //assign en = ~stall;

 dff  dff1 (
    .clk(clk),
    .rstn(rstn),
    .stall(stall),
    .dnxt(npc),
    .qout(pc)
);

endmodule

 