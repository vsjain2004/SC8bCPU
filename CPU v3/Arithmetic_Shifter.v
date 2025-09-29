module Arithmetic_Shifter(IN, ShiftAmt, Out);
	input [7:0] IN;
	input [2:0] ShiftAmt;
	output reg [7:0] Out;
	
	always @*
		begin
			case(ShiftAmt)
				3'b000: Out = IN;
				3'b001: Out = {{1{IN[7]}}, IN[7:1]};
				3'b010: Out = {{2{IN[7]}}, IN[7:2]};
				3'b011: Out = {{3{IN[7]}}, IN[7:3]};
				3'b100: Out = {{4{IN[7]}}, IN[7:4]};
				3'b101: Out = {{5{IN[7]}}, IN[7:5]};
				3'b110: Out = {{6{IN[7]}}, IN[7:6]};
				3'b111: Out = {{7{IN[7]}}, IN[7]};
				default: Out = 8'bx;
			endcase
		end
endmodule