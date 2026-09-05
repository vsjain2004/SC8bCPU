module PC(
	input wire CLK, RESET,
	input wire PCEN, ULen, LOAD,
	input wire [31:0] IN,
	output wire [31:0] oPC, oNPC
);

	

	wire [31:0] PCAdd, NPCSeq;

	assign PCAdd = ULen ? 32'd4 : 32'd2;

	AddSub_N_bit npcseq(.Cin(1'b0), .X(oPC), .Y(PCAdd), .S(oNPC), .Cout(), .Ov());

	assign NPCSeq = LOAD ? IN : oNPC;
	
	reg_N_bit pc(.IN(NPCSeq), .LOAD(PCEN), .CLK(CLK), .OUT(oPC), .PRESET_N(1'b1), .CLEAR_N(RESET));

endmodule