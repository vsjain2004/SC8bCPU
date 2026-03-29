LDW R4, X
ADD R5, Z, #10
Y: SWAPR R4, R5
END

byte X: #&2A
string Z: "abc"
word[3] A:
half[] B: [#1, #B10, #&ffff]