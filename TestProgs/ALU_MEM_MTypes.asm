// ===== ALU + LOAD/STORE =====
LDM R2, #10
LDM R3, #20
ADD R4, R2, R3
SUB R5, R4, #5
AND R6, R4, #&F
OR  R7, R5, #&F0
XOR R8, R6, R7
NOT R9, R8
// ===== MEMORY (LABEL) =====
LDW R10, X
ADD R10, R10, #5
STW R10, X
// ===== DIRECT MEMORY =====
LDM R15, X_addr
LDW R11, [R15]
ADD R11, R11, #1
STW R11, [R15]
// ===== INDEXED =====
LDM R12, #0
LDB R13, (1)[R12]
STH R13, (2)[R12]
END

word X: #100
word X_addr: #0
byte B0: #1
byte B1: #2
half H0: #&1234
string STR: "hi"