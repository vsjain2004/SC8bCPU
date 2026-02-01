force -freeze sim:/Control/NOOP 1'h0 0
force -freeze sim:/Control/IN 1'h0 0
force -freeze sim:/Control/OUT 1'h0 0
force -freeze sim:/Control/I_END 1'h0 0
force -freeze sim:/Control/LDM 1'h0 0
force -freeze sim:/Control/LDD 1'h0 0
force -freeze sim:/Control/LDI 1'h0 0
force -freeze sim:/Control/LDX 1'h0 0
force -freeze sim:/Control/SWAP 1'h0 0
force -freeze sim:/Control/STO 1'h0 0
force -freeze sim:/Control/STI 1'h0 0
force -freeze sim:/Control/STX 1'h0 0
force -freeze sim:/Control/ADDM 1'h0 0
force -freeze sim:/Control/ADDD 1'h0 0
force -freeze sim:/Control/ADDI 1'h0 0
force -freeze sim:/Control/ADDX 1'h0 0
force -freeze sim:/Control/SUBM 1'h0 0
force -freeze sim:/Control/SUBD 1'h0 0
force -freeze sim:/Control/SUBI 1'h0 0
force -freeze sim:/Control/SUBX 1'h0 0
force -freeze sim:/Control/INC 1'h0 0
force -freeze sim:/Control/DEC 1'h0 0
force -freeze sim:/Control/LSL 1'h0 0
force -freeze sim:/Control/LSR 1'h0 0
force -freeze sim:/Control/ADDR 1'h0 0
force -freeze sim:/Control/SUBR 1'h0 0
force -freeze sim:/Control/MOV 1'h0 0
force -freeze sim:/Control/CMP 1'h0 0
force -freeze sim:/Control/CMD 1'h0 0
force -freeze sim:/Control/CMI 1'h0 0
force -freeze sim:/Control/CMX 1'h0 0
force -freeze sim:/Control/SWAPR 1'h0 0
force -freeze sim:/Control/JMP 1'h0 0
force -freeze sim:/Control/JPN 1'h0 0
force -freeze sim:/Control/JPE 1'h0 0
force -freeze sim:/Control/JGT 1'h0 0
force -freeze sim:/Control/JGE 1'h0 0
force -freeze sim:/Control/ANDM 1'h0 0
force -freeze sim:/Control/ANDD 1'h0 0
force -freeze sim:/Control/ANDI 1'h0 0
force -freeze sim:/Control/ANDX 1'h0 0
force -freeze sim:/Control/ORM 1'h0 0
force -freeze sim:/Control/ORD 1'h0 0
force -freeze sim:/Control/ORI 1'h0 0
force -freeze sim:/Control/ORX 1'h0 0
force -freeze sim:/Control/XORM 1'h0 0
force -freeze sim:/Control/XORD 1'h0 0
force -freeze sim:/Control/XORI 1'h0 0
force -freeze sim:/Control/XORX 1'h0 0
force -freeze sim:/Control/NOT 1'h0 0
force -freeze sim:/Control/ASR 1'h0 0
force -freeze sim:/Control/CSL 1'h0 0
force -freeze sim:/Control/CSR 1'h0 0
force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/RX[0] 1'h0 0
force -freeze sim:/Control/RY[1] 1'h0 0
force -freeze sim:/Control/RY[0] 1'h0 0
force -freeze sim:/Control/NF 1'h0 0
force -freeze sim:/Control/OF 1'h0 0
force -freeze sim:/Control/ZF 1'h0 0

run 20

force -freeze sim:/Control/NOOP 1'h1 0

run 20

force -freeze sim:/Control/NOOP 1'h0 0
force -freeze sim:/Control/IN 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/IN 1'h0 0
force -freeze sim:/Control/OUT 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/OUT 1'h0 0
force -freeze sim:/Control/I_END 1'h1 0

run 20

