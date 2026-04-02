// ===== SHIFT TESTS =====
LDM R2, #1
LSL R3, R2, #5
LSR R4, R3, #2
ASR R5, R4, #1
LDM R6, #3
LSLR R7, R3, R6
ASRR R8, R7, R6
CSL R9, R8, #2
CSR R10, R9, #2
// ===== MULTIPLY =====
LDM R11, #6
LDM R12, #7
// R13=low, R14=high
MULT R13, R14, R11, R12    
MULTU R15, R16, R11, #3
MULTH R17, R11, R12
// ===== DIVIDE =====
// quotient + remainder
DIV R18, R19, R12, R11     
REM R20, R12, R11
// divide by zero
LDM R21, #0
// should trigger D flag
DIV R22, R23, R11, R21     
END

word DUMMY: #0