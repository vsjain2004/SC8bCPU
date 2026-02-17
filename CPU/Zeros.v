module Zeros #(parameter N = 31) (Z);
	output [N-1:0] Z;

	assign Z = {N{1'b0}};
endmodule