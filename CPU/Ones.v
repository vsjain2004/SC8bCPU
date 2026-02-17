module Ones #(parameter N = 32) (O);
	output [N-1:0] O;

	assign O = {N{1'b1}};
endmodule