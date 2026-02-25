module mainreg(INA, INB, MRWEA, MRWEB, WAA, WAB, RAA, RAB, CLK, RESET, OUTA, OUTB, OUTC);
	input MRWEA, MRWEB, CLK, RESET;
	input [4:0] WAA, WAB, RAA, RAB;
	input [31:0] INA, INB;
	output [31:0] OUTA, OUTB, OUTC;

	wire [31:0] dOA, dOB;
	wire [31:0] OReg [0:31];
	wire [31:0] IReg [1:31];
	
	decoder5to32 decodeA(.S(WAA), .EN(MRWEA), .O(dOA));
	decoder5to32 decodeB(.S(WAB), .EN(MRWEB), .O(dOB));
	
	Zeros Z(.Z(OReg[0]));
	genvar i;
	generate
		for(i = 1; i < 32; i = i + 1) begin: reg31x32
			assign IReg[i] = ({32{dOA[i]}} & INA) | ({32{dOB[i]}} & INB);
			reg_N_bit regn(.IN(IReg[i]), .LOAD(dOA[i] | dOB[i]), .CLK(CLK), .OUT(OReg[i]), .PRESET_N(1'b1), .CLEAR_N(RESET));
		end
	endgenerate
	
	busmuxN_32_to_1 opa(.S(RAA), .W(OReg), .F(OUTA));
	busmuxN_32_to_1 opb(.S(RAB), .W(OReg), .F(OUTB));
	Ones O(.O(OUTC));
endmodule