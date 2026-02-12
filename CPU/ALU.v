module ALU(ADD_SUB, Y, X, AS2, AS1, AS0, ZF, CF, OF, NF, Result);

	input ADD_SUB, AS2, AS1, AS0;
	input [7:0] Y, X;
	output ZF, CF, OF, NF;
	output [7:0] Result;
	
	wire [7:0] oAdd, oAnd, oOr, oXor, oNot, oLS, oAS, oCS;
	
	AddSub8b adder(.Cin(ADD_SUB), .X(X), .Y(Y), .S(oAdd), .Cout(CF), .Ov(OF));
	AND_8_bit ander(.In(Y), .Control(X), .Out(oAnd));
	OR_8_bit orer(.In(Y), .Control(X), .Out(oOr));
	XOR_8_bit xorer(.In(Y), .Control(X), .Out(oXor));
	NOT_8_bit noter(.In(X), .Out(oNot));
	Logic_Shifter ls(.IN(X), .ShiftAmt(Y[2:0]), .ShiftDir(ADD_SUB), .Out(oLS));
	Arithmetic_Shifter as(.IN(X), .ShiftAmt(Y[2:0]), .Out(oAS));
	Circular_Shifter cs(.IN(X), .ShiftAmt(Y[2:0]), .ShiftDir(ADD_SUB), .Out(oCS));
	
	busmux_8_to_1 mux1(.S({AS2, AS1, AS0}), .W0(oAdd), .W1(oAnd), .W2(oOr), .W3(oXor), .W4(oNot), .W5(oLS), .W6(oAS), .W7(oCS), .F(Result));
	
	assign NF = oAdd[7];
	assign ZF = ~(oAdd[0] | oAdd[1] | oAdd[2] | oAdd[3] | oAdd[4] | oAdd[5] | oAdd[6] | oAdd[7]);
	
endmodule