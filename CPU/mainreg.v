module mainreg(
	input wire [4:0] WAA, WAB, RAA, RAB,
	input wire [31:0] INA, INB,
	input wire MRWEA, MRWEB, CLK, RESET,
	output wire [31:0] OUTA, OUTB, OUTC
);
	

	wire [31:0] dOA, dOB;
	wire [1023:0] OReg;
	wire [31:0] IReg [1:31];
	
	decoder5to32 decodeA(.S(WAA), .EN(MRWEA), .O(dOA));
	decoder5to32 decodeB(.S(WAB), .EN(MRWEB), .O(dOB));
	
	Zeros Z(.Z(OReg[31:0]));
	genvar i;
	generate
		for(i = 1; i < 32; i = i + 1) begin: reg31x32
			assign IReg[i] = ({32{dOA[i]}} & INA) | ({32{dOB[i]}} & INB);
			reg_N_bit regn(.IN(IReg[i]), .LOAD(dOA[i] | dOB[i]), .CLK(CLK), .OUT(OReg[i*32 +: 32]), .PRESET_N(1'b1), .CLEAR_N(RESET));
		end
	endgenerate
	
	busmuxN_32_to_1 opa(.S(RAA), .W(OReg), .F(OUTA));
	busmuxN_32_to_1 opb(.S(RAB), .W(OReg), .F(OUTB));
	Ones O(.O(OUTC));
endmodule