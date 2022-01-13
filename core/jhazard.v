
module jhazard (
    input         jal,
    input         jalr,
    input  [31:0] jpc,
    input  [31:0] jrpc,

    output        j_flush,
    output [31:0] jppc
);

    assign j_flush = (jal|jalr) ? 1'b1 : 1'b0;
    

    assign jppc = jal ? jpc : (jalr ? jrpc : 32'b0);


    
endmodule