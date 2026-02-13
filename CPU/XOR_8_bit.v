module XOR_8_bit(In, Control, Out);
	integer k;
	input [7:0] In;
	input [7:0] Control;
	output reg [7:0] Out;
	
	always @*	
	begin
		for(k = 0; k <= 7; k = k + 1)
		begin
			Out[k] = In[k] ^ Control[k];
		end
	end	
endmodule