        LDM A, #127
        // Overflow case (127 + 1)
        ADDM A, #1
        CMP A, #-128
        JPE OK1
        LDM B, #0
        // Negative result
OK1:    SUBM B, #1        
        CMP B, #-1       
        JPE OK2
        LDM C, #0
OK2:    LDM C, #5
        SUBM C, #5
        CMP C, #0
        JPE DONE
        LDM A, #99
DONE:   END