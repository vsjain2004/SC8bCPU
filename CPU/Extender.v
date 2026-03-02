module Extender(IN, Sign, Out);
    input [15:0] IN;
    input Sign;
    output [31:0] Out;

    assign Out = Sign ? {16{IN[15]}, IN} : {16'b0, IN};
endmodule