module ALU(ADD_SUB, Y, X, ALU_SELECT, ZF, CF, OF, NF, Result);

	input ADD_SUB;
	input [31:0] Y, X;
	input [2:0] ALU_SELECT;
	output ZF, CF, OF, NF;
	output [31:0] Result;
	
	wire [31:0] oAdd, oAnd, oOr, oXor, oNot, oLS, oCS, oAS;
	
	AddSub_N_bit adder(.Cin(ADD_SUB), .X(X), .Y(Y), .S(oAdd), .Cout(CF), .Ov(OF));
	AND_N_bit ander(.In(Y), .Control(X), .Out(oAnd));
	OR_N_bit orer(.In(Y), .Control(X), .Out(oOr));
	XOR_N_bit xorer(.In(Y), .Control(X), .Out(oXor));
	NOT_N_bit noter(.In(X), .Out(oNot));
	Logic_Shifter ls(.IN(X), .ShiftAmt(Y[4:0]), .ShiftDir(ADD_SUB), .Out(oLS));
	Arithmetic_Shifter as(.IN(X), .ShiftAmt(Y[4:0]), .Out(oAS));
	Circular_Shifter cs(.IN(X), .ShiftAmt(Y[4:0]), .ShiftDir(ADD_SUB), .Out(oCS));
	
	busmuxN_8_to_1 mux1(.S(ALU_SELECT), .W0(oAdd), .W1(oAnd), .W2(oOr), .W3(oXor), .W4(oNot), .W5(oLS), .W6(oAS), .W7(oCS), .F(Result));
	
	assign NF = oAdd[31];
	assign ZF = ~|oAdd;
	
endmodule