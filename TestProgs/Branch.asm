        LDM A, #5
LOOP:   DEC A
        CMP A, #0
        JGT LOOP
        LDM B, #1
        CMP B, #1
        JPE GOOD
        JMP BAD
GOOD:   LDM C, #99
        JMP DONE
BAD:    LDM C, #55
DONE:   END