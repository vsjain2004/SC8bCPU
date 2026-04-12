module register(
	input wire IN, LOAD, CLK, PRESET_N, CLEAR_N,
	output wire OUT
);
	
	wire D;
	
	assign D = LOAD ? IN : OUT;
	dffg my_dff(.d(D), .clk(CLK), .prn(PRESET_N), .clrn(CLEAR_N), .q(OUT));
endmodule