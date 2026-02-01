module Control_Unit(
input [7:0] INST,
input NF, OF, ZF,
output REG_WLINE_1, REG_WLINE_0, REG_W_EN, REG_W_ADD_1, REG_W_ADD_0, REG_ADD_4, REG_ADD_3, REG_ADD_2, 
		 REG_ADD_1, REG_ADD_0, ADD_SUB, ALU_S_0, ALU_S_1, FLAG_W, ALU_SL_1, ALU_SL_0, DMEM_W_EN, DMEM_S_ADD, 
		 PC_LD_EN, PC_EN, OUT_EN, SWAP_R, ALU_S_2
);

wire [15:0] opcode;

decoder4to16 opdef1(.S(INST[7:4]), .O(opcode));

wire [3:0] op0, op1, op2, op3, op6, op8, op9, op10, op12, op14;

Decoder2to4 opdec0(.S1(INST[3]), .S0(INST[2]), .EN(opcode[0]), .Y0(op0[0]), .Y1(op0[1]), .Y2(op0[2]), .Y3(op0[3]));
Decoder2to4 opdec1(.S1(INST[3]), .S0(INST[2]), .EN(opcode[1]), .Y0(op1[0]), .Y1(op1[1]), .Y2(op1[2]), .Y3(op1[3]));
Decoder2to4 opdec2(.S1(INST[3]), .S0(INST[2]), .EN(opcode[2]), .Y0(op2[0]), .Y1(op2[1]), .Y2(op2[2]), .Y3(op2[3]));
Decoder2to4 opdec3(.S1(INST[3]), .S0(INST[2]), .EN(opcode[3]), .Y0(op3[0]), .Y1(op3[1]), .Y2(op3[2]), .Y3(op3[3]));
Decoder2to4 opdec6(.S1(INST[3]), .S0(INST[2]), .EN(opcode[6]), .Y0(op6[0]), .Y1(op6[1]), .Y2(op6[2]), .Y3(op6[3]));
Decoder2to4 opdec8(.S1(INST[3]), .S0(INST[2]), .EN(opcode[8]), .Y0(op8[0]), .Y1(op8[1]), .Y2(op8[2]), .Y3(op8[3]));
Decoder2to4 opdec9(.S1(INST[3]), .S0(INST[2]), .EN(opcode[9]), .Y0(op9[0]), .Y1(op9[1]), .Y2(op9[2]), .Y3(op9[3]));
Decoder2to4 opdec10(.S1(INST[3]), .S0(INST[2]), .EN(opcode[10]), .Y0(op10[0]), .Y1(op10[1]), .Y2(op10[2]), .Y3(op10[3]));
Decoder2to4 opdec12(.S1(INST[3]), .S0(INST[2]), .EN(opcode[12]), .Y0(op12[0]), .Y1(op12[1]), .Y2(op12[2]), .Y3(op12[3]));
Decoder2to4 opdec14(.S1(INST[3]), .S0(INST[2]), .EN(opcode[14]), .Y0(op14[0]), .Y1(op14[1]), .Y2(op14[2]), .Y3(op14[3]));

assign REG_WLINE_1 = op0[1] | op0[2] | op1[3];
assign REG_WLINE_0 = op0[0] | op1[3];
assign REG_W_EN = ~(op0[3] | op1[0] | op1[1] | op1[2] | op2[3] | opcode[7] | opcode[8] | opcode[9]);
assign REG_W_ADD_1 = REG_W_EN & INST[1];
assign REG_W_ADD_0 = REG_W_EN & INST[0];
assign REG_ADD_4 = op6[0] | op6[1];
assign REG_ADD_3 = ((op1[1] | op1[2]) & (INST[1])) | ((opcode[4] | opcode[5] | opcode[7] | opcode[11] | opcode[13] | opcode[15]) & (INST[3]));
assign REG_ADD_2 = ((op1[1] | op1[2]) & (INST[0])) | ((opcode[4] | opcode[5] | opcode[7] | opcode[11] | opcode[13] | opcode[15]) & (INST[2]));
assign REG_ADD_1 = ((opcode[2] | opcode[3] | opcode[4] | opcode[5] | opcode[6] | opcode[7] | op8[0] | op8[1] | op8[2] | opcode[10] | opcode[11] | opcode[12] | opcode[13] | opcode[14] | opcode[15]) & (INST[1]));
assign REG_ADD_0 = ((opcode[2] | opcode[3] | opcode[4] | opcode[5] | opcode[6] | opcode[7] | op8[0] | op8[1] | op8[2] | opcode[10] | opcode[11] | opcode[12] | opcode[13] | opcode[14] | opcode[15]) & (INST[0]));
assign ADD_SUB = op3[0] | op3[1] | op3[2] | opcode[5] | op6[0] | op6[3] | op8[0] | op8[1] | op8[2] | op14[3];
assign ALU_S_0 = op6[2] | op6[3] | op10[0] | op10[1] | op10[2] | opcode[11] | op12[3] | opcode[14] | opcode[15];
assign ALU_S_1 = op3[3] | opcode[12] | opcode[13] | opcode[14] | opcode[15];
assign ALU_S_2 = op3[3] | op6[2] | op6[3] | op10[3] | op12[3] | op14[3];
assign FLAG_W = op2[0] | op2[1] | op2[2] | op3[0] | op3[1] | op3[2] | opcode[4] | opcode[5] | op8[0] | op8[1] | op8[2];
assign ALU_SL_1 = op2[0] | op2[1] | op2[2] | opcode[3] | op6[2] | op6[3] | op8[0] | op8[1] | op8[2] | op10[0] | op10[1] | op10[2] | opcode[12] | opcode[14];
assign ALU_SL_0 = op2[1] | op2[2] | op3[1] | op3[2] | op6[0] | op6[1] | op8[1] | op8[2] | op10[1] | op10[2] | op12[1] | op12[2] | op14[1] | op14[2];
assign DMEM_W_EN = op1[1] | op1[2];
assign DMEM_S_ADD = op0[2] | op1[2] | op2[2] | op3[2] | op8[2] | op10[2] | op12[2] | op14[2];
assign PC_LD_EN = op8[3] | (op9[0] & ~ZF) | (op9[1] & ZF) | (op9[2] & ~ZF & (NF ~^ OF)) | (op9[3] & (NF ~^ OF));
assign PC_EN = ~op1[0];
assign OUT_EN = op2[3];
assign SWAP_R = opcode[7];

endmodule