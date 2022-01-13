`include "define.v"

module csr (
   input                                  clk           ,
   input                                  rstn          ,
   input                                  exe_csr       ,
   input                                  exe_speci     ,
   input       [31:0]                     exe_pc        ,
   input       [11:0]                     exe_csr_addr  ,
   input       [31:0]                     op_rs1       ,
   input       [31:0]                     exe_imm       ,
   input       [`DECODE_INFO_LEN-1:0]     exe_dec_info  ,
   input                                  wb_rd_en      ,
   input       [31:0]                     exe_inst      ,
   
   output      [31:0]                     csr_rdata     ,
   output                                 is_trap       ,
   output                                 is_mret       
);
    
reg    [31:0]    fflags     ;
reg    [31:0]    frm        ;
reg    [31:0]    fcsr       ;
reg    [31:0]    mstatus    ;
reg    [31:0]    misa       ;
reg    [31:0]    mie        ;
reg    [31:0]    mtvec      ;
reg    [31:0]    mscratch   ;
reg    [31:0]    mepc       ;
reg    [31:0]    mcause     ;
reg    [31:0]    mtval      ;
reg    [31:0]    mip        ;
reg    [31:0]    mcycle     ;
reg    [31:0]    mcycleh    ;
reg    [31:0]    minstret   ;
reg    [31:0]    minstreth  ;
reg    [31:0]    mvendoid   ;
reg    [31:0]    marchid    ;
reg    [31:0]    mimpid     ;
reg    [31:0]    mhartid    ;




wire  csrrw   =  exe_csr &  exe_dec_info[`CSR_CSRRW ] ;
wire  csrrs   =  exe_csr &  exe_dec_info[`CSR_CSRRS ] ;
wire  csrrc   =  exe_csr &  exe_dec_info[`CSR_CSRRC ] ;
wire  csrrwi  =  exe_csr &  exe_dec_info[`CSR_CSRRWI] ;
wire  csrrsi  =  exe_csr &  exe_dec_info[`CSR_CSRRSI] ;
wire  csrrci  =  exe_csr &  exe_dec_info[`CSR_CSRRCI] ;

wire [31:0] csr_wdata = ({32{csrrw }} & op_rs1            ) |
                        ({32{csrrs }} & op_rs1 | csr_rdata) |
                        ({32{csrrc }} & op_rs1 & csr_rdata) |
                        ({32{csrrwi}} & exe_imm                 ) |
                        ({32{csrrsi}} & exe_imm  | csr_rdata    ) |
                        ({32{csrrci}} & exe_imm  | csr_rdata    ) ;
                        





assign  csr_rdata = 32'b0;

//({32{exe_csr_addr == 12'h001}} & fflags   )  |
//                    ({32{exe_csr_addr == 12'h002}} & frm      )  |
//                    ({32{exe_csr_addr == 12'h003}} & fcsr     )  |
//                    ({32{exe_csr_addr == 12'h300}} & mstatus  )  |
//                    ({32{exe_csr_addr == 12'h301}} & misa     )  |
//                    ({32{exe_csr_addr == 12'h304}} & mie      )  |
//                    ({32{exe_csr_addr == 12'h305}} & mtvec    )  |
//                    ({32{exe_csr_addr == 12'h340}} & mscratch )  |
//                    ({32{exe_csr_addr == 12'h341}} & mepc     )  |
//                    ({32{exe_csr_addr == 12'h342}} & mcause   )  |
//                    ({32{exe_csr_addr == 12'h343}} & mtval    )  |
//                    ({32{exe_csr_addr == 12'h344}} & mip      )  |
//                    ({32{exe_csr_addr == 12'hb00}} & mcycle   )  |
//                    ({32{exe_csr_addr == 12'hb80}} & mcycleh  )  |
//                    ({32{exe_csr_addr == 12'hb02}} & minstret )  |
//                    ({32{exe_csr_addr == 12'hb82}} & minstreth)  |
//                    ({32{exe_csr_addr == 12'hf11}} & mvendoid )  |
//                    ({32{exe_csr_addr == 12'hf12}} & marchid  )  |
//                    ({32{exe_csr_addr == 12'hf13}} & mimpid   )  |
//                    ({32{exe_csr_addr == 12'hf14}} & mhartid  )  ;


