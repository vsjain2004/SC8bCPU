module DMEM_PRGM(D0, D1, D2, D3, D4, D5, D6, D7);
	output [7:0] D0, D1, D2, D3, D4, D5, D6, D7;
	
//	add1, add3, sub1, cs1, count up
//	assign D0 = 8'b00000000;
//	assign D1 = 8'b00000000;
//	assign D2 = 8'b00000000;
//	assign D3 = 8'b00000000;
//	assign D4 = 8'b00000000;
//	assign D5 = 8'b00000000;
//	assign D6 = 8'b00000000;
//	assign D7 = 8'b00000000;
	
//	add2, add4, sub2, mul
	assign D0 = 8'b00100010;
	assign D1 = 8'b10101000;
	assign D2 = 8'b00000100;
	assign D3 = 8'b00000011;
	assign D4 = 8'b00100010;
	assign D5 = 8'b00000000;
	assign D6 = 8'b00011000;
	assign D7 = 8'b00000000;
//	
//	int div
//	assign D0 = 8'b00001001;
//	assign D1 = 8'b00000011;
//	assign D2 = 8'b00000000;
//	assign D3 = 8'b00000000;
//	assign D4 = 8'b00000000;
//	assign D5 = 8'b00000000;
//	assign D6 = 8'b00000000;
//	assign D7 = 8'b00000000;
//	
//	array traversal
//	assign D0 = 8'b01000001;
//	assign D1 = 8'b00010100;
//	assign D2 = 8'b01000000;
//	assign D3 = 8'b00000010;
//	assign D4 = 8'b00100000;
//	assign D5 = 8'b00000110;
//	assign D6 = 8'b10000000;
//	assign D7 = 8'b01101010;
//	
//	cs2
//	assign D0 = 8'b00001010;
//	assign D1 = 8'b00000001;
//	assign D2 = 8'b00000000;
//	assign D3 = 8'b00000000;
//	assign D4 = 8'b00000000;
//	assign D5 = 8'b00000000;
//	assign D6 = 8'b00000000;
//	assign D7 = 8'b00000000;
endmodule