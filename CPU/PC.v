module PC(LOAD, IN, ULen, PCEN, CLK, RESET, oPC, oNPC);

	input LOAD, PCEN, ULen, CLK, RESET;
	input [31:0] IN;
	output [31:0] oPC, oNPC;

	wire [31:0] PCAdd, NPCSeq;

	assign PCAdd = ULen ? 32'd4 : 32'd2;

	AddSub_N_bit npcseq(.Cin('b0), .X(oPC), .Y(PCAdd), .S(NPCSeq), .Cout(), .Ov());

	assign oNPC = LOAD ? IN : NPCSeq;
	
	reg_N_bit pc(.IN(oNPC), .LOAD(PCEN), .CLK(CLK), .OUT(oPC), .PRESET_N(1'b1), .CLEAR_N(RESET));

endmodule