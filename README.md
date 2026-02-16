Main Project File: [CPU/CPU.v](CPU/CPU.v)

Instructions to run:

1. Generate hex files for your assembly program. Instructions to writing the assembly program are provided in [ASM Program format.txt](ASM%20Program%20format.txt). Run the Assembler provided within the Converter folder are provide your file path to generate the hex files. Note: These are generic hex files.
2. If simulating virtually using QuestaSim or via FPGA using Intel's Quartus Prime Software, projects for both are available within the CPU folder as [CPU.mpf](CPU.mpf) and [CPU.qpf](CPU.qpf) respectively.
3. If using Quartus Prime or any other software that does not prefer generic hex files, ensure the memory files are converted accordingly.
4. For simulation on FPGA, make sure to set pin assignments correctly, compile the project to your FPGA, and set the clock frequency accordingly.
5. Once ready to simulate, load the IMEM and DMEM files and run.

Sample programs are available in the [TestProgs](TestProgs) folder. These can be used for verification if any changes are made to source files.

Refer to [Green Card.pdf](Green%20Card.pdf) for details on instructions and their formats.