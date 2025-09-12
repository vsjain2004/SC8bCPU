module Decoder2to4(S1, S0, EN, Y0, Y1, Y2, Y3);
	input S1, S0, EN;
	output reg Y0, Y1, Y2, Y3;
	
	always @*
	begin
		{Y0, Y1, Y2, Y3} = 4'b0000;
		if(EN == 1)
		begin
			case({S1, S0})
				2'b00: Y0='b1;
				2'b01: Y1='b1;
				2'b10: Y2='b1;
				2'b11: Y3='b1;		
			endcase
		end
	end
endmodule