module decoder4to16(S, NOOP, LD, ST, ADD, SUB, INC, MOV, IN, OUT, CM, JMP, JP, AND, OR, XOR, END);
	input [3:0] S;
	output reg NOOP, LD, ST, ADD, SUB, INC, MOV, IN, OUT, CM, JMP, JP, AND, OR, XOR, END;
	
	always @(S)
	begin
		NOOP = 1'b0;
		LD = 1'b0;
		ST = 1'b0;
		ADD = 1'b0;
		SUB = 1'b0;
		INC = 1'b0;
		MOV = 1'b0;
		IN = 1'b0;
		OUT = 1'b0;
		CM = 1'b0;
		JMP = 1'b0;
		JP = 1'b0;
		AND = 1'b0;
		OR = 1'b0;
		XOR = 1'b0;
		END = 1'b0;
		case({S})
			4'b0000: NOOP=1'b1;
			4'b0001: LD=1'b1;
			4'b0010: ST=1'b1;
			4'b0011: ADD=1'b1;
			4'b0100: SUB=1'b1;
			4'b0101: INC=1'b1;
			4'b0110: MOV=1'b1;
			4'b0111: IN=1'b1;
			4'b1000: OUT=1'b1;
			4'b1001: CM=1'b1;
			4'b1010: JMP=1'b1;
			4'b1011: JP=1'b1;
			4'b1100: AND=1'b1;
			4'b1101: OR=1'b1;
			4'b1110: XOR=1'b1;
			4'b1111: END=1'b1;
		endcase
	end
endmodule