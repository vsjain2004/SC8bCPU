module memory2 (clk, data, we, addr, dlen, q);
	input clk;
	input [10:0] addr;
	input [31:0] data;
	input we, dlen;
	output [31:0] q;
	
	reg [15:0] ram [0:(1<<11)-1];
	
	always @(posedge clk) begin
		if (we) begin
			if(dlen & (&addr[10:0])) begin
				ram[addr] <= data[31:16];
			else if(dlen) begin
					ram[addr] <= data[31:16];
					ram[addr + 1] <= data[15:0];
				end
			else
				ram[addr] <= data[15:0];
			end
		end
	end
	assign q = (&addr) ? ({16'b0, ram[addr]}) : (dlen ? {ram[addr], ram[addr + 1]} : {16'b0, ram[addr]});
endmodule