create_clock -name CLK -period 20.000 -waveform { 0.000 10.000 } [get_ports CLK]

#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty 0.100 [get_clocks CLK]

# set_driving_cell -lib_cell BUFX2 [all_inputs -filter "name != CLK"]

set_load 0.010 [all_outputs]

# set_input_delay -clock CLK 0.200 [all_inputs -filter "name != CLK"]
set_output_delay -clock CLK 2.000 [all_outputs]