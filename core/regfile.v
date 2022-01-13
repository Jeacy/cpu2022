
module regfile (
    input         clk,
    input         rstn,

    input  [4:0]  rs1_idx,
    input  [4:0]  rs2_idx,
    input         wb_rd_en,
    input  [4:0]  wb_rd_idx,
    input  [31:0] wb_rd_data,


    output [31:0] rs1_data,
    output [31:0] rs2_data

    
);


    reg [31:0] regf [31:0];

    integer i;


    assign rs1_data = regf[rs1_idx];
    assign rs2_data = regf[rs2_idx];

    always @(posedge clk or negedge rstn) begin
        if (~rstn) begin
            for (i=0;i<32;i=i+1)
                regf[i] = 32'b0;
        end
    end

    always @(*) begin
        if (wb_rd_en & (wb_rd_idx != 0)) begin
            regf[wb_rd_idx] <= wb_rd_data;
        end
    end
     

endmodule