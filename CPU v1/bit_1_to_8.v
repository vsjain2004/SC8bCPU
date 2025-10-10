module bit_1_to_8(In, Out);
	input In;
	output reg [7:0] Out;
	
	always@*
	begin
		case ({In})
			'b0: Out=8'b00000000;
			'b1: Out=8'b11111111;
		endcase
	end
	
endmodule