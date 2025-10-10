module Decoder3to8(EN, S, Y);
	input EN;
	input [2:0] S;
	output reg [7:0] Y;
	
	always @*
	begin
		Y = 8'b00000000;
		if(EN == 1)
		begin
			case({S[2], S[1], S[0]})
				3'b000: Y[0]='b1;
				3'b001: Y[1]='b1;
				3'b010: Y[2]='b1;
				3'b011: Y[3]='b1;
				3'b100: Y[4]='b1;
				3'b101: Y[5]='b1;
				3'b110: Y[6]='b1;
				3'b111: Y[7]='b1;		
			endcase
		end
	end
endmodule