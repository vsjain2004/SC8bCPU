module reg_8_bit(IN, LOAD, CLK, OUT, PRESET_N, CLEAR_N);
	input [7:0] IN;
	input LOAD, CLK, PRESET_N, CLEAR_N;
	output [7:0] OUT;
	
	register reg0(.IN(IN[0]), .LOAD(LOAD), .CLK(CLK), .OUT(OUT[0]), .PRESET_N(PRESET_N), .CLEAR_N(CLEAR_N));
	register reg1(.IN(IN[1]), .LOAD(LOAD), .CLK(CLK), .OUT(OUT[1]), .PRESET_N(PRESET_N), .CLEAR_N(CLEAR_N));
	register reg2(.IN(IN[2]), .LOAD(LOAD), .CLK(CLK), .OUT(OUT[2]), .PRESET_N(PRESET_N), .CLEAR_N(CLEAR_N));
	register reg3(.IN(IN[3]), .LOAD(LOAD), .CLK(CLK), .OUT(OUT[3]), .PRESET_N(PRESET_N), .CLEAR_N(CLEAR_N));
	register reg4(.IN(IN[4]), .LOAD(LOAD), .CLK(CLK), .OUT(OUT[4]), .PRESET_N(PRESET_N), .CLEAR_N(CLEAR_N));
	register reg5(.IN(IN[5]), .LOAD(LOAD), .CLK(CLK), .OUT(OUT[5]), .PRESET_N(PRESET_N), .CLEAR_N(CLEAR_N));
	register reg6(.IN(IN[6]), .LOAD(LOAD), .CLK(CLK), .OUT(OUT[6]), .PRESET_N(PRESET_N), .CLEAR_N(CLEAR_N));
	register reg7(.IN(IN[7]), .LOAD(LOAD), .CLK(CLK), .OUT(OUT[7]), .PRESET_N(PRESET_N), .CLEAR_N(CLEAR_N));
	
endmodule