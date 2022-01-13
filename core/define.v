
`define DECODE_XLEN   32










`define DECODE_INFO_LEN   10


//ALU
`define ALU_INFO_LEN   10

`define ALU_ADD   0
`define ALU_SUB   1
`define ALU_SLL   2
`define ALU_SLT   3
`define ALU_SLTU  4
`define ALU_XOR   5
`define ALU_SRL   6
`define ALU_SRA   7
`define ALU_OR    8
`define ALU_AND   9


//ALUI
`define ALUI_INFO_LEN   9

`define ALU_ADDI   0
`define ALU_SLTI   1
`define ALU_SLTIU  2
`define ALU_XORI   3
`define ALU_ORI    4
`define ALU_ANDI   5
`define ALU_SLLI   6
`define ALU_SRLI   7
`define ALU_SRAI   8

//BRU
`define BRU_INFO_LEN   6

`define BRU_BEQ   0
`define BRU_BNE   1
`define BRU_BLT   2
`define BRU_BGE   3
`define BRU_BLTU  4
`define BRU_BGEU  5


//LSU
`define LSU_INFO_LEN   8

`define LSU_LB    0
`define LSU_LH    1
`define LSU_LW    2
`define LSU_LBU   3
`define LSU_LHU   4
`define LSU_SB    5
`define LSU_SH    6
`define LSU_SW    7


//CSR
`define CSR_INFO_LEN   6
`define CSR_CSRRW   0
`define CSR_CSRRS   1
`define CSR_CSRRC   2
`define CSR_CSRRWI  3
`define CSR_CSRRSI  4
`define CSR_CSRRCI  5



//SPECI
`define SPECI_INFO_LEN   8


`define SPECI_FENCE       0
`define SPECI_FENCEI      1
`define SPECI_EBREAK      2
`define SPECI_ECALL       3
`define SPECI_UREF        4
`define SPECI_SRET        5
`define SPECI_MRET        6
`define SPECI_WFI         7




//MSTATUS


`define MSTATUS_UIE      0
`define MSTATUS_SIE      1
`define MSTATUS_WPRI     2
`define MSTATUS_MIE      3
`define MSTATUS_SPIE     4
`define MSTATUS_UPIE     5
`define MSTATUS_WPRI1    6
`define MSTATUS_MPIE     7
`define MSTATUS_SPP      8
`define MSTATUS_WPRI2_L  9
`define MSTATUS_WPRI2_M  10
`define MSTATUS_MPP_L    11
`define MSTATUS_MPP_M    12
`define MSTATUS_FS_L     13
`define MSTATUS_FS_M     14
`define MSTATUS_XS_L     15
`define MSTATUS_XS_M     16
`define MSTATUS_MPRV     17
`define MSTATUS_SUM      18
`define MSTATUS_MXR      19
`define MSTATUS_TVM      20
`define MSTATUS_TW       21
`define MSTATUS_TSR      22
`define MSTATUS_WPRI3_L  23
`define MSTATUS_WPRI3_M  30
`define MSTATUS_SD       31




