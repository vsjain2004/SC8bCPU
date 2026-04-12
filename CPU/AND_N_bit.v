module AND_N_bit #(parameter N = 32) (
	input [N-1:0] In,
	input [N-1:0] Control,
	output [N-1:0] Out
);

	assign Out = In & Control;
endmodule