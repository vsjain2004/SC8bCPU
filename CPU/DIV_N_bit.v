module DIV_N_bit #(parameter N = 32) (X, Y, Signed, OutQ, OutR);
    input [N-1:0] X, Y;
    input Signed;
    output [N-1:0] OutQ, OutR;

    wire signed [N-1:0] X_signed = X;
    wire signed [N-1:0] Y_signed = Y;

    assign OutQ = Signed ? (X_signed / Y_Signed) : (X / Y);
    assign OutR = Signed ? (X_signed % Y_Signed) : (X % Y);
endmodule