`include "define.v"


module cpu (
    input                          clk       ,
    input                          rstn      ,
    output    [31:0]                data1     ,
    output    [31:0]                data2     ,
    output    [31:0]                data3     ,
    output    [31:0]                data4     ,
    output    [31:0]                data5     ,
    output    [31:0]                data6     ,
    output    [31:0]                data7     ,
    output    [31:0]                data8     ,
    output    [31:0]                data9     ,
    output    [31:0]                data10    ,
    output                          is_trap   ,
    output                          is_mret       
);


wire                               clk      ;
wire                               rstn     ; 
wire   [31:0]                      jppc     ;
wire   [31:0]                      bpc      ;
wire   [31:0]                      if_pc    ;
wire   [31:0]                      if_inst  ;  

ifu ifu_m0 (
    .clk        (clk     ) ,
    .rstn       (rstn    ) ,
    .j_flush    (j_flush ) ,
    .jppc       (jppc    ) ,
    .b_flush    (b_flush ) ,
    .bpc        (bpc     ) ,
    .stall      (stall   ) ,

    .if_pc      (if_pc)    ,
    .if_inst    (if_inst)
);






wire   [31:0]                      if_pc   ; 
wire   [31:0]                      if_inst ; 
wire   [31:0]                      id_pc   ; 
wire   [31:0]                      id_inst ;

if_id if_id_m0 (
    .clk         (clk    ),
    .rstn        (rstn   ),
    .j_flush     (j_flush),
    .b_flush     (b_flush),
    .stall       (stall  ),
    .if_pc       (if_pc  ),
    .if_inst     (if_inst),

    .id_pc       (id_pc  ),
    .id_inst     (id_inst)
);




wire                        rs1_en        ;
wire                        rs2_en        ;
wire                        rd_en         ;
wire     [4:0]              rs1_idx       ;
wire     [4:0]              rs2_idx       ;
wire     [4:0]              rd_idx        ;
wire     [11:0]             csr_addr      ;
wire                        jal           ; 
wire                        jalr          ; 
wire                        bjp           ; 
wire                        alu           ; 
wire                        alui          ; 
wire                        lui           ; 
wire                        auipc         ; 
wire                        ls            ;
wire                        load          ; 
wire                        csr           ;
wire                        speci         ;
wire     [31:0]             rs1_data      ;
wire     [31:0]             rs2_data      ;
wire     [`DECODE_INFO_LEN-1:0]  dec_info ;
wire     [`DECODE_XLEN-1:0]      dec_imm  ;
 
wire     [31:0]             jppc          ;
wire                        j_flush       ;

wire                        stall         ;
wire                        lu_flush      ;



idu idu_m0 (
    .clk          (clk       ),
    .rstn         (rstn      ),

    .id_pc        (id_pc     ),
    .id_inst      (id_inst   ),
    .wb_rd_en     (wb_rd_en  ),
    .wb_rd_idx    (wb_rd_idx ),
    .wb_rd_data   (wb_rd_data),
    .exe_rd_idx   (exe_rd_idx),
    .exe_rd_en    (exe_rd_en ),
    .exe_load     (exe_load  ),

    .rs1_en       (rs1_en    ),
    .rs2_en       (rs2_en    ),
    .rd_en        (rd_en     ),
    .rs1_idx      (rs1_idx   ),
    .rs2_idx      (rs2_idx   ),
    .rd_idx       (rd_idx    ),
    .csr_addr     (csr_addr  ),
    .jal          (jal       ), 
    .jalr         (jalr      ), 
    .bjp          (bjp       ), 
    .alu          (alu       ), 
    .alui         (alui      ), 
    .lui          (lui       ), 
    .auipc        (auipc     ), 
    .ls           (ls        ),
    .load         (load      ), 
    .csr          (csr       ),
    .speci        (speci     ),
    .rs1_data     (rs1_data  ),
    .rs2_data     (rs2_data  ),
    .dec_info     (dec_info  ),
    .dec_imm      (dec_imm   ),
    
    .jppc         (jppc      ),
    .j_flush      (j_flush   ),
    .stall        (stall     ),
    .lu_flush     (lu_flush  )

);



wire     [31:0]    exe_pc        ;
wire     [31:0]    exe_inst      ;
wire               exe_rs1_en       ;
wire               exe_rs2_en       ;
wire               exe_rd_en        ;
wire     [4:0]     exe_rs1_idx      ;
wire     [4:0]     exe_rs2_idx      ;
wire     [4:0]     exe_rd_idx       ;
wire     [11:0]    exe_csr_addr     ;
wire               exe_jal          ; 
wire               exe_jalr         ; 
wire               exe_bjp          ; 
wire               exe_alu          ; 
wire               exe_alui         ; 
wire               exe_lui          ; 
wire               exe_auipc        ; 
wire               exe_ls           ;
wire               exe_load         ;  
wire               exe_csr          ;
wire               exe_speci        ;
wire     [31:0]    exe_rs1_data     ;
wire     [31:0]    exe_rs2_data     ;
wire     [`DECODE_INFO_LEN-1:0] exe_dec_info ;
wire     [`DECODE_XLEN-1:0]     exe_imm      ;     


id_exe id_exe_m0 (
    .clk              (clk          ),
    .rstn             (rstn         ),

    .id_pc            (id_pc        ),
    .id_inst          (id_inst      ),
    .rs1_en           (rs1_en       ),
    .rs2_en           (rs2_en       ),
    .rd_en            (rd_en        ),
    .rs1_idx          (rs1_idx      ),
    .rs2_idx          (rs2_idx      ),
    .rd_idx           (rd_idx       ),
    .csr_addr         (csr_addr     ),
    .jal              (jal          ), 
    .jalr             (jalr         ), 
    .bjp              (bjp          ), 
    .alu              (alu          ), 
    .alui             (alui         ), 
    .lui              (lui          ), 
    .auipc            (auipc        ), 
    .ls               (ls           ),
    .load             (load         ), 
    .csr              (csr          ),
    .speci            (speci        ),
    .rs1_data         (rs1_data     ),
    .rs2_data         (rs2_data     ),
    .dec_info         (dec_info     ),
    .dec_imm          (dec_imm      ),
    .lu_flush         (lu_flush     ),
    .b_flush          (b_flush      ),


    .exe_pc           (exe_pc       ),
    .exe_inst         (exe_inst     ),
    .exe_rs1_en       (exe_rs1_en   ),
    .exe_rs2_en       (exe_rs2_en   ),
    .exe_rd_en        (exe_rd_en    ),
    .exe_rs1_idx      (exe_rs1_idx  ),
    .exe_rs2_idx      (exe_rs2_idx  ),
    .exe_rd_idx       (exe_rd_idx   ),
    .exe_csr_addr     (exe_csr_addr ),
    .exe_jal          (exe_jal      ), 
    .exe_jalr         (exe_jalr     ), 
    .exe_bjp          (exe_bjp      ), 
    .exe_alu          (exe_alu      ), 
    .exe_alui         (exe_alui     ), 
    .exe_lui          (exe_lui      ), 
    .exe_auipc        (exe_auipc    ), 
    .exe_ls           (exe_ls       ),
    .exe_load         (exe_load     ),  
    .exe_csr          (exe_csr      ),
    .exe_speci        (exe_speci    ),
    .exe_rs1_data     (exe_rs1_data ),
    .exe_rs2_data     (exe_rs2_data ),
    .exe_dec_info     (exe_dec_info ),
    .exe_imm          (exe_imm      )

);


wire    [31:0]                    bpc          ;
wire    [31:0]                    op_rs2       ;
wire    [31:0]                    exe_result   ;
wire                              is_trap      ;
wire                              is_mret      ;
wire                              b_flush      ;
 

exu exu_m0 (
    .clk          (clk         ),
    .rstn         (rstn        ),
    .exe_pc       (exe_pc      ),
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
    .exe_imm      (exe_imm     ),
    .exe_dec_info (exe_dec_info),
    .exe_alu      (exe_alu     ),
    .exe_alui     (exe_alui    ),
    .exe_bjp      (exe_bjp     ),
    .exe_csr      (exe_csr     ),
    .exe_speci    (exe_speci   ),
    .exe_lui      (exe_lui     ),
    .exe_ls       (exe_ls      ),
    .exe_load     (exe_load    ),
    .exe_auipc    (exe_auipc   ),
    .exe_jal      (exe_jal     ),
    .exe_jalr     (exe_jalr    ),
    .exe_csr_addr (exe_csr_addr),
    
    .bpc          (bpc         ),
    .op_rs2       (op_rs2      ),
    .exe_result   (exe_result  ),
    .is_trap      (is_trap     ),
    .is_mret      (is_mret     ),
    .b_flush      (b_flush     )
);


wire    [31:0]                    mem_pc       ;
wire    [`DECODE_INFO_LEN-1:0]    mem_dec_info ;
wire    [31:0]                    mem_op_rs2   ;
wire                              mem_jal      ;
wire                              mem_jalr     ;
wire                              mem_bjp      ;
wire                              mem_alu      ;
wire                              mem_alui     ;
wire                              mem_lui      ;
wire                              mem_auipc    ;
wire                              mem_ls       ;
wire                              mem_load     ;
wire                              mem_csr      ;
wire                              mem_speci    ;
wire    [4:0]                     mem_rd_idx   ;
wire                              mem_rd_en    ;
wire    [31:0]                    mem_result   ;



