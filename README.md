Main Project File: [CPU/CPU.v](CPU/CPU.v)

Instructions to run:

1. Generate hex files for your assembly program. Instructions to writing the assembly program are provided in [ASM Program format.txt](ASM%20Program%20format.txt). Run the Assembler provided within the Converter folder are provide your file path to generate the hex files. Note: These are generic hex files.
2. If simulating virtually using QuestaSim, a project is available within the CPU folder as [CPU.mpf](CPU.mpf).
3. If using Quartus Prime or any other software that does not prefer generic hex files, ensure the memory files are converted accordingly.
4. For simulation on FPGA, make sure to set pin assignments correctly, compile the project to your FPGA, and set the clock frequency accordingly.
5. Once ready to simulate, load the IMEM and DMEM files and run.

Sample programs are available in the [TestProgs](TestProgs) folder. These can be used for verification if any changes are made to source files.

Refer to [Green Card.pdf](Green%20Card.pdf) for details on instructions and their formats.

Schematics at both a High Level, as well as Gate Level are available in DOT format, as created by Yosys.

A completely synthesized and flattened version's Verilog code is available at [Complete.v](Gate_Level/Complete.v) within the Gate Level folder. If wanted, this version can also be used for simulation, provided the file name is changed to from Complete.v to CPU.v.