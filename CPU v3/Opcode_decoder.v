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
// CREATED		"Sun Oct  5 20:03:54 2025"

module Opcode_decoder(
	INST,
	NOOP,
	INC,
	MOV,
	IN,
	OUT,
	LDM,
	LDD,
	LDI,
	LDX,
	STO,
	STI,
	STX,
	ADDI,
	ADDX,
	SUBI,
	SUBX,
	CMI,
	CMX,
	JPN,
	JPE,
	JGT,
	JGE,
	ANDI,
	ANDX,
	ORI,
	ORX,
	XORI,
	XORX,
	JMP,
	SWAP,
	ADDM,
	ADDD,
	SUBM,
	SUBD,
	ANDM,
	ANDD,
	ORM,
	ORD,
	XORM,
	XORD,
	DEC,
	LSL,
	LSR,
	ADDR,
	SUBR,
	SWAPR,
	ASR,
	CSL,
	CSR,
	CMP,
	CMD,
	I_NOT,
	I_END,
	RX,
	RY
);


input wire	[7:0] INST;
output wire	NOOP;
output wire	INC;
output wire	MOV;
output wire	IN;
output wire	OUT;
output wire	LDM;
output wire	LDD;
output wire	LDI;
output wire	LDX;
output wire	STO;
output wire	STI;
output wire	STX;
output wire	ADDI;
output wire	ADDX;
output wire	SUBI;
output wire	SUBX;
output wire	CMI;
output wire	CMX;
output wire	JPN;
output wire	JPE;
output wire	JGT;
output wire	JGE;
output wire	ANDI;
output wire	ANDX;
output wire	ORI;
output wire	ORX;
output wire	XORI;
output wire	XORX;
output wire	JMP;
output wire	SWAP;
output wire	ADDM;
output wire	ADDD;
output wire	SUBM;
output wire	SUBD;
output wire	ANDM;
output wire	ANDD;
output wire	ORM;
output wire	ORD;
output wire	XORM;
output wire	XORD;
output wire	DEC;
output wire	LSL;
output wire	LSR;
output wire	ADDR;
output wire	SUBR;
output wire	SWAPR;
output wire	ASR;
output wire	CSL;
output wire	CSR;
output wire	CMP;
output wire	CMD;
output wire	I_NOT;
output wire	I_END;
output wire	[1:0] RX;
output wire	[1:0] RY;

wire	[7:0] I;
wire	[15:0] O;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;





decoder4to16	b2v_decoder(
	.S(I[7:4]),
	.O(O));


Decoder2to4	b2v_inst10(
	.S1(I[3]),
	.S0(I[2]),
	.EN(O[14]),
	.Y0(XORM),
	.Y1(XORD),
	.Y2(XORI),
	.Y3(XORX));


Decoder2to4	b2v_inst11(
	.S1(I[3]),
	.S0(I[2]),
	.EN(O[0]),
	.Y0(NOOP),
	.Y1(IN),
	.Y2(OUT),
	.Y3(I_END));


Decoder2to4	b2v_inst12(
	.S1(I[3]),
	.S0(I[2]),
	.EN(O[5]),
	.Y0(INC),
	.Y1(DEC),
	.Y2(LSL),
	.Y3(LSR));


Decoder2to4	b2v_inst13(
	.S1(I[3]),
	.S0(I[2]),
	.EN(O[10]),
	.Y0(SYNTHESIZED_WIRE_2),
	.Y1(SYNTHESIZED_WIRE_0),
	.Y2(SYNTHESIZED_WIRE_1),
	.Y3(JMP));


Decoder2to4	b2v_inst14(
	.S1(I[3]),
	.S0(I[2]),
	.EN(O[15]),
	.Y0(I_NOT),
	.Y1(ASR),
	.Y2(CSL),
	.Y3(CSR));

assign	SWAPR = SYNTHESIZED_WIRE_0 | SYNTHESIZED_WIRE_1 | SYNTHESIZED_WIRE_2;


Decoder2to4	b2v_inst2(
	.S1(I[3]),
	.S0(I[2]),
	.EN(O[1]),
	.Y0(LDM),
	.Y1(LDD),
	.Y2(LDI),
	.Y3(LDX));


Decoder2to4	b2v_inst3(
	.S1(I[3]),
	.S0(I[2]),
	.EN(O[2]),
	.Y0(SWAP),
	.Y1(STO),
	.Y2(STI),
	.Y3(STX));


Decoder2to4	b2v_inst4(
	.S1(I[3]),
	.S0(I[2]),
	.EN(O[3]),
	.Y0(ADDM),
	.Y1(ADDD),
	.Y2(ADDI),
	.Y3(ADDX));


Decoder2to4	b2v_inst5(
	.S1(I[3]),
	.S0(I[2]),
	.EN(O[4]),
	.Y0(SUBM),
	.Y1(SUBD),
	.Y2(SUBI),
	.Y3(SUBX));


Decoder2to4	b2v_inst6(
	.S1(I[3]),
	.S0(I[2]),
	.EN(O[9]),
	.Y0(CMP),
	.Y1(CMD),
	.Y2(CMI),
	.Y3(CMX));


Decoder2to4	b2v_inst7(
	.S1(I[3]),
	.S0(I[2]),
	.EN(O[11]),
	.Y0(JPN),
	.Y1(JPE),
	.Y2(JGT),
	.Y3(JGE));


Decoder2to4	b2v_inst8(
	.S1(I[3]),
	.S0(I[2]),
	.EN(O[12]),
	.Y0(ANDM),
	.Y1(ANDD),
	.Y2(ANDI),
	.Y3(ANDX));


Decoder2to4	b2v_inst9(
	.S1(I[3]),
	.S0(I[2]),
	.EN(O[13]),
	.Y0(ORM),
	.Y1(ORD),
	.Y2(ORI),
	.Y3(ORX));

assign	I = INST;
assign	MOV = O[8];
assign	ADDR = O[6];
assign	SUBR = O[7];
assign	RX[1:0] = I[1:0];
assign	RY[1:0] = I[3:2];

endmodule
