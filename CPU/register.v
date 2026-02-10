module register(IN, LOAD, CLK, OUT, PRESET_N, CLEAR_N);
	input IN, LOAD, CLK, PRESET_N, CLEAR_N;
	output OUT;
	assign D = LOAD ? IN : OUT;
	dffg my_dff(.d(D), .clk(CLK), .prn(PRESET_N), .clrn(CLEAR_N), .q(OUT));
endmodule