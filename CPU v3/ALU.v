// Copyright (C) 2025  Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, the Altera Quartus Prime License Agreement,
// the Altera IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Altera and sold by Altera or its authorized distributors.  Please
// refer to the Altera Software License Subscription Agreements 
// on the Quartus Prime software download page.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 24.1std.0 Build 1077 03/04/2025 SC Lite Edition"
// CREATED		"Mon Oct  6 11:12:49 2025"

module ALU(
	AS1,
	AS0,
	AS2,
	ADD_SUB,
	X,
	Y,
	CF,
	OF,
	NF,
	ZF,
	Result
);


input wire	AS1;
input wire	AS0;
input wire	AS2;
input wire	ADD_SUB;
input wire	[7:0] X;
input wire	[7:0] Y;
output wire	CF;
output wire	OF;
output wire	NF;
output wire	ZF;
output wire	[7:0] Result;

wire	[7:0] N;
wire	[7:0] O;
wire	[7:0] SYNTHESIZED_WIRE_0;
wire	[7:0] SYNTHESIZED_WIRE_1;
wire	[7:0] SYNTHESIZED_WIRE_2;
wire	[7:0] SYNTHESIZED_WIRE_3;
wire	[7:0] SYNTHESIZED_WIRE_4;
wire	[7:0] SYNTHESIZED_WIRE_5;
wire	[7:0] SYNTHESIZED_WIRE_6;

wire	[2:0] GDFX_TEMP_SIGNAL_0;


assign	GDFX_TEMP_SIGNAL_0 = {AS2,AS1,AS0};


NOT_8_bit	b2v_inst(
	.In(X),
	.Out(SYNTHESIZED_WIRE_3));


CLA_8_bit	b2v_inst1(
	.Cin(ADD_SUB),
	.X(X),
	.Y(Y),
	.Cout(CF),
	.Ov(OF),
	.S(N));


AND_8_bit	b2v_inst2(
	.Control(X),
	.In(Y),
	.Out(SYNTHESIZED_WIRE_0));


OR_8_bit	b2v_inst3(
	.Control(X),
	.In(Y),
	.Out(SYNTHESIZED_WIRE_1));


XOR_8_bit	b2v_inst4(
	.Control(X),
	.In(Y),
	.Out(SYNTHESIZED_WIRE_2));

assign	ZF = ~(N[0] | N[2] | N[1] | N[3] | N[5] | N[4] | N[6] | N[7]);


Logic_Shifter	b2v_inst6(
	.ShiftDir(ADD_SUB),
	.IN(X),
	.ShiftAmt(Y[2:0]),
	.Out(SYNTHESIZED_WIRE_4));


Arithmetic_Shifter	b2v_inst7(
	.IN(X),
	.ShiftAmt(Y[2:0]),
	.Out(SYNTHESIZED_WIRE_5));


Circular_Shifter	b2v_inst8(
	.ShiftDir(ADD_SUB),
	.IN(X),
	.ShiftAmt(Y[2:0]),
	.Out(SYNTHESIZED_WIRE_6));


busmux_8_to_1	b2v_inst9(
	.S(GDFX_TEMP_SIGNAL_0),
	.W0(N),
	.W1(SYNTHESIZED_WIRE_0),
	.W2(SYNTHESIZED_WIRE_1),
	.W3(SYNTHESIZED_WIRE_2),
	.W4(SYNTHESIZED_WIRE_3),
	.W5(SYNTHESIZED_WIRE_4),
	.W6(SYNTHESIZED_WIRE_5),
	.W7(SYNTHESIZED_WIRE_6),
	.F(O));

assign	NF = N[7];
assign	Result = O;

endmodule
