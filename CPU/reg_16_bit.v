module reg_16_bit(IN, LOAD, CLK, OUT, RESET);
	input [15:0] IN;
	input LOAD, CLK, RESET;
	output [15:0] OUT;
	
	register reg0(.IN(IN[0]), .LOAD(LOAD), .CLK(CLK), .OUT(OUT[0]), .PRESET_N(1), .CLEAR_N(RESET));
	register reg1(.IN(IN[1]), .LOAD(LOAD), .CLK(CLK), .OUT(OUT[1]), .PRESET_N(1), .CLEAR_N(RESET));
	register reg2(.IN(IN[2]), .LOAD(LOAD), .CLK(CLK), .OUT(OUT[2]), .PRESET_N(1), .CLEAR_N(RESET));
	register reg3(.IN(IN[3]), .LOAD(LOAD), .CLK(CLK), .OUT(OUT[3]), .PRESET_N(1), .CLEAR_N(RESET));
	register reg4(.IN(IN[4]), .LOAD(LOAD), .CLK(CLK), .OUT(OUT[4]), .PRESET_N(1), .CLEAR_N(RESET));
	register reg5(.IN(IN[5]), .LOAD(LOAD), .CLK(CLK), .OUT(OUT[5]), .PRESET_N(1), .CLEAR_N(RESET));
	register reg6(.IN(IN[6]), .LOAD(LOAD), .CLK(CLK), .OUT(OUT[6]), .PRESET_N(1), .CLEAR_N(RESET));
	register reg7(.IN(IN[7]), .LOAD(LOAD), .CLK(CLK), .OUT(OUT[7]), .PRESET_N(1), .CLEAR_N(RESET));
	register reg8(.IN(IN[8]), .LOAD(LOAD), .CLK(CLK), .OUT(OUT[8]), .PRESET_N(1), .CLEAR_N(RESET));
	register reg9(.IN(IN[9]), .LOAD(LOAD), .CLK(CLK), .OUT(OUT[9]), .PRESET_N(1), .CLEAR_N(RESET));
	register reg10(.IN(IN[10]), .LOAD(LOAD), .CLK(CLK), .OUT(OUT[10]), .PRESET_N(1), .CLEAR_N(RESET));
	register reg11(.IN(IN[11]), .LOAD(LOAD), .CLK(CLK), .OUT(OUT[11]), .PRESET_N(1), .CLEAR_N(RESET));
	register reg12(.IN(IN[12]), .LOAD(LOAD), .CLK(CLK), .OUT(OUT[12]), .PRESET_N(1), .CLEAR_N(RESET));
	register reg13(.IN(IN[13]), .LOAD(LOAD), .CLK(CLK), .OUT(OUT[13]), .PRESET_N(1), .CLEAR_N(RESET));
	register reg14(.IN(IN[14]), .LOAD(LOAD), .CLK(CLK), .OUT(OUT[14]), .PRESET_N(1), .CLEAR_N(RESET));
	register reg15(.IN(IN[15]), .LOAD(LOAD), .CLK(CLK), .OUT(OUT[15]), .PRESET_N(1), .CLEAR_N(RESET));
	
endmodule