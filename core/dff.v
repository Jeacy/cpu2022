
module dff (
    input clk,
    input rstn,
    input stall,
    input [31:0] dnxt,
    output [31:0] qout
);

reg [31:0] qout_r;
reg [31:0] qout ;

wire en  = ~stall;

always @(posedge clk or negedge rstn) begin

    if (~rstn) begin
        qout_r <= 0;
    end
    else if (en)  begin
        qout_r <= dnxt;
    end
    else begin
        qout_r <= qout_r;
    end

    assign qout = qout_r;
    
end
    
endmodule