force -freeze sim:/Control/I_END 1'h0 0
force -freeze sim:/Control/LDM 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/LDM 1'h0 0
force -freeze sim:/Control/LDD 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/LDD 1'h0 0
force -freeze sim:/Control/LDI 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/LDI 1'h0 0
force -freeze sim:/Control/LDX 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/LDX 1'h0 0
force -freeze sim:/Control/SWAP 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/SWAP 1'h0 0
force -freeze sim:/Control/STO 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/STO 1'h0 0
force -freeze sim:/Control/STI 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/STI 1'h0 0
force -freeze sim:/Control/STX 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/STX 1'h0 0
force -freeze sim:/Control/ADDM 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/ADDM 1'h0 0
force -freeze sim:/Control/ADDD 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/ADDD 1'h0 0
force -freeze sim:/Control/ADDI 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/ADDI 1'h0 0
force -freeze sim:/Control/ADDX 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/ADDX 1'h0 0
force -freeze sim:/Control/SUBM 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/SUBM 1'h0 0
force -freeze sim:/Control/SUBD 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/SUBD 1'h0 0
force -freeze sim:/Control/SUBI 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/SUBI 1'h0 0
force -freeze sim:/Control/SUBX 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/SUBX 1'h0 0
force -freeze sim:/Control/INC 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/INC 1'h0 0
force -freeze sim:/Control/DEC 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/DEC 1'h0 0
force -freeze sim:/Control/LSL 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/LSL 1'h0 0
force -freeze sim:/Control/LSR 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/LSR 1'h0 0
force -freeze sim:/Control/ADDR 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/RY[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/RY[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/RY[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/RY[1] 1'h0 0
force -freeze sim:/Control/ADDR 1'h0 0
force -freeze sim:/Control/SUBR 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/RY[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/RY[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/RY[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/RY[1] 1'h0 0
force -freeze sim:/Control/SUBR 1'h0 0
force -freeze sim:/Control/MOV 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/RY[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/RY[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/RY[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/RY[1] 1'h0 0
force -freeze sim:/Control/MOV 1'h0 0
force -freeze sim:/Control/CMP 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/CMP 1'h0 0
force -freeze sim:/Control/CMD 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/CMD 1'h0 0
force -freeze sim:/Control/CMI 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/CMI 1'h0 0
force -freeze sim:/Control/CMX 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/CMX 1'h0 0
force -freeze sim:/Control/SWAPR 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/RY[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/RY[0] 1'h0 0
force -freeze sim:/Control/RY[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/RY[1] 1'h0 0
force -freeze sim:/Control/SWAPR 1'h0 0
force -freeze sim:/Control/JMP 1'h1 0

run 20

force -freeze sim:/Control/JMP 1'h0 0
force -freeze sim:/Control/JPN 1'h1 0

run 20

force -freeze sim:/Control/ZF 1'h1 0

run 20

force -freeze sim:/Control/ZF 1'h0 0
force -freeze sim:/Control/JPN 1'h0 0
force -freeze sim:/Control/JPE 1'h1 0

run 20

force -freeze sim:/Control/ZF 1'h1 0

run 20

force -freeze sim:/Control/ZF 1'h0 0
force -freeze sim:/Control/JPE 1'h0 0
force -freeze sim:/Control/JGT 1'h1 0

run 20

force -freeze sim:/Control/OF 1'h1 0

run 20

force -freeze sim:/Control/NF 1'h1 0

run 20

force -freeze sim:/Control/OF 1'h0 0

run 20

force -freeze sim:/Control/ZF 1'h1 0

run 20

force -freeze sim:/Control/OF 1'h1 0

run 20

force -freeze sim:/Control/NF 1'h0 0

run 20

force -freeze sim:/Control/OF 1'h0 0

run 20

force -freeze sim:/Control/ZF 1'h0 0
force -freeze sim:/Control/JGT 1'h0 0
force -freeze sim:/Control/JGE 1'h1 0

run 20

force -freeze sim:/Control/OF 1'h1 0

run 20

force -freeze sim:/Control/NF 1'h1 0

run 20

force -freeze sim:/Control/OF 1'h0 0

run 20

force -freeze sim:/Control/NF 1'h0 0
force -freeze sim:/Control/JGE 1'h0 0
force -freeze sim:/Control/ANDM 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/ANDM 1'h0 0
force -freeze sim:/Control/ANDD 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/ANDD 1'h0 0
force -freeze sim:/Control/ANDI 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/ANDI 1'h0 0
force -freeze sim:/Control/ANDX 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/ANDX 1'h0 0
force -freeze sim:/Control/ORM 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/ORM 1'h0 0
force -freeze sim:/Control/ORD 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/ORD 1'h0 0
force -freeze sim:/Control/ORI 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/ORI 1'h0 0
force -freeze sim:/Control/ORX 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/ORX 1'h0 0
force -freeze sim:/Control/XORM 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/XORM 1'h0 0
force -freeze sim:/Control/XORD 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/XORD 1'h0 0
force -freeze sim:/Control/XORI 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/XORI 1'h0 0
force -freeze sim:/Control/XORX 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/XORX 1'h0 0
force -freeze sim:/Control/NOT 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/NOT 1'h0 0
force -freeze sim:/Control/ASR 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/ASR 1'h0 0
force -freeze sim:/Control/CSL 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20

force -freeze sim:/Control/RX[1] 1'h0 0
force -freeze sim:/Control/CSL 1'h0 0
force -freeze sim:/Control/CSR 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h1 0

run 20

force -freeze sim:/Control/RX[1] 1'h1 0

run 20

force -freeze sim:/Control/RX[0] 1'h0 0

run 20