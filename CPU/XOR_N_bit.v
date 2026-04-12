module XOR_N_bit #(parameter N = 32) (
	input wire [N-1:0] In, Control,
	output [N-1:0] Out
);

	assign Out = In ^ Control;	
endmodule