
module if_id (
    input         clk,
    input         rstn,
    input         j_flush,
    input         b_flush,
    input         stall,
    input  [31:0] if_pc,
    input  [31:0] if_inst,
    output [31:0] id_pc,
    output [31:0] id_inst
);


reg [31:0] id_pc;
reg [31:0] id_inst;


always @(posedge clk or negedge rstn) begin
    if (~rstn) begin
        id_pc <= 0;
        id_inst <= 0;
    end
    else if(j_flush|b_flush) begin
        id_pc <= 0;
        id_inst <= 0;
    end
    else if(stall) begin
        id_pc <= id_pc;
        id_inst <= id_inst;
    end
    else begin
        id_pc <= if_pc;
        id_inst <= if_inst;
    end 
end
    
endmodule