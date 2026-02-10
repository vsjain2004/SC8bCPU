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
// CREATED		"Tue Feb 10 17:10:03 2026"

module DMEM(
	CLK,
	RESET,
	DMEMWE,
	IN,
	WRA,
	OUTA,
	OUTB,
	OUTC,
	OUTD,
	OUTE,
	OUTF,
	OUTG,
	OUTH,
	OUTM
);


input wire	CLK;
input wire	RESET;
input wire	DMEMWE;
input wire	[7:0] IN;
input wire	[2:0] WRA;
output wire	[7:0] OUTA;
output wire	[7:0] OUTB;
output wire	[7:0] OUTC;
output wire	[7:0] OUTD;
output wire	[7:0] OUTE;
output wire	[7:0] OUTF;
output wire	[7:0] OUTG;
output wire	[7:0] OUTH;
output wire	[7:0] OUTM;

wire	[7:0] LOAD;
wire	SYNTHESIZED_WIRE_36;
reg	SYNTHESIZED_WIRE_37;
wire	[7:0] SYNTHESIZED_WIRE_2;
wire	[7:0] SYNTHESIZED_WIRE_3;
wire	[7:0] SYNTHESIZED_WIRE_4;
wire	[7:0] SYNTHESIZED_WIRE_5;
wire	[7:0] SYNTHESIZED_WIRE_7;
wire	[7:0] SYNTHESIZED_WIRE_9;
wire	[7:0] SYNTHESIZED_WIRE_11;
wire	[7:0] SYNTHESIZED_WIRE_13;
wire	[7:0] SYNTHESIZED_WIRE_15;
wire	[7:0] SYNTHESIZED_WIRE_17;
wire	[7:0] SYNTHESIZED_WIRE_19;
wire	[7:0] SYNTHESIZED_WIRE_21;
wire	[7:0] SYNTHESIZED_WIRE_22;
wire	[7:0] SYNTHESIZED_WIRE_23;
wire	[7:0] SYNTHESIZED_WIRE_24;
wire	[7:0] SYNTHESIZED_WIRE_25;
wire	[7:0] SYNTHESIZED_WIRE_26;
wire	[7:0] SYNTHESIZED_WIRE_27;
wire	[7:0] SYNTHESIZED_WIRE_28;
wire	[7:0] SYNTHESIZED_WIRE_29;
wire	[7:0] SYNTHESIZED_WIRE_30;
wire	[7:0] SYNTHESIZED_WIRE_31;
wire	[7:0] SYNTHESIZED_WIRE_32;
wire	[7:0] SYNTHESIZED_WIRE_33;
wire	[7:0] SYNTHESIZED_WIRE_34;
wire	[7:0] SYNTHESIZED_WIRE_35;

assign	OUTA = SYNTHESIZED_WIRE_24;
assign	OUTB = SYNTHESIZED_WIRE_25;
assign	OUTC = SYNTHESIZED_WIRE_26;
assign	OUTD = SYNTHESIZED_WIRE_27;
assign	OUTE = SYNTHESIZED_WIRE_28;
assign	OUTF = SYNTHESIZED_WIRE_29;
assign	OUTG = SYNTHESIZED_WIRE_30;
assign	OUTH = SYNTHESIZED_WIRE_31;
assign	SYNTHESIZED_WIRE_36 = 1;




always@(posedge CLK or negedge RESET or negedge SYNTHESIZED_WIRE_36)
begin
if (!RESET)
	begin
	SYNTHESIZED_WIRE_37 <= 0;
	end
else
if (!SYNTHESIZED_WIRE_36)
	begin
	SYNTHESIZED_WIRE_37 <= 1;
	end
else
	begin
	SYNTHESIZED_WIRE_37 <= SYNTHESIZED_WIRE_36;
	end
end


busmuxN_2_to_1	b2v_inst10(
	.S(SYNTHESIZED_WIRE_37),
	.In1(SYNTHESIZED_WIRE_2),
	.In2(IN),
	.Out(SYNTHESIZED_WIRE_15));
	defparam	b2v_inst10.N = 8;


busmuxN_2_to_1	b2v_inst11(
	.S(SYNTHESIZED_WIRE_37),
	.In1(SYNTHESIZED_WIRE_3),
	.In2(IN),
	.Out(SYNTHESIZED_WIRE_17));
	defparam	b2v_inst11.N = 8;


busmuxN_2_to_1	b2v_inst12(
	.S(SYNTHESIZED_WIRE_37),
	.In1(SYNTHESIZED_WIRE_4),
	.In2(IN),
	.Out(SYNTHESIZED_WIRE_19));
	defparam	b2v_inst12.N = 8;


busmuxN_2_to_1	b2v_inst13(
	.S(SYNTHESIZED_WIRE_37),
	.In1(SYNTHESIZED_WIRE_5),
	.In2(IN),
	.Out(SYNTHESIZED_WIRE_21));
	defparam	b2v_inst13.N = 8;


reg_8_bit	b2v_inst14(
	.LOAD(LOAD[0]),
	.CLK(CLK),
	.PRESET_N(SYNTHESIZED_WIRE_36),
	.CLEAR_N(RESET),
	.IN(SYNTHESIZED_WIRE_7),
	.OUT(SYNTHESIZED_WIRE_24));


