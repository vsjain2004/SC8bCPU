# ==============================================================================
# OPENSTA TIMING ANALYSIS SCRIPT
# Target Node: FreePDK45 (Post-Synthesis Pre-Layout)
# ==============================================================================

# 1. Define Design Constraints and Files
set DESIGN_NAME     "CPU"
set LIB_FILE        "/vjrai/Downloads/freepdk45-v14/FreePDK45/osu_soc/lib/files/gscl45nm.lib"
set SYNTH_NETLIST   "/vjrai/Documents/SC8bCPU/outputs/CPU.v"
set SDC_FILE        "/vjrai/Documents/SC8bCPU/CPU/CPU.sdc"
set REPORT_DIR      "/vjrai/Documents/SC8bCPU/outputs"

# 2. Setup Output Directory
if {![file exists $REPORT_DIR]} {
    file mkdir $REPORT_DIR
}

# 3. Load Design Assets into OpenSTA
puts "Loading timing library: $LIB_FILE"
read_liberty $LIB_FILE

puts "Reading structural gate-level netlist: $SYNTH_NETLIST"
read_verilog $SYNTH_NETLIST

puts "Elaborating design top module: $DESIGN_NAME"
link_design $DESIGN_NAME

puts "Applying timing constraints: $SDC_FILE"
read_sdc $SDC_FILE

set ALL_DATA_INPUTS {}
foreach port [all_inputs] {
    if {[get_name $port] ne "CLK"} {
        lappend ALL_DATA_INPUTS $port
    }
}

# Apply input drive and delays safely only to valid data inputs
if {[llength $ALL_DATA_INPUTS] > 0} {
    puts "Applying input constraints to [llength $ALL_DATA_INPUTS] data ports..."
    set_driving_cell -lib_cell BUFX2 $ALL_DATA_INPUTS
    set_input_delay -clock CLK 2.000 $ALL_DATA_INPUTS
}

# 4. Configure Pre-Layout Analysis Conditions
# Pre-layout timing lacks real copper wires; we must simulate wire load models 
# and tell OpenSTA to assume an unbuffered, ideal clock network.
set_operating_conditions -analysis_type single
# set_data_check -setup
# set_data_check -hold

# 5. Extract Global Timing Metrics (WNS / TNS)
puts "======================================================================"
puts "                       GLOBAL TIMING METRICS                          "
puts "======================================================================"

# Check for setup violations (Worst Negative Slack and Total Negative Slack)
report_checks -path_delay max -digits 4

# Check for hold violations
report_checks -path_delay min -digits 4

# 6. Generate 10 Most Critical Paths Report
set SETUP_REPORT "$REPORT_DIR/top_10_critical_setup_paths.txt"
puts "Writing top 10 worst setup paths to: $SETUP_REPORT"

# -path_delay max: targets setup/max-delay constraints
# -group_count 10: pulls the 10 worst independent timing paths
# -digits 4: provides fine grain picosecond precision matching 45nm parameters
report_checks -path_delay max -group_count 10 -digits 4 > $SETUP_REPORT

read_vcd "/vjrai/Documents/SC8bCPU/outputs/torture_simulation_output.vcd"

# 7. Generate Power Metrics
set POWER_REPORT "$REPORT_DIR/power_analysis.txt"
puts "Writing estimated power report to: $POWER_REPORT"
report_power -digits 4 > $POWER_REPORT

puts "OpenSTA analysis completed cleanly."
exit