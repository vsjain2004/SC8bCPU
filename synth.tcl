set DESIGN_NAME     "CPU"
set TOP_LEVEL       "CPU"
set SOURCE_DIR      "./CPU"
set OUTPUT_DIR      "C:/Users/vjrai/Documents/SC8bCPU/outputs"
set SCHEM_DIR	    "C:/Users/vjrai/Documents/SC8bCPU/Schematics"
set LIB_PATH        "C:/Users/vjrai/Downloads/freepdk45-v14/FreePDK45/osu_soc/lib/files/gscl45nm.lib"

yosys -import

puts "Creating output directory: $OUTPUT_DIR"
if {![file exists $OUTPUT_DIR]} {
    file mkdir $OUTPUT_DIR
}

puts "Reading all Verilog files from folder: $SOURCE_DIR"
foreach f [glob -nocomplain "$SOURCE_DIR/*.v" "$SOURCE_DIR/*.sv"] {
    puts " -> Loading source file: $f"
    read_verilog -sv $f
}

puts "Elaborating design top level: $TOP_LEVEL"
hierarchy -check -top $TOP_LEVEL

puts "Starting standard logic synthesis..."
synth -top $TOP_LEVEL

puts "Mapping netlist to FreePDK45 library: $LIB_PATH"
dfflibmap -liberty $LIB_PATH
abc -exe yosys-abc -liberty $LIB_PATH

puts "Cleaning up dangling logic networks..."
clean -purge

puts "======================================================================"
puts "                   SYNTHESIS AREA AND CELL REPORT                     "
puts "======================================================================"
stat -liberty $LIB_PATH
tee -o "$OUTPUT_DIR/synthesis_report.txt" stat -liberty $LIB_PATH

set OUTPUT_NETLIST "$OUTPUT_DIR/${DESIGN_NAME}.v"
puts "Writing structural netlist file to: $OUTPUT_NETLIST"
write_verilog -noattr -noexpr -nohex -nodec $OUTPUT_NETLIST

puts "Synthesis script completed successfully."
exit