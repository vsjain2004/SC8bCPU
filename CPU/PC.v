module PC(LOAD, IN, PCEN, Clock, RESET, A);

	input LOAD, PCEN, Clock, RESET;
	input [3:0] IN;
	output [3:0] A;
	
	wire oReg[3:0], iReg[3:0], aReg[2:0];
	
	assign iReg[0] = oReg[0] ^ PCEN;
	assign aReg[0] = oReg[0] & PCEN;
	assign iReg[1] = oReg[1] ^ aReg[0];
	assign aReg[1] = oReg[1] & aReg[0];
	assign iReg[2] = oReg[2] ^ aReg[1];
	assign aReg[2] = oReg[2] & aReg[1];
	assign iReg[3] = oReg[3] ^ aReg[2];
	
	register a0(.IN(iReg[3]), .LOAD(LOAD), .CLK(Clock), .OUT(oReg[0]), .PRESET_N(1'b1), .CLEAR_N(RESET));
	register a1(.IN(iReg[2]), .LOAD(LOAD), .CLK(Clock), .OUT(oReg[1]), .PRESET_N(1'b1), .CLEAR_N(RESET));
	register a2(.IN(iReg[1]), .LOAD(LOAD), .CLK(Clock), .OUT(oReg[2]), .PRESET_N(1'b1), .CLEAR_N(RESET));
	register a3(.IN(iReg[0]), .LOAD(LOAD), .CLK(Clock), .OUT(oReg[3]), .PRESET_N(1'b1), .CLEAR_N(RESET));

endmodule