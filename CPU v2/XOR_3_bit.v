module XOR_3_bit(In1, In2, In3, Out);
	input In1, In2, In3;
	output Out;
	
	assign Out = In1 ^ In2 ^ In3;
	
endmodule