exe_mem exe_mem_m0 (
    .clk          (clk         ),
    .rstn         (rstn        ),
    .exe_pc       (exe_pc      ),
    .exe_dec_info (exe_dec_info),
    .op_rs2       (op_rs2      ),
    .exe_jal      (exe_jal     ), 
    .exe_jalr     (exe_jalr    ), 
    .exe_bjp      (exe_bjp     ), 
    .exe_alu      (exe_alu     ), 
    .exe_alui     (exe_alui    ), 
    .exe_lui      (exe_lui     ), 
    .exe_auipc    (exe_auipc   ), 
    .exe_ls       (exe_ls      ),
    .exe_load     (exe_load    ),
    .exe_csr      (exe_csr     ),
    .exe_speci    (exe_speci   ),
    .exe_rd_idx   (exe_rd_idx  ),
    .exe_rd_en    (exe_rd_en   ),
    .exe_result   (exe_result  ),

    .mem_pc       (mem_pc      ),
    .mem_dec_info (mem_dec_info),
    .mem_op_rs2   (mem_op_rs2  ),
    .mem_jal      (mem_jal     ),
    .mem_jalr     (mem_jalr    ),
    .mem_bjp      (mem_bjp     ),
    .mem_alu      (mem_alu     ),
    .mem_alui     (mem_alui    ),
    .mem_lui      (mem_lui     ),
    .mem_auipc    (mem_auipc   ),
    .mem_ls       (mem_ls      ),
    .mem_load     (mem_load    ),
    .mem_csr      (mem_csr     ),
    .mem_speci    (mem_speci   ),
    .mem_rd_idx   (mem_rd_idx  ),
    .mem_rd_en    (mem_rd_en   ),
    .mem_result   (mem_result  )

    
);




