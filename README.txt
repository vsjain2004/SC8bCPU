Main Project File: FinalProject.bdf

Instructions to run:
1. Loading the program
	a. Open IMEM_PRGM.v and comment all lines containing assign statements.
	b. Uncomment lines for the program you want to run and save. (Structure program given below)
	c. Open DMEM_PRGM.v and comment all lines containing assign statements.
	d. Uncomment lines of data for the program you want to run and save. (Structure of data given below)
	e. Compile and run
2. Running the program
	a. On the board, there are two clocks you can use: Manual and Auto. For Manual clock, press Key0 to go to the next instruction. 
	   For Auto clock, hold Key2. Reset is on Key1.
	b. For programs requiring input, use switches SW17 to SW10.
	c. To visualize different main and data registers, the switches SW9 and SW8 can be used for one of the main registers and the data can
	   be seen on HEX7 and HEX6. For data memory, use switches SW7 to SW5 to control HEX3 and HEX2 and switches SW4 to SW2 to control HEX1
 	   and HEX0. HEX5 and HEX4 visualize the Index Register (Also available on SW9 = 1 and SW8 = 1).
	d. The red LEDs LEDR[17] to LEDR[2] visualize the current Instruction. The green LEDs LEDG[7] to LEDG[4] visualize the Flags register.
	   The green LEDs LEDG[3] to LEDG[0] visualize the Program Counter.
	e. In case the program uses the LCD display, note that loading a new program or pressing reset will not clear the LCD display.

NOTE: A recording of each program has been provided in 'Program Videos' folder

IMEM program structure:
//program name
assign A = 16'b0000000000000000;
assign B = 16'b0001010000000000;
assign C = 16'b1100000000000000;
assign D = 16'b0010010000000000;
assign E = 16'b0001001100000001;
assign F = 16'b0111000000000000;
assign G = 16'b0010110000000000;
assign H = 16'b0001010000000000;
assign I = 16'b1101000000000001;
assign J = 16'b0010010000000000;
assign K = 16'b1101000001111111;
assign L = 16'b0010010000000000;
assign M = 16'b1001000001111111;
assign N = 16'b1011000000001110;
assign O = 16'b1110000010000000;
assign P = 16'b1111000000000000;

DMEM program structure:
//program names separated by commas
assign D0 = 8'b00000000;
assign D1 = 8'b00000000;
assign D2 = 8'b00000000;
assign D3 = 8'b00000000;
assign D4 = 8'b00000000;
assign D5 = 8'b00000000;
assign D6 = 8'b00000000;
assign D7 = 8'b00000000;