mem load -skip 0 -filltype value -filldata 0000 -fillradix hexadecimal /CPU/IMEM/ram
mem load -skip 0 -filltype value -filldata 00 -fillradix hexadecimal /CPU/DMEM/ram
mem load -infile ../TestProgs/Torture_IMEM.hex -format hex /CPU/IMEM/ram
mem load -infile ../TestProgs/Torture_DMEM.hex -format hex /CPU/DMEM/ram

force /CPU/CLK 0 0ns, 1 10ns -repeat 20ns
force /CPU/InstLd 0
force /CPU/CLEAR_N 0
force /CPU/InstExt 64'h0000000000000000

vcd file ../outputs/torture_simulation_output.vcd
vcd add -r /CPU/*

run 25ns
force /CPU/CLEAR_N 1

run 2165ns

vcd flush
quit -sim

vcd2wlf ../outputs/torture_simulation_output.vcd ../outputs/torture_simulation_output.wlf