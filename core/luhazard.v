
module luhazard (
    input  [4:0] exe_rd_idx,
    input        exe_rd_en,
    input  [4:0] exe_load,
    input  [4:0] rs1_idx,
    input  [4:0] rs2_idx,
    input        rs1_en,
    input        rs2_en,

    output       stall,
    output       lu_flush
);

 reg stall;
 reg lu_flush;


 always @(*) begin
     
     if (exe_load & exe_rd_en & rs1_en & (exe_rd_idx == rs1_idx)) begin
         stall = 1;
         lu_flush = 1;
     end
     else if (exe_load & exe_rd_en & rs2_en & (exe_rd_idx == rs2_idx))begin
         stall = 1;
         lu_flush = 1;
     end
     else begin
         stall = 0;
         lu_flush = 0;
     end

 end
    
endmodule