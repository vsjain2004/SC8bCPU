module Logic_Shifter(IN, ShiftAmt, ShiftDir, Out);
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
					3'b001: Out = {1'b0, IN[7:1]};
					3'b010: Out = {2'b0, IN[7:2]};
					3'b011: Out = {3'b0, IN[7:3]};
					3'b100: Out = {4'b0, IN[7:4]};
					3'b101: Out = {5'b0, IN[7:5]};
					3'b110: Out = {6'b0, IN[7:6]};
					3'b111: Out = {7'b0, IN[7]};
					default: Out = 8'bx;
				endcase
			end
		else
			begin
				case(ShiftAmt)
					3'b000: Out = IN;
					3'b001: Out = {IN[6:0], 1'b0};
					3'b010: Out = {IN[5:0], 2'b0};
					3'b011: Out = {IN[4:0], 3'b0};
					3'b100: Out = {IN[3:0], 4'b0};
					3'b101: Out = {IN[2:0], 5'b0};
					3'b110: Out = {IN[1:0], 6'b0};
					3'b111: Out = {IN[0], 7'b0};
					default: Out = 8'bx;
				endcase
			end
		end
endmodule