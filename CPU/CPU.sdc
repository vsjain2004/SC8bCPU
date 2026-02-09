set_time_format -unit ns -decimal_places 3

create_clock -name {CLKT} -period 9.500 -waveform { 0.000 4.750 } [get_ports { CLKT }]

#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {CLKT}] -rise_to [get_clocks {CLKT}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {CLKT}] -fall_to [get_clocks {CLKT}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {CLKT}] -rise_to [get_clocks {CLKT}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {CLKT}] -fall_to [get_clocks {CLKT}]  0.020  