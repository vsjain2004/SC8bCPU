module MULT_N_bit #(parameter N = 32) (X, Y, Signed, OutHi, OutLo, Ov);
    input [N-1:0] X, Y;
    input Signed;
    output [N-1:0] OutHi, OutLo;
    output Ov;

    wire signed [N:0] X_ext;
    wire signed [N:0] Y_ext;

    assign X_ext = Signed ? {X[N-1], X} : {1'b0, X};
    assign Y_ext = Signed ? {Y[N-1], Y} : {1'b0, Y};

    assign Ov = (X[N-1] & (~|X[N-2:0]) & (&Y)) | (Y[N-1] & (~|Y[N-2:0]) & (&X));

    wire signed [2*N+1:0] product;
    assign product = X_ext * Y_ext;

    assign {OutHi, OutLo} = product[2*N-1:0];

    assign Ov = Signed ? (OutHi != {N{OutLo[N-1]}}) : (|OutHi);
endmodule