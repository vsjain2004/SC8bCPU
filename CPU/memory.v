module memory #(parameter data_width = 8, addr_width = 3)(clk, data, we, addr, q);
	input clk;
	input [addr_width-1:0] addr;
	input [data_width-1:0] data;
	input we;
	output reg [data_width-1:0] q;
	
	reg [data_width-1:0] ram [0:(1<<addr_width)-1];
	
	always @(posedge clk) begin
		if (we) begin
        ram[addr] <= data;
		end
		q <= ram[addr];
	end
	
endmodule