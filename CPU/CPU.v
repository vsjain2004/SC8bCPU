module CPU(InstExt, InstLd, CLK, CLEAR_N);
	input [63:0] InstExt;
	input InstLd, CLK, CLEAR_N;
	//output ;
	
	wire [31:0] oPC, oNPC, oDMEM, oRPA, oRPB, oRPC, iPC, ExtImm, Branch_Addr, Jump_Addr, IXAddr, oALU, iX, iY, MultHi, MultLo, DivQ, DivR, iWPA, iWPB;
	wire [63:0] Inst;
	wire fNF, fOF, fZF, fCF, PC_INC, ADD_SUB, REG_WE_A, REG_WE_B, DMEM_W_EN, PC_LD_EN, PC_EN, SIGNED, ALU_X_SEL, DMEM_SEL_ADD, IMEM_R_EN, DMEM_R_EN, OvALU, OvMULT, OvDIV, IMEM_R_EN_CUR;
	wire [1:0] DMEM_DLEN, IMEM_DLEN, PC_IN, REG_SEL_IN_B;
	wire [2:0] ALU_SELECT, ALU_Y_SEL, REG_SEL_IN_A;
	wire [4:0] flags, FLAG_WE, REG_W_ADD_A, REG_W_ADD_B, REG_R_ADD_A, REG_R_ADD_B;
	wire [15:0] IMMEDIATE;
	wire [31:0] DMEMAddr;

	memory2 #(.data_width(16), .addr_width(11)) IMEM(.clk(CLK), .data(InstExt), .we(InstLd), .re(IMEM_R_EN_CUR), .addr(oPC[11:1]), .dlen(IMEM_DLEN), .q(Inst));
	
	memory2 DMEM(.clk(CLK), .data(oRPA), .we(DMEM_W_EN), .re(DMEM_R_EN), .addr(DMEMAddr[11:0]), .dlen(DMEM_DLEN), .q(oDMEM));
	
	Opcode_Decoder decoder(.PC_IMEM(Inst[31:0]), .CF(fCF), .OF(fOF), .NF(fNF), .ZF(fZF), .CLK(CLK), .RESET(CLEAR_N), .PC_INC(PC_INC), 
		.ADD_SUB(ADD_SUB), .REG_WE_A(REG_WE_A), .REG_WE_B(REG_WE_B), .DMEM_W_EN(DMEM_W_EN), .PC_LD_EN(PC_LD_EN), .PC_EN(PC_EN), 
		.SIGNED(SIGNED), .ALU_X_SEL(ALU_X_SEL), .DMEM_SEL_ADD(DMEM_SEL_ADD), .IMEM_R_EN(IMEM_R_EN), .DMEM_R_EN(DMEM_R_EN),
		.DMEM_DLEN(DMEM_DLEN), .IMEM_DLEN(IMEM_DLEN), .PC_IN(PC_IN), .REG_SEL_IN_B(REG_SEL_IN_B), .ALU_SELECT(ALU_SELECT), 
		.ALU_Y_SEL(ALU_Y_SEL), .REG_SEL_IN_A(REG_SEL_IN_A), .FLAG_WE(FLAG_WE), .REG_W_ADD_A(REG_W_ADD_A), 
		.REG_W_ADD_B(REG_W_ADD_B), .REG_R_ADD_A(REG_R_ADD_A), .REG_R_ADD_B(REG_R_ADD_B), .IMMEDIATE(IMMEDIATE));

	dffg imem_r_en(.d(IMEM_R_EN), .clk(CLK), .prn(RESET), .clrn(1'b1), .q(IMEM_R_EN_CUR));

	Extender extender(.IN(IMMEDIATE), .Sign(SIGNED), .Out(ExtImm));

	assign Jump_Addr = {oNPC[31:17], IMMEDIATE, 1'b0};
	
	busmuxN_4_to_1 WPB_sel(.In1(oRPB), .In2(oNPC), .In3(MultHi), .In4(DivR), .s1(REG_SEL_IN_B[1]), .s0(REG_SEL_IN_B[0]), .Out(iWPB));

	busmuxN_8_to_1 WPA_sel(.S(REG_SEL_IN_A), .W0(oALU), .W1(oRPA), .W2(ExtImm), .W3({IMMEDIATE, 16'b0}), .W4(oDMEM), .W5(Jump_Addr), .W6(MultLo), .W7(DivQ), .F(iWPA));
	
	mainreg MReg(.INA(iWPA), .INB(iWPB), .MRWEA(REG_WE_A), .MRWEB(REG_WE_B), .WAA(REG_W_ADD_A), .WAB(REG_W_ADD_B), .RAA(REG_R_ADD_A), 
				 .RAB(REG_R_ADD_B), .CLK(CLK), .RESET(CLEAR_N), .OUTA(oRPA), .OUTB(oRPB), .OUTC(oRPC));

	assign iX = ALU_X_SEL ? oRPB : oRPA;

	busmuxN_8_to_1 Y_sel(.S(ALU_Y_SEL), .W0(oRPB), .W1(oRPA), .W2(oRPC), .W3(ExtImm), .W4(oDMEM), .W5(REG_R_ADD_B), .W6(oPC), .W7(), .F(iY));
	
	ALU alu(.ADD_SUB(ADD_SUB), .Y(iY), .X(iX), .AS2(ALU_S_2), .AS1(ALU_S_1), .AS0(ALU_S_0), .ZF(flags[0]), 
			.CF(flags[3]), .OF(OvALU), .NF(flags[1]), .Result(oALU));

	MULT_N_bit multiplier(.X(iX), .Y(iY), .Signed(SIGNED), .OutHi(MultHi), .OutLo(MultLo), .Ov(OvMULT));

	DIV_N_bit divider(.X(iX), .Y(iY), .Signed(SIGNED), .OutQ(DivQ), .OutR(DivR), .D0(flags[4]), .Ov(OvDIV));

	assign flags[2] = OvALU | OvMULT | OvDIV;
	
	Flags flag_reg(.Flags(flags), .FWE(FLAG_WE), .CLK(CLK), .RESET(CLEAR_N), .CF(fCF), .OF(fOF), .NF(fNF), .ZF(fZF), .D0());
	
	AddSub_N_bit indexed_addr(.Cin(1'b0), .X(oRPB), .Y(ExtImm), .S(IXAddr), .Cout(), .Ov());
	
	assign DMEMAddr = DMEM_SEL_ADD ? IXAddr : oRPB;

	AddSub_N_bit branch_addr(.Cin(1'b0), .X(oNPC), .Y({ExtImm[30:0], 1'b0}), .S(Branch_Addr), .Cout(), .Ov());

	busmuxN_4_to_1 pc_in(.In1(oRPA), .In2(oRPB), .In3(Branch_Addr), .In4(), .s1(PC_IN[1]), .s0(PC_IN[0]), .Out(iPC));
	
	PC Prog_Counter(.LOAD(PC_LD_EN), .IN(iPC), .ULen(PC_INC), .PCEN(PC_EN), .CLK(CLK), .RESET(CLEAR_N), .oPC(oPC), .oNPC(oNPC));
	
endmodule