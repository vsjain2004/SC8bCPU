module NOT_N_bit #(parameter N = 32) (In, Out);
	integer k;
	input [N-1:0] In;
	output reg [N-1:0] Out;
	
	always @*
	begin
		for(k = 0; k <= N-1; k = k + 1)
		begin
			Out[k] = ~In[k];
		end
	end	
endmodule