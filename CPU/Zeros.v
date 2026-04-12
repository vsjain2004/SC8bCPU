module Zeros #(parameter N = 32) (output [N-1:0] Z);
	
	assign Z = {N{1'b0}};
endmodule