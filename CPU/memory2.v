module memory2 #(parameter BASE_BIT_WIDTH = 8, ADDR_WIDTH = 12) (clk, data, we, addr, dlen, q); 
	input clk;
	input [ADDR_WIDTH-1:0] addr;
	input [BASE_BIT_WIDTH*4 - 1:0] data;
	input we;
	input [1:0] dlen;
	output reg [BASE_BIT_WIDTH*4 - 1:0] q;
	
	reg [BASE_BIT_WIDTH-1:0] ram [0:(1<<ADDR_WIDTH)-1];
	
	wire addr1, addr2, addr3;
	assign addr1 = &addr;
	assign addr2 = &addr[ADDR_WIDTH-1:1];
	assign addr3 = &addr[ADDR_WIDTH-1:2] & (~|addr[1:0]);

	always @(posedge clk) begin
		if (we) begin
			case (dlen)
				2'b00 : ram[addr] <= data[BASE_BIT_WIDTH-1:0];
				2'b01 : begin
						ram[addr] <= data[BASE_BIT_WIDTH-1:0];
						if(~addr1) begin
							ram[addr + 1] <= data[BASE_BIT_WIDTH*2-1:BASE_BIT_WIDTH];
						end
					end
				2'b10 : begin
						ram[addr] <= data[BASE_BIT_WIDTH-1:0];
						if(~addr1) begin
							ram[addr + 1] <= data[BASE_BIT_WIDTH*2-1:BASE_BIT_WIDTH];
						end
						if(addr1 ~| addr2) begin
							ram[addr + 2] <= data[BASE_BIT_WIDTH*3-1:BASE_BIT_WIDTH*2];
						end
					end
				2'b11 : begin
						ram[addr] <= data[BASE_BIT_WIDTH-1:0];
						if(~addr1) begin
							ram[addr + 1] <= data[BASE_BIT_WIDTH*2-1:BASE_BIT_WIDTH];
						end
						if(addr1 ~| addr2) begin
							ram[addr + 2] <= data[BASE_BIT_WIDTH*3-1:BASE_BIT_WIDTH*2];
						end
						if(addr1 ~| addr2 ~| addr3) begin
							ram[addr + 3] <= data[BASE_BIT_WIDTH*4-1:BASE_BIT_WIDTH*3];
						end
					end
				default: ;
			endcase
		end
	end
	
	always @(addr, addr1, addr2, addr3, dlen, ram) begin
		case (dlen)
			2'b00 : q = {{BASE_BIT_WIDTH*3{1'b0}}, ram[addr]};
			2'b01 : q = addr1 ? {{BASE_BIT_WIDTH*3{1'b0}}, ram[addr]} : {{BASE_BIT_WIDTH*2{1'b0}}, ram[addr+1], ram[addr]};
			2'b10 : q = addr2 ? (addr[0] ? {{BASE_BIT_WIDTH*3{1'b0}}, ram[addr]} : {{BASE_BIT_WIDTH*2{1'b0}}, ram[addr+1], ram[addr]}) : {{BASE_BIT_WIDTH{1'b0}}, ram[addr+2], ram[addr+1], ram[addr]};
			2'b11 : q = addr3 ? (addr2 ? (addr[0] ? {{BASE_BIT_WIDTH*3{1'b0}}, ram[addr]} : {{BASE_BIT_WIDTH*2{1'b0}}, ram[addr+1], ram[addr]}) : {{BASE_BIT_WIDTH{1'b0}}, ram[addr+2], ram[addr+1], ram[addr]}) : {ram[addr+3], ram[addr+2], ram[addr+1], ram[addr]};
			default: q = {BASE_BIT_WIDTH*4{1'bx}};
		endcase
	end
endmodule