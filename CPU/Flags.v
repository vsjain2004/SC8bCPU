module Flags(
	input [4:0] Flags,
	input [4:0] FWE,
	input CLK, RESET,
	output D0, CF, OF, NF, ZF
);
	
	
	register D(.IN(Flags[4]), .LOAD(FWE[4]), .CLK(CLK), .OUT(D0), .PRESET_N(1'b1), .CLEAR_N(RESET));
	register C(.IN(Flags[3]), .LOAD(FWE[3]), .CLK(CLK), .OUT(CF), .PRESET_N(1'b1), .CLEAR_N(RESET));
	register O(.IN(Flags[2]), .LOAD(FWE[2]), .CLK(CLK), .OUT(OF), .PRESET_N(1'b1), .CLEAR_N(RESET));
	register N(.IN(Flags[1]), .LOAD(FWE[1]), .CLK(CLK), .OUT(NF), .PRESET_N(1'b1), .CLEAR_N(RESET));
	register Z(.IN(Flags[0]), .LOAD(FWE[0]), .CLK(CLK), .OUT(ZF), .PRESET_N(1'b1), .CLEAR_N(RESET));
	
endmodule