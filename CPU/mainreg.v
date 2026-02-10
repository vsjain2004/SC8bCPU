module mainreg(IN, MRWE, WA0, WA1, RA0, RA1, RA2, RA3, RA4, CLK, RESET, SWAPR, OUTA, OUTB, OUTC, OA, OB, OC, OIX);
	input MRWE, WA0, WA1, RA0, RA1, RA2, RA3, RA4, CLK, RESET, SWAPR;
	input [7:0] IN;
	output [7:0] OUTA, OUTB, OUTC, OA, OB, OC, OIX;
	
	wire [7:0] OZ, OO;
	wire DeEN, RS1, RS0, RY0, RY1, RY2, RY3, SY0, SY1, SY2, SY3, Y0, Y1, Y2, Y3;
	
	assign DeEN = SWAPR | MRWE;
	assign RS1 = SWAPR ? RA1 : WA1;
	assign RS0 = SWAPR ? RA0 : WA0;
	Decoder2to4 decoder(.S1(RS1), .S0(RS0), .EN(DeEN), .Y0(RY0), .Y1(RY1), .Y2(RY2), .Y3(RY3));
	
	Decoder2to4 decoder2(.S1(RA3), .S0(RA2), .EN(SWAPR), .Y0(SY0), .Y1(SY1), .Y2(SY2), .Y3(SY3));
	
	assign Y0 = SY0 | RY0;
	assign Y1 = SY1 | RY1;
	assign Y2 = SY2 | RY2;
	assign Y3 = SY3 | RY3;
	
	wire [7:0] INA, INB, INC, INIX;
	
	assign INA = SWAPR ? (~(RA1 | RA0) ? OUTB : OUTA) : IN;
	assign INB = SWAPR ? ((~RA1 & RA0) ? OUTB : OUTA) : IN;
	assign INC = SWAPR ? ((RA1 & ~RA0) ? OUTB : OUTA) : IN;
	assign INIX = SWAPR ? ((RA1 & RA0) ? OUTB : OUTA) : IN;
	
	reg_8_bit A(.IN(INA), .LOAD(Y0), .CLK(CLK), .OUT(OA), .PRESET_N(1'b1), .CLEAR_N(RESET));
	reg_8_bit B(.IN(INB), .LOAD(Y1), .CLK(CLK), .OUT(OB), .PRESET_N(1'b1), .CLEAR_N(RESET));
	reg_8_bit C(.IN(INC), .LOAD(Y2), .CLK(CLK), .OUT(OC), .PRESET_N(1'b1), .CLEAR_N(RESET));
	reg_8_bit IX(.IN(INIX), .LOAD(Y3), .CLK(CLK), .OUT(OIX), .PRESET_N(1'b1), .CLEAR_N(RESET));
	Zeros Z(.Z(OZ));
	Ones O(.O(OO));
	
	busmux_4_to_1 opa(.In1(OA), .In2(OB), .In3(OC), .In4(OIX), .s1(RA1), .s0(RA0), .Out(OUTA));
	busmux_4_to_1 opb(.In1(OA), .In2(OB), .In3(OC), .In4(OIX), .s1(RA3), .s0(RA2), .Out(OUTB));
	busmux_4_to_1 opc(.In1(OZ), .In2(OO), .In3(OZ), .In4(OO), .s1(1), .s0(RA4), .Out(OUTC));
endmodule