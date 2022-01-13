
module jaddr_gen (
    input [31:0] pc,
    input        jal,
    input        jalr,
    input [31:0] dec_imm,
    input [31:0] rs1_data,
    output [31:0] jpc,
    output [31:0] jrpc,

);
    

    assign jpc  = jal  ? (pc+dec_imm) : 32'b0;
    assign jrpc = jalr ? ((rs1_data + dec_imm) & {{31{1'b1}},1'b0}): 32'b0;  //also need forwarding     this problem will be solved 
    

endmodule