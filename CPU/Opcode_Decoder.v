module Opcode_Decoder(
    input [31:0] PC_IMEM,
    input CF, OF, NF, ZF, CLK, RESET,
    output PC_INC, ADD_SUB, REG_WE_A, REG_WE_B, DMEM_W_EN, PC_LD_EN, PC_EN, SIGNED, ALU_X_SEL, DMEM_SEL_ADD, IMEM_R_EN, DMEM_R_EN,
    output [1:0] DMEM_DLEN, PC_IN, REG_SEL_IN_B,
    output [2:0] ALU_SELECT, ALU_Y_SEL, REG_SEL_IN_A,
    output [4:0] FLAG_WE, REG_W_ADD_A, REG_W_ADD_B, REG_R_ADD_A, REG_R_ADD_B,
    output [15:0] IMMEDIATE
);
    
    wire [15:0] Next_Inst_In, Next_Inst_Out, op1, op2;
    wire Has_Next_In, Has_Next_Out, opmode, NOOP, I_END, INC, DEC, MOV, SWAPR, CMPR, NOT, ADDR_DEST, SUBR_DEST, JMPR, 
    JRALR, JPNR, JPER, JGTR, JGER, LDM, LDMU, LDW, LDH, LDB, STW, STH, STB, ORM, JPN, JPE, JGT, LDJ, ADDD, ADDR, SUBD, 
    SUBR, ANDD, ANDR, ORD, ORR, XORD, XORR, ASR, ASRR, LSL, LSLR, LSR, LSRR, CSL, CSLR, CSR, CSRR, MULTD, MULTR, MULTDU, 
    MULTRU, DIVD, DIVR, DIVDU, DIVRU, JGTRU, JGERU, CMD, ADDPC, Fam_code[3:0];
    wire [3:0] opcode, FuncL4;
    wire [4:0] R1_Rd_Rd1, R2_R1, R2, FuncH5_Rd2;
    wire [1:0] Family;

    assign Next_Inst_In = PC_LD_EN ? 16'b0 : PC_IMEM[31:16];
    assign Has_Next_In = PC_LD_EN ? 1'b0 : (~Has_Next_Out & ~|PC_IMEM[1:0]);
    assign PC_INC = (~Next_Inst_Out[1] & Next_Inst_Out[0] & Has_Next_Out) | (~PC_IMEM[1] & PC_IMEM[0] & ~Has_Next_Out);

    reg_N_bit #(.N(16)) Next_Inst(.IN(Next_Inst_In), .LOAD(Has_Next_In), .CLK(CLK), .OUT(Next_Inst_Out), .PRESET_N(1'b1), .CLEAR_N(RESET));
    register Has_Next(.IN(Has_Next_In), .LOAD(1'b1), .CLK(CLK), .OUT(Has_Next_Out), .PRESET_N(1'b1), .CLEAR_N(RESET));

    assign opcode = (~Next_Inst_Out[1] & Next_Inst_Out[0] & Has_Next_Out) ? PC_IMEM[15:12] : 
                    ((~|Next_Inst_Out[1:0] & Has_Next_Out) ? Next_Inst_Out[15:12] : 
                    (~|PC_IMEM[1:0] ? PC_IMEM[15:12] : PC_IMEM[31:28]));

    assign opmode = (~Next_Inst_Out[1] & Next_Inst_Out[0] & Has_Next_Out) ? 1'b1 : 
                    ((~|Next_Inst_Out[1:0] & Has_Next_Out) ? 1'b0 : 
                    (~|PC_IMEM[1:0] ? 1'b0 : 1'b1));
    
    assign R1_Rd_Rd1 = (~Next_Inst_Out[1] & Next_Inst_Out[0] & Has_Next_Out) ? PC_IMEM[11:7] : 
                       ((~|Next_Inst_Out[1:0] & Has_Next_Out) ? Next_Inst_Out[11:7] : 
                       (~|PC_IMEM[1:0] ? PC_IMEM[11:7] : PC_IMEM[27:23]));

    assign R2_R1 = (~Next_Inst_Out[1] & Next_Inst_Out[0] & Has_Next_Out) ? PC_IMEM[6:2] : 
                   ((~|Next_Inst_Out[1:0] & Has_Next_Out) ? Next_Inst_Out[6:2] : 
                   (~|PC_IMEM[1:0] ? PC_IMEM[6:2] : PC_IMEM[22:18]));

    assign R2 = (~Next_Inst_Out[1] & Next_Inst_Out[0] & Has_Next_Out) ? {PC_IMEM[1:0], Next_Inst_Out[15:13]} : 
                ((~|Next_Inst_Out[1:0] & Has_Next_Out) ? 5'b0 : (~|PC_IMEM[1:0] ? 5'b0 : PC_IMEM[17:13]));

    assign Family = (~Next_Inst_Out[1] & Next_Inst_Out[0] & Has_Next_Out) ? {PC_IMEM[1:0], Next_Inst_Out[12:11]} : 
                    ((~|Next_Inst_Out[1:0] & Has_Next_Out) ? 2'b0 : (~|PC_IMEM[1:0] ? 2'b0 : PC_IMEM[12:11]));

    assign FuncH5_Rd2 = (~Next_Inst_Out[1] & Next_Inst_Out[0] & Has_Next_Out) ? Next_Inst_Out[10:6] : 
                        ((~|Next_Inst_Out[1:0] & Has_Next_Out) ? 5'b0 : (~|PC_IMEM[1:0] ? 5'b0 : PC_IMEM[10:6]));

    assign FuncL4 = (~Next_Inst_Out[1] & Next_Inst_Out[0] & Has_Next_Out) ? Next_Inst_Out[5:2] : 
                    ((~|Next_Inst_Out[1:0] & Has_Next_Out) ? 4'b0 : (~|PC_IMEM[1:0] ? 4'b0 : PC_IMEM[5:2]));

    assign IMMEDIATE = (~Next_Inst_Out[1] & Next_Inst_Out[0] & Has_Next_Out) ? {PC_IMEM[1:0], Next_Inst_Out[15:2]} : 
                       ((~|Next_Inst_Out[1:0] & Has_Next_Out) ? 16'b0 : (~|PC_IMEM[1:0] ? 16'b0 : PC_IMEM[17:2]));

    decoder4to16 opdef1(.S(opcode), .O(op1));

    decoder2to4 famdef(.S1(Family[1]), .S0(Family[0]), .EN(opmode), .Y0(Fam_code[0]), .Y1(Fam_code[1]), .Y2(Fam_code[2]), .Y3(Fam_code[3]));

    decoder4to16 funcdef(.S(FuncL4), .O(op2));

    assign NOOP = op1[0] & ~opmode;
    assign I_END = op1[1] & ~opmode;
    assign INC = op1[2] & ~opmode;
    assign DEC = op1[3] & ~opmode;
    assign MOV = op1[4] & ~opmode;
    assign SWAPR = op1[5] & ~opmode;
    assign CMPR = op1[6] & ~opmode;
    assign NOT = op1[7] & ~opmode;
    assign ADDR_DEST = op1[8] & ~opmode;
    assign SUBR_DEST = op1[9] & ~opmode;
    assign JMPR = op1[10] & ~opmode;
    assign JRALR = op1[11] & ~opmode;
    assign JPNR = op1[12] & ~opmode;
    assign JPER = op1[13] & ~opmode;
    assign JGTR = op1[14] & ~opmode;
    assign JGER = op1[15] & ~opmode;
    assign LDM = op1[0] & opmode;
    assign LDMU = op1[1] & opmode;
    assign LDW = op1[2] & opmode;
    assign LDH = op1[3] & opmode;
    assign LDB = op1[4] & opmode;
    assign STW = op1[5] & opmode;
    assign STH = op1[6] & opmode;
    assign STB = op1[7] & opmode;
    assign ORM = op1[8] & opmode;
    assign JPN = op1[9] & opmode;
    assign JPE = op1[10] & opmode;
    assign JGT = op1[11] & opmode;
    assign LDJ = op1[12] & opmode;
    assign ADDD = op1[13] & Fam_code[0] & op2[0] & opmode;
    assign ADDR = op1[13] & Fam_code[0] & op2[1] & opmode;
    assign SUBD = op1[13] & Fam_code[0] & op2[2] & opmode;
    assign SUBR = op1[13] & Fam_code[0] & op2[3] & opmode;
    assign ANDD = op1[13] & Fam_code[1] & op2[0] & opmode;
    assign ANDR = op1[13] & Fam_code[1] & op2[1] & opmode;
    assign ORD = op1[13] & Fam_code[1] & op2[2] & opmode;
    assign ORR = op1[13] & Fam_code[1] & op2[3] & opmode;
    assign XORD = op1[13] & Fam_code[1] & op2[4] & opmode;
    assign XORR = op1[13] & Fam_code[1] & op2[5] & opmode;
    assign ASR = op1[13] & Fam_code[1] & op2[6] & opmode;
    assign ASRR = op1[13] & Fam_code[1] & op2[7] & opmode;
    assign LSL = op1[13] & Fam_code[1] & op2[8] & opmode;
    assign LSLR = op1[13] & Fam_code[1] & op2[9] & opmode;
    assign LSR = op1[13] & Fam_code[1] & op2[10] & opmode;
    assign LSRR = op1[13] & Fam_code[1] & op2[11] & opmode;
    assign CSL = op1[13] & Fam_code[1] & op2[12] & opmode;
    assign CSLR = op1[13] & Fam_code[1] & op2[13] & opmode;
    assign CSR = op1[13] & Fam_code[1] & op2[14] & opmode;
    assign CSRR = op1[13] & Fam_code[1] & op2[15] & opmode;
    assign MULTD = op1[13] & Fam_code[2] & op2[0] & opmode;
    assign MULTR = op1[13] & Fam_code[2] & op2[1] & opmode;
    assign MULTDU = op1[13] & Fam_code[2] & op2[2] & opmode;
    assign MULTRU = op1[13] & Fam_code[2] & op2[3] & opmode;
    assign DIVD = op1[13] & Fam_code[2] & op2[4] & opmode;
    assign DIVR = op1[13] & Fam_code[2] & op2[5] & opmode;
    assign DIVDU = op1[13] & Fam_code[2] & op2[6] & opmode;
    assign DIVRU = op1[13] & Fam_code[2] & op2[7] & opmode;
    assign JGTRU = op1[13] & Fam_code[3] & op2[0] & opmode;
    assign JGERU = op1[13] & Fam_code[3] & op2[1] & opmode;
    assign CMD = op1[13] & Fam_code[3] & op2[2] & opmode;
    assign ADDPC = op1[13] & Fam_code[3] & op2[3] & opmode;

    assign ADD_SUB = INC | CMPR | SUBR_DEST | SUBD | SUBR | LSR | LSRR | CSR | CSRR | CMD;
    assign ALU_SELECT = {(NOT | ASR | ASRR | LSL | LSLR | LSR | LSRR | CSL | CSLR | CSR | CSRR), 
                         (ORM | ORD | ORR | XORD | XORR | ASR | ASRR | CSL | CSLR | CSR | CSRR), 
                         (ANDD | ANDR | XORD | XORR | LSL | LSLR | LSR | LSRR | CSL | CSLR | CSR | CSRR)};
    assign FLAG_WE = {(DIVD | DIVR | DIVDU | DIVRU), (CMPR | ADDR_DEST | SUBR_DEST | ADDD | ADDR | SUBD | SUBR),
                      (CMPR | ADDR_DEST | SUBR_DEST | Fam_code[0] | Fam_code[2] | CMD),
                      (CMPR | ADDR_DEST | SUBR_DEST | Fam_code[0] | CMD), (CMPR | ADDR_DEST | SUBR_DEST | Fam_code[0] | CMD)};
    assign REG_WE_A = ~(NOOP | I_END | CMPR | JMPR | JRALR | JPNR | JPER | JGTR | JGER | STW | STH | STB | JPN | JPE | JGT | JGTRU | JGERU | CMD);
    assign REG_W_ADD_A = R1_Rd_Rd1;
    assign REG_WE_B = SWAPR | JRALR | Fam_code[2];
    assign REG_W_ADD_B = ({5{SWAPR | JRALR}} & R2_R1) | FuncH5_Rd2;
    assign REG_R_ADD_A = ({5{STW | STH | STB}} & R1_Rd_Rd1) | R2_R1;
    assign REG_R_ADD_B = ({5{~opmode}} & R1_Rd_Rd1) | ({5{LDW | LDH | LDB | STW | STH | STB}} & R2_R1) | R2;
    assign DMEM_W_EN = STW | STH | STB;
    assign DMEM_DLEN = {(LDW | STW | ADDD | SUBD | ANDD | ORD | XORD | MULTD | MULTDU | DIVD | DIVDU | CMD),
                        (LDW | LDH | STW | STH | ADDD | SUBD | ANDD | ORD | XORD | MULTD | MULTDU | DIVD | DIVDU | CMD)};
    assign PC_LD_EN = JMPR | JRALR | ((JPE | JPER) & ZF) | ((JPN | JPNR) & ~ZF) | ((JGT | JGTR) & ~ZF & (NF ~^ OF)) | (JGER & (NF ~^ OF)) | (JGTRU & ~ZF & CF) | (JGERU & CF);
    assign PC_EN = ~I_END;
    assign SIGNED = LDM | LDW | LDH | LDB | STW | STH | STB | JPN | JPE | JGT | MULTD | MULTR | DIVD | DIVR;
    assign PC_IN = {(JPN | JPE | JGT), (JMPR | JRALR | JPNR | JPER | JGTR | JGER)};
    assign ALU_X_SEL = INC | DEC | CMPR | ADDR_DEST | SUBR_DEST;
    assign ALU_Y_SEL = {(ADDD | SUBD | ANDD |ORD | XORD | ASR | LSL | LSR | CSL | CSR | MULTD | MULTDU | DIVD | DIVDU | CMD | ADDPC), 
                        (INC | DEC | ORM | ADDPC), (CMPR | ADDR_DEST | SUBR_DEST | ORM | ASR | LSL | LSR | CSL | CSR)};
    assign DMEM_SEL_ADD = LDW | LDH | LDB | STW | STH | STB;
    assign REG_SEL_IN_A = {(LDW | LDH | LDB | LDJ | Fam_code[2]), (LDM | LDMU | Fam_code[2]), 
                           (MOV | SWAPR | LDMU | LDJ | DIVD | DIVR | DIVDU | DIVRU)};
    assign REG_SEL_IN_B = {Fam_code[2], (JRALR | DIVD | DIVR | DIVDU | DIVRU)};
    assign IMEM_R_EN = ~|PC_IMEM[1:0] & ~|PC_IMEM[17:16];
    assign DMEM_R_EN = LDW | LDH | LDB | ADDD | SUBD | ANDD | ORD | XORD | MULTD | MULTDU | DIVD | DIVDU | CMD;
endmodule