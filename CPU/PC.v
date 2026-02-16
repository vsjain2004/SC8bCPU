module PC(LOAD, IN, PCEN, CLK, RESET, A);

	input LOAD, PCEN, CLK, RESET;
	input [3:0] IN;
	output [3:0] A;
	
	wire oReg[3:0], iReg[3:0], aReg[2:0], LD_Reg, Reg_IN[3:0];
	
	assign iReg[0] = oReg[0] ^ PCEN;
	assign aReg[0] = oReg[0] & PCEN;
	assign iReg[1] = oReg[1] ^ aReg[0];
	assign aReg[1] = oReg[1] & aReg[0];
	assign iReg[2] = oReg[2] ^ aReg[1];
	assign aReg[2] = oReg[2] & aReg[1];
	assign iReg[3] = oReg[3] ^ aReg[2];

	assign LD_Reg = LOAD | ~(oReg[0] & oReg[1] & oReg[2] & oReg[3]);

	genvar i;
	generate
		for(i = 0; i < 4; i = i + 1) begin: iPC
			assign Reg_IN[i] = LOAD ? IN[i] : iReg[i];
		end
	endgenerate
	
	register a0(.IN(Reg_IN[0]), .LOAD(LD_Reg), .CLK(CLK), .OUT(oReg[0]), .PRESET_N(1'b1), .CLEAR_N(RESET));
	register a1(.IN(Reg_IN[1]), .LOAD(LD_Reg), .CLK(CLK), .OUT(oReg[1]), .PRESET_N(1'b1), .CLEAR_N(RESET));
	register a2(.IN(Reg_IN[2]), .LOAD(LD_Reg), .CLK(CLK), .OUT(oReg[2]), .PRESET_N(1'b1), .CLEAR_N(RESET));
	register a3(.IN(Reg_IN[3]), .LOAD(LD_Reg), .CLK(CLK), .OUT(oReg[3]), .PRESET_N(1'b1), .CLEAR_N(RESET));
	
	generate
		for(i = 0; i < 4; i = i + 1) begin: oPC
			assign A[i] = oReg[i];
		end
	endgenerate

endmodule