always@(posedge clk or negedge rstn) begin
    if(~rstn) begin
        fflags    <= 32'b0;  
        frm       <= 32'b0;
        fcsr      <= 32'b0;
        mstatus   <= 32'b0;
        misa      <= 32'b0;
        mie       <= 32'b0;
        mtvec     <= 32'b0;
        mscratch  <= 32'b0;
        mepc      <= 32'b0;
        mcause    <= 32'b0;
        mtval     <= 32'b0;
        mip       <= 32'b0;
        mcycle    <= 32'b0;
        mcycleh   <= 32'b0;
        minstret  <= 32'b0;
        minstreth <= 32'b0;
        mvendoid  <= 32'b0;
        marchid   <= 32'b0;
        mimpid    <= 32'b0;
        mhartid   <= 32'b0;
    end else if(exe_csr ) begin
        case(exe_csr_addr)
            12'h001 : fflags    <= csr_wdata;
            12'h002 : frm       <= csr_wdata;
            12'h003 : fcsr      <= csr_wdata;
            12'h300 : mstatus   <= csr_wdata;
            12'h301 : misa      <= csr_wdata;
            12'h304 : mie       <= csr_wdata;
            12'h305 : mtvec     <= csr_wdata;
            12'h340 : mscratch  <= csr_wdata;
            12'h341 : mepc      <= csr_wdata;
            12'h342 : mcause    <= csr_wdata;
            12'h343 : mtval     <= csr_wdata;
            12'h344 : mip       <= csr_wdata;
            12'hB00 : mcycle    <= csr_wdata;
            12'hB80 : mcycleh   <= csr_wdata;
            12'hB02 : minstret  <= csr_wdata;
            12'hB82 : minstreth <= csr_wdata;
            12'hF11 : mvendoid  <= csr_wdata;
            12'hF12 : marchid   <= csr_wdata;
            12'hF13 : mimpid    <= csr_wdata;
            12'hF14 : mhartid   <= csr_wdata;
            default : ;
        endcase
    end
end



wire  fence    =  exe_speci &  exe_dec_info[`SPECI_FENCE ] ;
wire  fence_i  =  exe_speci &  exe_dec_info[`SPECI_FENCEI] ;
wire  ebreak   =  exe_speci &  exe_dec_info[`SPECI_EBREAK] ;
wire  ecall    =  exe_speci &  exe_dec_info[`SPECI_ECALL ] ;
wire  uref     =  exe_speci &  exe_dec_info[`SPECI_UREF  ] ;
wire  sret     =  exe_speci &  exe_dec_info[`SPECI_SRET  ] ;
wire  mret     =  exe_speci &  exe_dec_info[`SPECI_MRET  ] ;
wire  wfi      =  exe_speci &  exe_dec_info[`SPECI_WFI   ] ;


reg is_trap;
reg is_mret;


always@(*) begin
    if(ebreak | ecall) begin
        mepc <= exe_pc;
    end
    if(mret) begin
//        mstatus[`MSTATUS_MIE] = mstatus[`MSTATUS_MPIE];
//        mstatus[`MSTATUS_MPIE] = 1;
        is_trap <= 0;
	    is_mret <= 1;
    end
    else if (ecall) begin
//	    mcause	= 11;	
//	    mstatus[`MSTATUS_MPIE] = mstatus[`MSTATUS_MIE]; 
//	    mstatus[`MSTATUS_MIE] = 0;
//	    mtval	=	exe_inst;
	    is_trap <= 1;
	    is_mret <= 0;
    end
   end
    


endmodule


