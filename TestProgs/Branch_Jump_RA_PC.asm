        // ===== SETUP =====
        LDM R2, #5
        LDM R3, #5
        CMP R2, R3
        JPE EQUAL
        LDM R4, #0
        JMP END_LABEL
EQUAL:  LDM R4, #1
        // ===== LOOP =====
        LDM R5, #3
LOOP:   DEC R5
        CMP R5, #0
        JGT LOOP
        // ===== JAL TEST =====
        JAL FUNC
        // executes after return
        ADD R6, R6, #1      
        JMP END_LABEL
FUNC:   LDM R6, #10
        // return via RA        
        JMP RA      
END_LABEL:  LDM R8, #42
        END