reg_8_bit	b2v_inst15(
	.LOAD(LOAD[1]),
	.CLK(CLK),
	.PRESET_N(SYNTHESIZED_WIRE_36),
	.CLEAR_N(RESET),
	.IN(SYNTHESIZED_WIRE_9),
	.OUT(SYNTHESIZED_WIRE_25));


reg_8_bit	b2v_inst16(
	.LOAD(LOAD[2]),
	.CLK(CLK),
	.PRESET_N(SYNTHESIZED_WIRE_36),
	.CLEAR_N(RESET),
	.IN(SYNTHESIZED_WIRE_11),
	.OUT(SYNTHESIZED_WIRE_26));


reg_8_bit	b2v_inst17(
	.LOAD(LOAD[3]),
	.CLK(CLK),
	.PRESET_N(SYNTHESIZED_WIRE_36),
	.CLEAR_N(RESET),
	.IN(SYNTHESIZED_WIRE_13),
	.OUT(SYNTHESIZED_WIRE_27));


reg_8_bit	b2v_inst18(
	.LOAD(LOAD[4]),
	.CLK(CLK),
	.PRESET_N(SYNTHESIZED_WIRE_36),
	.CLEAR_N(RESET),
	.IN(SYNTHESIZED_WIRE_15),
	.OUT(SYNTHESIZED_WIRE_28));


reg_8_bit	b2v_inst19(
	.LOAD(LOAD[5]),
	.CLK(CLK),
	.PRESET_N(SYNTHESIZED_WIRE_36),
	.CLEAR_N(RESET),
	.IN(SYNTHESIZED_WIRE_17),
	.OUT(SYNTHESIZED_WIRE_29));



reg_8_bit	b2v_inst20(
	.LOAD(LOAD[6]),
	.CLK(CLK),
	.PRESET_N(SYNTHESIZED_WIRE_36),
	.CLEAR_N(RESET),
	.IN(SYNTHESIZED_WIRE_19),
	.OUT(SYNTHESIZED_WIRE_30));


reg_8_bit	b2v_inst21(
	.LOAD(LOAD[7]),
	.CLK(CLK),
	.PRESET_N(SYNTHESIZED_WIRE_36),
	.CLEAR_N(RESET),
	.IN(SYNTHESIZED_WIRE_21),
	.OUT(SYNTHESIZED_WIRE_31));


Ones	b2v_inst22(
	.O(SYNTHESIZED_WIRE_22));


busmuxN_2_to_1	b2v_inst23(
	.S(SYNTHESIZED_WIRE_37),
	.In1(SYNTHESIZED_WIRE_22),
	.In2(SYNTHESIZED_WIRE_23),
	.Out(LOAD));
	defparam	b2v_inst23.N = 8;


DMEM_PRGM	b2v_inst24(
	.D0(SYNTHESIZED_WIRE_32),
	.D1(SYNTHESIZED_WIRE_33),
	.D2(SYNTHESIZED_WIRE_34),
	.D3(SYNTHESIZED_WIRE_35),
	.D4(SYNTHESIZED_WIRE_2),
	.D5(SYNTHESIZED_WIRE_3),
	.D6(SYNTHESIZED_WIRE_4),
	.D7(SYNTHESIZED_WIRE_5));


busmux_8_to_1	b2v_inst25(
	.S(WRA),
	.W0(SYNTHESIZED_WIRE_24),
	.W1(SYNTHESIZED_WIRE_25),
	.W2(SYNTHESIZED_WIRE_26),
	.W3(SYNTHESIZED_WIRE_27),
	.W4(SYNTHESIZED_WIRE_28),
	.W5(SYNTHESIZED_WIRE_29),
	.W6(SYNTHESIZED_WIRE_30),
	.W7(SYNTHESIZED_WIRE_31),
	.F(OUTM));


Decoder3to8	b2v_inst4(
	.EN(DMEMWE),
	.S(WRA),
	.Y(SYNTHESIZED_WIRE_23));


busmuxN_2_to_1	b2v_inst6(
	.S(SYNTHESIZED_WIRE_37),
	.In1(SYNTHESIZED_WIRE_32),
	.In2(IN),
	.Out(SYNTHESIZED_WIRE_7));
	defparam	b2v_inst6.N = 8;


busmuxN_2_to_1	b2v_inst7(
	.S(SYNTHESIZED_WIRE_37),
	.In1(SYNTHESIZED_WIRE_33),
	.In2(IN),
	.Out(SYNTHESIZED_WIRE_9));
	defparam	b2v_inst7.N = 8;


busmuxN_2_to_1	b2v_inst8(
	.S(SYNTHESIZED_WIRE_37),
	.In1(SYNTHESIZED_WIRE_34),
	.In2(IN),
	.Out(SYNTHESIZED_WIRE_11));
	defparam	b2v_inst8.N = 8;


busmuxN_2_to_1	b2v_inst9(
	.S(SYNTHESIZED_WIRE_37),
	.In1(SYNTHESIZED_WIRE_35),
	.In2(IN),
	.Out(SYNTHESIZED_WIRE_13));
	defparam	b2v_inst9.N = 8;


endmodule
