module CPU(InstExt, InstLd, CLK, CLEAR_N, IN, OUT_EN, oOUT);
	input [15:0] InstExt;
	input InstLd, CLK, CLEAR_N;
	input [7:0] IN;
	output OUT_EN;
	output [7:0] oOUT;
	
	wire [3:0] oPC, flags;
	wire [15:0] Inst;
	wire fNF, fOF, fZF, REG_WLINE_1, REG_WLINE_0, REG_W_EN, REG_W_ADD_1, REG_W_ADD_0, REG_ADD_4, REG_ADD_3, REG_ADD_2, 
			 REG_ADD_1, REG_ADD_0, ADD_SUB, ALU_S_0, ALU_S_1, FLAG_W, ALU_SL_1, ALU_SL_0, DMEM_W_EN, DMEM_S_ADD, 
			 PC_LD_EN, PC_EN, SWAP_R, ALU_S_2;
	wire [7:0] oDMEM, oALU, oWMR, oRP1, oRP2, oRP3, oIX, oSALU, IXAddr;
	wire [2:0] DMEMAddr;
	
	memory #(.data_width(16), .addr_width(4)) IMEM(.clk(CLK), .data(InstExt), .we(InstLd), .addr(oPC), .q(Inst));
	
	memory #(.data_width(8), .addr_width(3)) DMEM(.clk(CLK), .data(oRP2), .we(DMEM_W_EN), .addr(DMEMAddr), .q(oDMEM));
	
	Control_Unit OpDec(.INST(Inst[15:8]), .NF(fNF), .OF(fOF), .ZF(fZF), .REG_WLINE_1(REG_WLINE_1), .REG_WLINE_0(REG_WLINE_0), .REG_W_EN(REG_W_EN), .REG_W_ADD_1(REG_W_ADD_1), 
							.REG_W_ADD_0(REG_W_ADD_0), .REG_ADD_4(REG_ADD_4), .REG_ADD_3(REG_ADD_3), .REG_ADD_2(REG_ADD_2), .REG_ADD_1(REG_ADD_1), .REG_ADD_0(REG_ADD_0), .ADD_SUB(ADD_SUB), 
							.ALU_S_0(ALU_S_0), .ALU_S_1(ALU_S_1), .FLAG_W(FLAG_W), .ALU_SL_1(ALU_SL_1), .ALU_SL_0(ALU_SL_0), .DMEM_W_EN(DMEM_W_EN), .DMEM_S_ADD(DMEM_S_ADD), 
							.PC_LD_EN(PC_LD_EN), .PC_EN(PC_EN), .OUT_EN(OUT_EN), .SWAP_R(SWAP_R), .ALU_S_2(ALU_S_2));
	
	busmux_4_to_1 WMR(.In1(oALU), .In2(Inst[7:0]), .In3(oDMEM), .In4(IN), .s1(REG_WLINE_1), .s0(REG_WLINE_0), .Out(oWMR));

	mainreg MReg(.IN(oWMR), .MRWE(REG_W_EN), .WA0(REG_W_ADD_0), .WA1(REG_W_ADD_1), .RA0(REG_ADD_0), .RA1(REG_ADD_1), .RA2(REG_ADD_2), .RA3(REG_ADD_3), .RA4(REG_ADD_4), 
					.CLK(CLK), .RESET(CLEAR_N), .SWAPR(SWAP_R), .OUTA(oRP1), .OUTB(oRP2), .OUTC(oRP3), .OIX(oIX));
	
	busmux_4_to_1 SALU(.In1(oRP2), .In2(oRP3), .In3(Inst[7:0]), .In4(oDMEM), .s1(ALU_SL_1), .s0(ALU_SL_0), .Out(oSALU));
	
	ALU alu(.ADD_SUB(ADD_SUB), .Y(oSALU), .X(oRP1), .AS2(ALU_S_2), .AS1(ALU_S_1), .AS0(ALU_S_0), .ZF(flags[0]), .CF(flags[3]), .OF(flags[2]), .NF(flags[1]), .Result(oALU));
	
	Flags flag_reg(.Flags(flags), .FWE(FLAG_W), .CLK(CLK), .RESET(CLEAR_N), .OF(fOF), .NF(fNF), .ZF(fZF));
	
	AddSub8b indexer(.Cin(1'b0), .X(Inst[7:0]), .Y(oIX), .S(IXAddr), .Cout(), .Ov());
	
	busmuxN_2_to_1 #(.N(3)) DMWA(.In1(Inst[2:0]), .In2(IXAddr[2:0]), .S(DMEM_S_ADD), .Out(DMEMAddr));
	
	PC pc(.LOAD(PC_LD_EN), .IN(Inst[3:0]), .PCEN(PC_EN), .CLK(CLK), .RESET(CLEAR_N), .A(oPC));
	
	assign oOUT = oRP1;
	
endmodule