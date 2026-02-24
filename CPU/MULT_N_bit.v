module MULT_N_bit #(parameter N = 32) (X, Y, HiLo, Signed, Out);
    input [N-1:0] X, Y;
    input HiLo, Signed;
    output [N-1:0] Out;

    wire signed [N:0] X_ext;
    wire signed [N:0] Y_ext;

    assign X_ext = Signed ? {X[N-1], X} : {1'b0, X};
    assign Y_ext = Signed ? {Y[N-1], Y} : {1'b0, Y};

    wire signed [2*N+1:0] product;
    assign product = X_ext * Y_ext;

    assign Out = HiLo ? product[2*N-1:N] : product[N-1:0];

    // wire [2*N-1:0] P_unsigned;
    // assign P_unsigned = X * Y;

    // wire X_neg = Signed & X[N-1];
    // wire Y_neg = Signed & Y[N-1];

    // wire [2*N-1:0] correction_X = X_neg ? ({ {N{1'b0}}, Y } << N) : 0;
    // wire [2*N-1:0] correction_Y = Y_neg ? ({ {N{1'b0}}, X } << N) : 0;

    // wire [2*N-1:0] P_signed;

    // assign P_signed = P_unsigned
    //                 - correction_X
    //                 - correction_Y;

    // wire [2*N-1:0] P_final = Signed ? P_signed : P_unsigned;

    // assign Out = HiLo ? P_final[2*N-1:N]
    //                   : P_final[N-1:0];
endmodule