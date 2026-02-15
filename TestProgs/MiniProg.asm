        LDM IX, #0
        LDD A, NUM1
        LDD B, NUM2
        ADDR A, B
        STO A, SUM
        CMP A, #15
        JGE PRINT
        LDM C, #0
        JMP DONE
PRINT:  OUT A
        SWAPR A, B
DONE:   END

NUM1: #7
NUM2: #8
SUM:  #0