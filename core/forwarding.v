
module forwarding (

       input     [4:0]     exe_rs1_idx  ,
       input     [4:0]     exe_rs2_idx  ,
       input     [4:0]     mem_rd_idx   ,
       input     [4:0]     wb_rd_idx    ,
       input               exe_rs1_en   ,
       input               exe_rs2_en   ,
       input               mem_rd_en    ,
       input               wb_rd_en     ,
       input     [31:0]    exe_rs1_data ,
       input     [31:0]    exe_rs2_data ,
       input     [31:0]    mem_rd_data  ,
       input     [31:0]    wb_rd_data   ,


       output    [31:0]    op_rs1       ,
       output    [31:0]    op_rs2
);

wire fw_rs1_m = (exe_rs1_idx == mem_rd_idx) & exe_rs1_en & mem_rd_en;
wire fw_rs1_w = (exe_rs1_idx == wb_rd_idx ) & exe_rs1_en & wb_rd_en ;
wire fw_rs1_dh = (~fw_rs1_m) & (~fw_rs1_w);

wire fw_rs2_m = (exe_rs2_idx == mem_rd_idx) & exe_rs2_en & mem_rd_en;
wire fw_rs2_w = (exe_rs2_idx == wb_rd_idx ) & exe_rs2_en & wb_rd_en ;
wire fw_rs2_dh = (~fw_rs2_m) & (~fw_rs2_w);


assign  op_rs1 = ({32{fw_rs1_m}} & mem_rd_data) |
                 ({32{fw_rs1_w}} & wb_rd_data ) |
                 ({32{fw_rs1_dh}} & exe_rs1_data );                                                             ;


assign  op_rs2 = ({32{fw_rs2_m}} & mem_rd_data) |
                 ({32{fw_rs2_w}} & wb_rd_data ) |
                 ({32{fw_rs2_dh}} & exe_rs2_data );                                                             ;


endmodule