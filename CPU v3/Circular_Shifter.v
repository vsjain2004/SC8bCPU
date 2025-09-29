module Circular_Shifter(IN, ShiftAmt, ShiftDir, Out);
	input [7:0] IN;
	input [2:0] ShiftAmt;
	input ShiftDir;
	output reg [7:0] Out;
	
	always @*
	begin
		if(ShiftDir == 1)
			begin
				case(ShiftAmt)
					3'b000: Out = IN;
					3'b001: Out = {IN[0], IN[7:1]};
					3'b010: Out = {IN[1:0], IN[7:2]};
					3'b011: Out = {IN[2:0], IN[7:3]};
					3'b100: Out = {IN[3:0], IN[7:4]};
					3'b101: Out = {IN[4:0], IN[7:5]};
					3'b110: Out = {IN[5:0], IN[7:6]};
					3'b111: Out = {IN[6:0], IN[7]};
					default: Out = 8'bx;
				endcase
			end
		else
			begin
				case(ShiftAmt)
					3'b000: Out = IN;
					3'b001: Out = {IN[6:0], IN[7]};
					3'b010: Out = {IN[5:0], IN[7:6]};
					3'b011: Out = {IN[4:0], IN[7:5]};
					3'b100: Out = {IN[3:0], IN[7:4]};
					3'b101: Out = {IN[2:0], IN[7:3]};
					3'b110: Out = {IN[1:0], IN[7:2]};
					3'b111: Out = {IN[0], IN[7:1]};
					default: Out = 8'bx;
				endcase
			end
		end
endmodule