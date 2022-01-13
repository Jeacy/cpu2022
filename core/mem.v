`include "define.v"

module mem (
    input                               clk          ,
    input                               rstn         ,
    input    [`DECODE_INFO_LEN-1:0]     mem_dec_info ,
    input    [31:0]                     mem_op_rs2   ,
    input                               mem_jal      ,
    input                               mem_jalr     ,
    input                               mem_bjp      ,
    input                               mem_alu      ,
    input                               mem_alui     ,
    input                               mem_lui      ,
    input                               mem_auipc    ,
    input                               mem_ls       ,
    input                               mem_load     ,
    input                               mem_csr      ,
    input                               mem_speci    ,
    input    [4:0]                      mem_rd_idx   ,
    input                               mem_rd_en    ,
    input    [31:0]                     mem_result   ,

    output    [31:0]                    mem_rd_data  ,
    output    [31:0]                    data1        ,
    output    [31:0]                    data2        ,
    output    [31:0]                    data3        ,
    output    [31:0]                    data4        ,
    output    [31:0]                    data5        ,
    output    [31:0]                    data6        ,
    output    [31:0]                    data7        ,
    output    [31:0]                    data8        ,
    output    [31:0]                    data9        ,
    output    [31:0]                    data10

);
    


    reg[7:0] dmem [0 : 65536 - 1];  //2^256
    integer i;

    initial begin;
       for(i = 0; i < 65535; i=i+1) 
            dmem[i] = 0;
        


        dmem[0]  = 8'd5;
        dmem[4]  = 8'd7;
        dmem[8]  = 8'd4;
        dmem[12] = 8'd9;
        dmem[16] = 8'd2;
        dmem[20] = 8'd8;
        dmem[24] = 8'd10;
        dmem[28] = 8'd6;
        dmem[32] = 8'd3;
        dmem[36] = 8'd1;
    end
    
    assign store   =  mem_ls & (~mem_load) ;

    assign wb_dir  =  mem_jal | mem_jalr | mem_alu | mem_alui | mem_lui | mem_auipc | mem_csr ;

    assign wb_dh   =  mem_bjp | mem_speci| store;

    assign mem_rd_data =  ({32{wb_dir}} & mem_result) |
                          ({32{wb_dh }} & 32'b0     ) |
                          ({32{mem_load }} & load_result);



    wire  lb   =  mem_ls &  mem_dec_info[`LSU_LB ] ;
    wire  lh   =  mem_ls &  mem_dec_info[`LSU_LH ] ;
    wire  lw   =  mem_ls &  mem_dec_info[`LSU_LW ] ;
    wire  lbu  =  mem_ls &  mem_dec_info[`LSU_LBU] ;
    wire  lhu  =  mem_ls &  mem_dec_info[`LSU_LHU] ;
    wire  sb   =  mem_ls &  mem_dec_info[`LSU_SB ] ;
    wire  sh   =  mem_ls &  mem_dec_info[`LSU_SH ] ;
    wire  sw   =  mem_ls &  mem_dec_info[`LSU_SW ] ;

    wire [7:0] dmem_addr_data1 = dmem[mem_result];
    wire [7:0] dmem_addr_data2 = dmem[mem_result+1];
    wire [7:0] dmem_addr_data3 = dmem[mem_result+2];
    wire [7:0] dmem_addr_data4 = dmem[mem_result+3];
    
    wire [31:0] lb_result = {{24{dmem_addr_data1 [7]}} ,dmem_addr_data1};
    wire [31:0] lh_result = {{16{dmem_addr_data2 [7]}},dmem_addr_data2,dmem_addr_data1};
    wire [31:0] lw_result = {dmem_addr_data4,dmem_addr_data3,dmem_addr_data2,dmem_addr_data1};
    wire [31:0] lbu_result = {{24{1'b0}},dmem[mem_result]};
    wire [31:0] lhu_result = {{16{1'b0}},dmem[mem_result+1],dmem[mem_result]};

    
    wire [31:0]   load_result =   ({32{lb}} & lb_result   ) |
                                  ({32{lh}} & lh_result   ) |
                                  ({32{lw}} & lw_result   ) |
                                  ({32{lbu}}  & lbu_result ) |
                                  ({32{lhu}}  & lhu_result ) ;


    wire [7:0]  sb_data = mem_op_rs2[7:0];
    wire [15:0] sh_data = mem_op_rs2[15:0];
    wire [31:0] sw_data = mem_op_rs2;



    assign  store_data  =  ({8{sb} }  & sb_data   ) |
                           ({16{sh}}  & sh_data   ) |
                           ({32{sw}}  & sw_data   ) ;
    
    always @(*) begin
        if(sb) begin
            dmem[mem_result]   =  sb_data  ; 
        end
        else if (sh) begin
            dmem[mem_result]   =  sh_data  ;
            dmem[mem_result+1] =  sh_data[15:8]  ;
        end
        else if (sw) begin
            dmem[mem_result]   =  sh_data  ;
            dmem[mem_result+1] =  sh_data[15:8]  ;
            dmem[mem_result+2] =  sw_data[23:16] ;
            dmem[mem_result+3] =  sw_data[31:24] ;
        end

          
        
    end
    
    //assign  data1   =  {dmem[3],dmem[2],dmem[1],dmem[0]};  
    //assign  data2   =  {dmem[7],dmem[6],dmem[5],dmem[4]};  
    //assign  data3   =  {dmem[11],dmem[10],dmem[9],dmem[8]};  
    //assign  data4   =  {dmem[15],dmem[14],dmem[13],dmem[12]};  
    //assign  data5   =  {dmem[19],dmem[18],dmem[17],dmem[16]};  
    //assign  data6   =  {dmem[23],dmem[22],dmem[21],dmem[20]};  
    //assign  data7   =  {dmem[27],dmem[26],dmem[25],dmem[24]};  
    //assign  data8   =  {dmem[31],dmem[30],dmem[29],dmem[28]};  
    //assign  data9   =  {dmem[35],dmem[34],dmem[33],dmem[32]};  
    //assign  data10  =  {dmem[39],dmem[38],dmem[37],dmem[36]};                                

    
                         


endmodule

