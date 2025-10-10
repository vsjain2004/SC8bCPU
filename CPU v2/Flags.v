module Flags(Flags, FWE, CLK, RESET, CF, OF, NF, ZF);
	input FWE, CLK, RESET;
	input [3:0] Flags;
	output CF, NF, OF, ZF;
	
	register A(.IN(Flags[3]), .LOAD(FWE), .CLK(CLK), .OUT(CF), .PRESET_N(1), .CLEAR_N(RESET));
	register B(.IN(Flags[2]), .LOAD(FWE), .CLK(CLK), .OUT(OF), .PRESET_N(1), .CLEAR_N(RESET));
	register C(.IN(Flags[1]), .LOAD(FWE), .CLK(CLK), .OUT(NF), .PRESET_N(1), .CLEAR_N(RESET));
	register D(.IN(Flags[0]), .LOAD(FWE), .CLK(CLK), .OUT(ZF), .PRESET_N(1), .CLEAR_N(RESET));
	
endmodule