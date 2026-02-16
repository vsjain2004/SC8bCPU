add wave -position insertpoint sim:/CPU/*

add wave -position insertpoint  \
sim:/CPU/MReg/OB \
sim:/CPU/MReg/OC

force -freeze sim:/CPU/InstLd 1'h0 0
force -freeze sim:/CPU/InstExt 16'h0000 0
force -freeze sim:/CPU/CLK 0 0, 1 {50 ns} -r 100
force -freeze sim:/CPU/IN 8'hab 0
force -freeze sim:/CPU/CLEAR_N 1'h0 0

mem load -infile ../TestProgs/{}_IMEM.hex -format hex /CPU/IMEM
mem load -infile ../TestProgs/{}_DMEM.hex -format hex /CPU/DMEM

run 20

force -freeze sim:/CPU/CLEAR_N 1'h1 0

run 80