wire    [31:0]                    mem_rd_data  ;
wire    [31:0]                    data1        ;
wire    [31:0]                    data2        ;
wire    [31:0]                    data3        ;
wire    [31:0]                    data4        ;
wire    [31:0]                    data5        ;
wire    [31:0]                    data6        ;
wire    [31:0]                    data7        ;
wire    [31:0]                    data8        ;
wire    [31:0]                    data9        ;
wire    [31:0]                    data10       ;






mem mem_m0 (
    .clk          (clk         ),
    .rstn         (rstn        ),
    .mem_dec_info (mem_dec_info),
    .mem_op_rs2   (mem_op_rs2  ),
    .mem_jal      (mem_jal     ),
    .mem_jalr     (mem_jalr    ),
    .mem_bjp      (mem_bjp     ),
    .mem_alu      (mem_alu     ),
    .mem_alui     (mem_alui    ),
    .mem_lui      (mem_lui     ),
    .mem_auipc    (mem_auipc   ),
    .mem_ls       (mem_ls      ),
    .mem_load     (mem_load    ),
    .mem_csr      (mem_csr     ),
    .mem_speci    (mem_speci   ),
    .mem_rd_idx   (mem_rd_idx  ),
    .mem_rd_en    (mem_rd_en   ),
    .mem_result   (mem_result  ),

    .mem_rd_data  (mem_rd_data ),
    .data1        (data1       ), 
    .data2        (data2       ),  
    .data3        (data3       ), 
    .data4        (data4       ), 
    .data5        (data5       ), 
    .data6        (data6       ), 
    .data7        (data7       ), 
    .data8        (data8       ), 
    .data9        (data9       ), 
    .data10       (data10      ) 

);













wire    [4:0]                     wb_rd_idx    ;
wire                              wb_rd_en     ;
wire    [31:0]                    wb_rd_data   ;




mem_wb mem_wb_m0 (
    .clk          (clk         ),
    .rstn         (rstn        ),
    .mem_rd_idx   (mem_rd_idx  ),
    .mem_rd_en    (mem_rd_en   ),
    .mem_rd_data  (mem_rd_data ),


    .wb_rd_idx    (wb_rd_idx   ),
    .wb_rd_en     (wb_rd_en    ),
    .wb_rd_data   (wb_rd_data  )

);


  
    
endmodule