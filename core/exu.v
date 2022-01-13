`include "define.v"

module exu (
    input                               clk          ,
    input                               rstn         ,

    input     [31:0]                    exe_pc       ,
    input     [4:0]                     exe_rs1_idx  ,
    input     [4:0]                     exe_rs2_idx  ,
    input     [4:0]                     mem_rd_idx   ,
    input     [4:0]                     wb_rd_idx    ,
    input                               exe_rs1_en   ,
    input                               exe_rs2_en   ,
    input                               mem_rd_en    ,
    input                               wb_rd_en     ,
    input     [31:0]                    exe_rs1_data ,
    input     [31:0]                    exe_rs2_data ,
    input     [31:0]                    mem_rd_data  ,
    input     [31:0]                    wb_rd_data   ,
    input     [31:0]                    exe_imm      ,
    input     [`DECODE_INFO_LEN-1:0]    exe_dec_info ,
    input                               exe_alu      ,
    input                               exe_alui     ,
    input                               exe_bjp      ,
    input                               exe_csr      ,
    input                               exe_speci    ,
    input                               exe_lui      ,
    input                               exe_ls       ,
    input                               exe_load     ,
    input                               exe_auipc    ,
    input                               exe_jal      ,
    input                               exe_jalr     ,
    input     [11:0]                    exe_csr_addr ,
    

    


    output    [31:0]                    exe_result   ,
    output    [31:0]                    op_rs2       ,
    output                              is_trap      ,
    output                              is_mret      ,
    output    [31:0]                    bpc          ,
    output                              b_flush   
); 



    
    wire      [4:0]                     exe_rs1_idx  ;
    wire      [4:0]                     exe_rs2_idx  ;
    wire      [4:0]                     mem_rd_idx   ;
    wire      [4:0]                     wb_rd_idx    ;
    wire                                exe_rs1_en   ;
    wire                                exe_rs2_en   ;
    wire                                mem_rd_en    ;
    wire                                wb_rd_en     ;
    wire      [31:0]                    exe_rs1_data ;
    wire      [31:0]                    exe_rs2_data ;
    wire      [31:0]                    mem_rd_data  ;
    wire      [31:0]                    wb_rd_data   ;
    wire      [31:0]                    op_rs1       ;
    wire      [31:0]                    op_rs2       ;
    
  


    forwarding forwarding_m0(

       .exe_rs1_idx  (exe_rs1_idx ),
       .exe_rs2_idx  (exe_rs2_idx ),
       .mem_rd_idx   (mem_rd_idx  ),
       .wb_rd_idx    (wb_rd_idx   ),   
       .exe_rs1_en   (exe_rs1_en  ),
       .exe_rs2_en   (exe_rs2_en  ),
       .mem_rd_en    (mem_rd_en   ),
       .wb_rd_en     (wb_rd_en    ),
       .exe_rs1_data (exe_rs1_data),
       .exe_rs2_data (exe_rs2_data),
       
       .mem_rd_data  (mem_rd_data ),
       .wb_rd_data   (wb_rd_data  ),


       .op_rs1       (op_rs1)      ,
       .op_rs2       (op_rs2)      
    );


    wire     [31:0]                    exe_imm      ;
    wire     [`DECODE_INFO_LEN-1:0]    exe_dec_info ;
    wire                               exe_alu      ;
    wire                               exe_alui     ;
    
    wire     [31:0]                    alu_result   ;

    
    alu alu_m0 (
    .op_rs1        (op_rs1      ),  
    .op_rs2        (op_rs2      ),
    .exe_imm       (exe_imm     ),  
    .exe_dec_info  (exe_dec_info),
    .exe_alu       (exe_alu     ),
    .exe_alui      (exe_alui    ),


    .alu_result    (alu_result)
    );

    

    wire    [31:0]                    maddr ;


    lsu lsu_m0 (
    .exe_imm     (exe_imm),
    .op_rs1      (op_rs1 ),
    .exe_ls      (exe_ls ),

    .maddr       (maddr)  

    );

    
    wire                              bjmp ;

    bru bru_m0 (
    .op_rs1        (op_rs1      ),
    .op_rs2        (op_rs2      ),
    .exe_dec_info  (exe_dec_info),
    .exe_bjp       (exe_bjp     ),
    .exe_pc        (exe_pc      ),
    .exe_imm       (exe_imm     ),

    .bpc(bpc),
    .bjmp(bjmp)
    );


    wire                              exe_csr      ;
    wire                              exe_speci    ;
    wire    [11:0]                    exe_csr_addr ;
    wire    [31:0]                    exe_pc       ;
    wire    [31:0]                    csr_rdata    ;
    wire                              is_trap      ;
    wire                              is_mret      ;
    


    csr csr_m0 (
    .clk           (clk          ),
    .rstn          (rstn         ),
    .exe_csr       (exe_csr      ),
    .exe_speci     (exe_speci    ),
    .exe_pc        (exe_pc       ),
    .exe_csr_addr  (exe_csr_addr ),
    .op_rs1        (op_rs1      ),
    .exe_imm       (exe_imm      ),
    .exe_dec_info  (exe_dec_info ),
    .wb_rd_en      (wb_rd_en     ),
   
    .csr_rdata     (csr_rdata    ),
    .is_trap       (is_trap      ),
    .is_mret       (is_mret      )
    );


    wire           b_flush;

    bhazard bhazard_m0 (
    .bjmp          (bjmp),

    .b_flush       (b_flush)     //flush if_id and id_exe 

    );

    assign exe_result = ({32{ exe_alu    }} &  (alu_result           ) )| 
                             ({32{ exe_alui   }} &  (alu_result           ) )|
                             ({32{ exe_csr    }} &  (csr_rdata            ) )| 
                             ({32{ exe_lui    }} &  (exe_imm              ) )| 
                             ({32{ exe_ls     }} &  (maddr                ) )|
                             ({32{ exe_auipc  }} &  (exe_pc + exe_imm     ) )| 
                             ({32{ exe_jal    }} &  (exe_pc + 32'd4       ) )| 
                             ({32{ exe_jalr   }} &  (exe_pc + 32'd4       ) );


   












    
endmodule