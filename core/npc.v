

module npc (
    input         clk,
    input         rstn,
    input  [31:0] pc4,
    input  [31:0] bpc,
    input  [31:0] jppc,
    input         j_flush,
    input         b_flush,
    output [31:0] npc
);
    reg  [31:0] npc;
   always @(*) begin
        if(j_flush)
            npc = jppc;
        else if (b_flush)
            npc = bpc;
        else 
            npc = pc4;
   end
    
endmodule