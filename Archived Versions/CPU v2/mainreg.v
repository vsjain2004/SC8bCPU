module mainreg(IN, MRWE, WA0, WA1, RA0, RA1, RA2, RA3, RA4, CLK, RESET, OUTA, OUTB, OUTC, OA, OB, OC, OIX);
	input MRWE, WA0, WA1, RA0, RA1, RA2, RA3, RA4, CLK, RESET;
	input [7:0] IN;
	output [7:0] OUTA, OUTB, OUTC, OA, OB, OC, OIX;
	
	wire [7:0] OZ, OO;
	
	Decoder2to4 decoder(.S1(WA1), .S0(WA0), .EN(MRWE), .Y0(Y0), .Y1(Y1), .Y2(Y2), .Y3(Y3));
	
	reg_8_bit A(.IN(IN), .LOAD(Y0), .CLK(CLK), .OUT(OA), .PRESET_N(1), .CLEAR_N(RESET));
	reg_8_bit B(.IN(IN), .LOAD(Y1), .CLK(CLK), .OUT(OB), .PRESET_N(1), .CLEAR_N(RESET));
	reg_8_bit C(.IN(IN), .LOAD(Y2), .CLK(CLK), .OUT(OC), .PRESET_N(1), .CLEAR_N(RESET));
	reg_8_bit IX(.IN(IN), .LOAD(Y3), .CLK(CLK), .OUT(OIX), .PRESET_N(1), .CLEAR_N(RESET));
	Zeros Z(.Z(OZ));
	Ones O(.O(OO));
	
	busmux_4_to_1 opa(.In1(OA), .In2(OB), .In3(OC), .In4(OIX), .s1(RA1), .s0(RA0), .Out(OUTA));
	busmux_4_to_1 opb(.In1(OA), .In2(OB), .In3(OC), .In4(OIX), .s1(RA3), .s0(RA2), .Out(OUTB));
	busmux_4_to_1 opc(.In1(OZ), .In2(OO), .In3(OZ), .In4(OO), .s1(1), .s0(RA4), .Out(OUTC));
endmodule