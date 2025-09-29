module NOT_8_bit(In, Out);
	integer k;
	input [7:0] In;
	output reg [7:0] Out;
	
	always @*
	begin
		for(k = 0; k <= 7; k = k + 1)
		begin
			Out[k] = ~In[k];
		end
	end	
endmodule