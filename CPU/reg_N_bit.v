module reg_N_bit #(parameter N = 32) (
	input wire [N-1:0] IN,
	input wire LOAD, CLK, PRESET_N, CLEAR_N,
	output wire [N-1:0] OUT
);
	

	genvar i;
	generate
		for(i = 0; i < N; i = i + 1) begin: regN
			register regi(.IN(IN[i]), .LOAD(LOAD), .CLK(CLK), .OUT(OUT[i]), .PRESET_N(PRESET_N), .CLEAR_N(CLEAR_N));
		end
	endgenerate
	
endmodule