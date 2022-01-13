`include "define.v"



module exe_mem (
    input                               clk          ,
    input                               rstn         ,
    
    input     [31:0]                    exe_pc       ,
    input     [`DECODE_INFO_LEN-1:0]    exe_dec_info ,
    input     [31:0]                    op_rs2       ,
    input                               exe_jal      , 
    input                               exe_jalr     , 
    input                               exe_bjp      , 
    input                               exe_alu      , 
    input                               exe_alui     , 
    input                               exe_lui      , 
    input                               exe_auipc    , 
    input                               exe_ls       ,
    input                               exe_load     ,
    input                               exe_csr      ,
    input                               exe_speci    ,
    input     [4:0]                     exe_rd_idx   ,
    input                               exe_rd_en    ,
    input     [31:0]                    exe_result   ,

    output    [31:0]                    mem_pc       ,
    output    [`DECODE_INFO_LEN-1:0]    mem_dec_info ,
    output    [31:0]                    mem_op_rs2   ,
    output                              mem_jal      ,
    output                              mem_jalr     ,
    output                              mem_bjp      ,
    output                              mem_alu      ,
    output                              mem_alui     ,
    output                              mem_lui      ,
    output                              mem_auipc    ,
    output                              mem_ls       ,
    output                              mem_load     ,
    output                              mem_csr      ,
    output                              mem_speci    ,
    output    [4:0]                     mem_rd_idx   ,
    output                              mem_rd_en    ,
    output    [31:0]                    mem_result   




    
);


    reg    [31:0]                    mem_pc       ;
    reg    [`DECODE_INFO_LEN-1:0]    mem_dec_info ;
    reg    [31:0]                    mem_op_rs2   ;
    reg                              mem_ls       ;
    reg                              mem_jal      ; 
    reg                              mem_jalr     ; 
    reg                              mem_bjp      ; 
    reg                              mem_alu      ; 
    reg                              mem_alui     ; 
    reg                              mem_lui      ; 
    reg                              mem_auipc    ; 
    reg                              mem_ls       ; 
    reg                              mem_load     ; 
    reg                              mem_csr      ;
    reg                              mem_speci    ;
    reg    [4:0]                     mem_rd_idx   ;
    reg                              mem_rd_en    ;
    reg    [31:0]                    mem_result   ;

    
    always @(posedge clk or negedge rstn) begin
     if (~rstn) begin
         mem_pc          <=  32'b0 ;
         mem_dec_info    <=  {`DECODE_INFO_LEN{1'b0}} ;
         mem_op_rs2      <=  32'b0 ;
         mem_jal         <=  1'b0  ; 
         mem_jalr        <=  1'b0  ; 
         mem_bjp         <=  1'b0  ; 
         mem_alu         <=  1'b0  ; 
         mem_alui        <=  1'b0  ; 
         mem_lui         <=  1'b0  ; 
         mem_auipc       <=  1'b0  ; 
         mem_ls          <=  1'b0  ;
         mem_load        <=  1'b0  ; 
         mem_csr         <=  1'b0  ;
         mem_speci       <=  1'b0  ;
         mem_rd_idx      <=  5'b0  ;
         mem_rd_en       <=  1'b0  ;
         mem_result      <=  32'b0 ;
         
     end
    else begin
         mem_pc          <=     exe_pc        ;
         mem_dec_info    <=     exe_dec_info  ;
         mem_op_rs2      <=     op_rs2        ;
         mem_jal         <=     exe_jal       ; 
         mem_jalr        <=     exe_jalr      ; 
         mem_bjp         <=     exe_bjp       ; 
         mem_alu         <=     exe_alu       ; 
         mem_alui        <=     exe_alui      ; 
         mem_lui         <=     exe_lui       ; 
         mem_auipc       <=     exe_auipc     ; 
         mem_ls          <=     exe_ls        ;
         mem_load        <=     exe_load      ; 
         mem_csr         <=     exe_csr       ;
         mem_speci       <=     exe_speci     ;
         mem_rd_idx      <=     exe_rd_idx    ;
         mem_rd_en       <=     exe_rd_en     ;
         mem_result      <=     exe_result    ;
        
    end
     
 end



endmodule