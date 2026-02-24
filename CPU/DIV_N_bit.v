module DIV_N_bit #(parameter N = 32) (X, Y, QuRe, Signed, Out);
    input [N-1:0] X, Y;
    input QuRe, Signed;
    output [N-1:0] Out;

    wire signed [N-1:0] X_signed = X;
    wire signed [N-1:0] Y_signed = Y;

    assign Out = Signed ? (QuRe ? (X_signed % Y_signed) : (X_signed / Y_signed)) : (QuRe ? (X % Y) : (X / Y));
endmodule