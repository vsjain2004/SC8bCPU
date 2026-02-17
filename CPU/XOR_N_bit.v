module XOR_N_bit #(parameter N = 32) (In, Control, Out);
	integer k;
	input [N-1:0] In;
	input [N-1:0] Control;
	output reg [N-1:0] Out;
	
	always @*	
	begin
		for(k = 0; k <= N-1; k = k + 1)
		begin
			Out[k] = In[k] ^ Control[k];
		end
	end	
endmodule