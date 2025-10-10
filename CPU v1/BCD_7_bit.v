module BCD_7_bit(hex, hex3, hex2, hex1, hex0);
	input [7:0] hex;
	output reg [7:0] hex3, hex2, hex1, hex0;
	
	reg [6:0] x;
	
	always @*
	begin
		case(hex[7])
		1'b0:
		begin
			hex3 <= 8'h2B;
			x = hex;
		end
		1'b1:
		begin
			hex3 <= 8'h2D;
			x = ~hex + 1;
		end
		endcase
		case({x[6:0]})
		7'b0000000:
		begin
		case(hex[7])
		1'b0:
		begin
			hex3 <= 8'h30;
			hex2 <= 8'h20;
			hex1 <= 8'h20;
			hex0 <= 8'h20;
		end
		1'b1:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h32;
			hex0 <= 8'h38;
		end
		endcase
		end
		7'b0000001:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h20;
			hex0 <= 8'h20;
		end
		7'b0000010:
		begin
			hex2 <= 8'h32;
			hex1 <= 8'h20;
			hex0 <= 8'h20;
		end
		7'b0000011:
		begin
			hex2 <= 8'h33;
			hex1 <= 8'h20;
			hex0 <= 8'h20;
		end
		7'b0000100:
		begin
			hex2 <= 8'h34;
			hex1 <= 8'h20;
			hex0 <= 8'h20;
		end
		7'b0000101:
		begin
			hex2 <= 8'h35;
			hex1 <= 8'h20;
			hex0 <= 8'h20;
		end
		7'b0000110:
		begin
			hex2 <= 8'h36;
			hex1 <= 8'h20;
			hex0 <= 8'h20;
		end
		7'b0000111:
		begin
			hex2 <= 8'h37;
			hex1 <= 8'h20;
			hex0 <= 8'h20;
		end
		7'b0001000:
		begin
			hex2 <= 8'h38;
			hex1 <= 8'h20;
			hex0 <= 8'h20;
		end
		7'b0001001:
		begin
			hex2 <= 8'h39;
			hex1 <= 8'h20;
			hex0 <= 8'h20;
		end
		7'b0001010:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h30;
			hex0 <= 8'h20;
		end
		7'b0001011:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h31;
			hex0 <= 8'h20;
		end
		7'b0001100:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h32;
			hex0 <= 8'h20;
		end
		7'b0001101:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h33;
			hex0 <= 8'h20;
		end
		7'b0001110:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h34;
			hex0 <= 8'h20;
		end
		7'b0001111:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h35;
			hex0 <= 8'h20;
		end
		7'b0010000:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h36;
			hex0 <= 8'h20;
		end
		7'b0010001:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h37;
			hex0 <= 8'h20;
		end
		7'b0010010:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h38;
			hex0 <= 8'h20;
		end
		7'b0010011:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h39;
			hex0 <= 8'h20;
		end
		7'b0010100:
		begin
			hex2 <= 8'h32;
			hex1 <= 8'h30;
			hex0 <= 8'h20;
		end
		7'b0010101:
		begin
			hex2 <= 8'h32;
			hex1 <= 8'h31;
			hex0 <= 8'h20;
		end
		7'b0010110:
		begin
			hex2 <= 8'h32;
			hex1 <= 8'h32;
			hex0 <= 8'h20;
		end
		7'b0010111:
		begin
			hex2 <= 8'h32;
			hex1 <= 8'h33;
			hex0 <= 8'h20;
		end
		7'b0011000:
		begin
			hex2 <= 8'h32;
			hex1 <= 8'h34;
			hex0 <= 8'h20;
		end
		7'b0011001:
		begin
			hex2 <= 8'h32;
			hex1 <= 8'h35;
			hex0 <= 8'h20;
		end
		7'b0011010:
		begin
			hex2 <= 8'h32;
			hex1 <= 8'h36;
			hex0 <= 8'h20;
		end
		7'b0011011:
		begin
			hex2 <= 8'h32;
			hex1 <= 8'h37;
			hex0 <= 8'h20;
		end
		7'b0011100:
		begin
			hex2 <= 8'h32;
			hex1 <= 8'h38;
			hex0 <= 8'h20;
		end
		7'b0011101:
		begin
			hex2 <= 8'h32;
			hex1 <= 8'h39;
			hex0 <= 8'h20;
		end
		7'b0011110:
		begin
			hex2 <= 8'h33;
			hex1 <= 8'h30;
			hex0 <= 8'h20;
		end
		7'b0011111:
		begin
			hex2 <= 8'h33;
			hex1 <= 8'h31;
			hex0 <= 8'h20;
		end
		7'b0100000:
		begin
			hex2 <= 8'h33;
			hex1 <= 8'h32;
			hex0 <= 8'h20;
		end
		7'b0100001:
		begin
			hex2 <= 8'h33;
			hex1 <= 8'h33;
			hex0 <= 8'h20;
		end
		7'b0100010:
		begin
			hex2 <= 8'h33;
			hex1 <= 8'h34;
			hex0 <= 8'h20;
		end
		7'b0100011:
		begin
			hex2 <= 8'h33;
			hex1 <= 8'h35;
			hex0 <= 8'h20;
		end
		7'b0100100:
		begin
			hex2 <= 8'h33;
			hex1 <= 8'h36;
			hex0 <= 8'h20;
		end
		7'b0100101:
		begin
			hex2 <= 8'h33;
			hex1 <= 8'h37;
			hex0 <= 8'h20;
		end
		7'b0100110:
		begin
			hex2 <= 8'h33;
			hex1 <= 8'h38;
			hex0 <= 8'h20;
		end
		7'b0100111:
		begin
			hex2 <= 8'h33;
			hex1 <= 8'h39;
			hex0 <= 8'h20;
		end
		7'b0101000:
		begin
			hex2 <= 8'h34;
			hex1 <= 8'h30;
			hex0 <= 8'h20;
		end
		7'b0101001:
		begin
			hex2 <= 8'h34;
			hex1 <= 8'h31;
			hex0 <= 8'h20;
		end
		7'b0101010:
		begin
			hex2 <= 8'h34;
			hex1 <= 8'h32;
			hex0 <= 8'h20;
		end
		7'b0101011:
		begin
			hex2 <= 8'h34;
			hex1 <= 8'h33;
			hex0 <= 8'h20;
		end
		7'b0101100:
		begin
			hex2 <= 8'h34;
			hex1 <= 8'h34;
			hex0 <= 8'h20;
		end
		7'b0101101:
		begin
			hex2 <= 8'h34;
			hex1 <= 8'h35;
			hex0 <= 8'h20;
		end
		7'b0101110:
		begin
			hex2 <= 8'h34;
			hex1 <= 8'h36;
			hex0 <= 8'h20;
		end
		7'b0101111:
		begin
			hex2 <= 8'h34;
			hex1 <= 8'h37;
			hex0 <= 8'h20;
		end
		7'b0110000:
		begin
			hex2 <= 8'h34;
			hex1 <= 8'h38;
			hex0 <= 8'h20;
		end
		7'b0110001:
		begin
			hex2 <= 8'h34;
			hex1 <= 8'h39;
			hex0 <= 8'h20;
		end
		7'b0110010:
		begin
			hex2 <= 8'h35;
			hex1 <= 8'h30;
			hex0 <= 8'h20;
		end
		7'b0110011:
		begin
			hex2 <= 8'h35;
			hex1 <= 8'h31;
			hex0 <= 8'h20;
		end
		7'b0110100:
		begin
			hex2 <= 8'h35;
			hex1 <= 8'h32;
			hex0 <= 8'h20;
		end
		7'b0110101:
		begin
			hex2 <= 8'h35;
			hex1 <= 8'h33;
			hex0 <= 8'h20;
		end
		7'b0110110:
		begin
			hex2 <= 8'h35;
			hex1 <= 8'h34;
			hex0 <= 8'h20;
		end
		7'b0110111:
		begin
			hex2 <= 8'h35;
			hex1 <= 8'h35;
			hex0 <= 8'h20;
		end
		7'b0111000:
		begin
			hex2 <= 8'h35;
			hex1 <= 8'h36;
			hex0 <= 8'h20;
		end
		7'b0111001:
		begin
			hex2 <= 8'h35;
			hex1 <= 8'h37;
			hex0 <= 8'h20;
		end
		7'b0111010:
		begin
			hex2 <= 8'h35;
			hex1 <= 8'h38;
			hex0 <= 8'h20;
		end
		7'b0111011:
		begin
			hex2 <= 8'h35;
			hex1 <= 8'h39;
			hex0 <= 8'h20;
		end
		7'b0111100:
		begin
			hex2 <= 8'h36;
			hex1 <= 8'h30;
			hex0 <= 8'h20;
		end
		7'b0111101:
		begin
			hex2 <= 8'h36;
			hex1 <= 8'h31;
			hex0 <= 8'h20;
		end
		7'b0111110:
		begin
			hex2 <= 8'h36;
			hex1 <= 8'h32;
			hex0 <= 8'h20;
		end
		7'b0111111:
		begin
			hex2 <= 8'h36;
			hex1 <= 8'h33;
			hex0 <= 8'h20;
		end
		7'b1000000:
		begin
			hex2 <= 8'h36;
			hex1 <= 8'h34;
			hex0 <= 8'h20;
		end
		7'b1000001:
		begin
			hex2 <= 8'h36;
			hex1 <= 8'h35;
			hex0 <= 8'h20;
		end
		7'b1000010:
		begin
			hex2 <= 8'h36;
			hex1 <= 8'h36;
			hex0 <= 8'h20;
		end
		7'b1000011:
		begin
			hex2 <= 8'h36;
			hex1 <= 8'h37;
			hex0 <= 8'h20;
		end
		7'b1000100:
		begin
			hex2 <= 8'h36;
			hex1 <= 8'h38;
			hex0 <= 8'h20;
		end
		7'b1000101:
		begin
			hex2 <= 8'h36;
			hex1 <= 8'h39;
			hex0 <= 8'h20;
		end
		7'b1000110:
		begin
			hex2 <= 8'h37;
			hex1 <= 8'h30;
			hex0 <= 8'h20;
		end
		7'b1000111:
		begin
			hex2 <= 8'h37;
			hex1 <= 8'h31;
			hex0 <= 8'h20;
		end
		7'b1001000:
		begin
			hex2 <= 8'h37;
			hex1 <= 8'h32;
			hex0 <= 8'h20;
		end
		7'b1001001:
		begin
			hex2 <= 8'h37;
			hex1 <= 8'h33;
			hex0 <= 8'h20;
		end
		7'b1001010:
		begin
			hex2 <= 8'h37;
			hex1 <= 8'h34;
			hex0 <= 8'h20;
		end
		7'b1001011:
		begin
			hex2 <= 8'h37;
			hex1 <= 8'h35;
			hex0 <= 8'h20;
		end
		7'b1001100:
		begin
			hex2 <= 8'h37;
			hex1 <= 8'h36;
			hex0 <= 8'h20;
		end
		7'b1001101:
		begin
			hex2 <= 8'h37;
			hex1 <= 8'h37;
			hex0 <= 8'h20;
		end
		7'b1001110:
		begin
			hex2 <= 8'h37;
			hex1 <= 8'h38;
			hex0 <= 8'h20;
		end
		7'b1001111:
		begin
			hex2 <= 8'h37;
			hex1 <= 8'h39;
			hex0 <= 8'h20;
		end
		7'b1010000:
		begin
			hex2 <= 8'h38;
			hex1 <= 8'h30;
			hex0 <= 8'h20;
		end
		7'b1010001:
		begin
			hex2 <= 8'h38;
			hex1 <= 8'h31;
			hex0 <= 8'h20;
		end
		7'b1010010:
		begin
			hex2 <= 8'h38;
			hex1 <= 8'h32;
			hex0 <= 8'h20;
		end
		7'b1010011:
		begin
			hex2 <= 8'h38;
			hex1 <= 8'h33;
			hex0 <= 8'h20;
		end
		7'b1010100:
		begin
			hex2 <= 8'h38;
			hex1 <= 8'h34;
			hex0 <= 8'h20;
		end
		7'b1010101:
		begin
			hex2 <= 8'h38;
			hex1 <= 8'h35;
			hex0 <= 8'h20;
		end
		7'b1010110:
		begin
			hex2 <= 8'h38;
			hex1 <= 8'h36;
			hex0 <= 8'h20;
		end
		7'b1010111:
		begin
			hex2 <= 8'h38;
			hex1 <= 8'h37;
			hex0 <= 8'h20;
		end
		7'b1011000:
		begin
			hex2 <= 8'h38;
			hex1 <= 8'h38;
			hex0 <= 8'h20;
		end
		7'b1011001:
		begin
			hex2 <= 8'h38;
			hex1 <= 8'h39;
			hex0 <= 8'h20;
		end
		7'b1011010:
		begin
			hex2 <= 8'h39;
			hex1 <= 8'h30;
			hex0 <= 8'h20;
		end
		7'b1011011:
		begin
			hex2 <= 8'h39;
			hex1 <= 8'h31;
			hex0 <= 8'h20;
		end
		7'b1011100:
		begin
			hex2 <= 8'h39;
			hex1 <= 8'h32;
			hex0 <= 8'h20;
		end
		7'b1011101:
		begin
			hex2 <= 8'h39;
			hex1 <= 8'h33;
			hex0 <= 8'h20;
		end
		7'b1011110:
		begin
			hex2 <= 8'h39;
			hex1 <= 8'h34;
			hex0 <= 8'h20;
		end
		7'b1011111:
		begin
			hex2 <= 8'h39;
			hex1 <= 8'h35;
			hex0 <= 8'h20;
		end
		7'b1100000:
		begin
			hex2 <= 8'h39;
			hex1 <= 8'h36;
			hex0 <= 8'h20;
		end
		7'b1100001:
		begin
			hex2 <= 8'h39;
			hex1 <= 8'h37;
			hex0 <= 8'h20;
		end
		7'b1100010:
		begin
			hex2 <= 8'h39;
			hex1 <= 8'h38;
			hex0 <= 8'h20;
		end
		7'b1100011:
		begin
			hex2 <= 8'h39;
			hex1 <= 8'h39;
			hex0 <= 8'h20;
		end
		7'b1100100:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h30;
			hex0 <= 8'h30;
		end
		7'b1100101:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h30;
			hex0 <= 8'h31;
		end
		7'b1100110:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h30;
			hex0 <= 8'h32;
		end
		7'b1100111:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h30;
			hex0 <= 8'h33;
		end
		7'b1101000:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h30;
			hex0 <= 8'h34;
		end
		7'b1101001:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h30;
			hex0 <= 8'h35;
		end
		7'b1101010:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h30;
			hex0 <= 8'h36;
		end
		7'b1101011:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h30;
			hex0 <= 8'h37;
		end
		7'b1101100:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h30;
			hex0 <= 8'h38;
		end
		7'b1101101:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h30;
			hex0 <= 8'h39;
		end
		7'b1101110:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h31;
			hex0 <= 8'h30;
		end
		7'b1101111:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h31;
			hex0 <= 8'h31;
		end
		7'b1110000:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h31;
			hex0 <= 8'h32;
		end
		7'b1110001:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h31;
			hex0 <= 8'h33;
		end
		7'b1110010:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h31;
			hex0 <= 8'h34;
		end
		7'b1110011:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h31;
			hex0 <= 8'h35;
		end
		7'b1110100:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h31;
			hex0 <= 8'h36;
		end
		7'b1110101:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h31;
			hex0 <= 8'h37;
		end
		7'b1110110:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h31;
			hex0 <= 8'h38;
		end
		7'b1110111:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h31;
			hex0 <= 8'h39;
		end
		7'b1111000:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h32;
			hex0 <= 8'h30;
		end
		7'b1111001:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h32;
			hex0 <= 8'h31;
		end
		7'b1111010:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h32;
			hex0 <= 8'h32;
		end
		7'b1111011:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h32;
			hex0 <= 8'h33;
		end
		7'b1111100:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h32;
			hex0 <= 8'h34;
		end
		7'b1111101:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h32;
			hex0 <= 8'h35;
		end
		7'b1111110:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h32;
			hex0 <= 8'h36;
		end
		7'b1111111:
		begin
			hex2 <= 8'h31;
			hex1 <= 8'h32;
			hex0 <= 8'h37;
		end
		endcase
	end
endmodule