module dffg(d, clk, prn, clrn, q);
	input d, clk, prn, clrn;
	output reg q;
	
	always @(posedge clk or negedge prn or negedge clrn)
	begin
		if (!clrn)
			q <= 1'b0;
		else if (!prn)
			q <= 1'b1;
		else
			q <= d;
	end
	
endmodule