module MULT_N_bit #(parameter N = 32) (
    input wire [N-1:0] X, Y,
    input wire Signed,
    output wire [N-1:0] OutHi, OutLo,
    output wire Ov
);
    

    wire signed [N:0] X_ext;
    wire signed [N:0] Y_ext;

    assign X_ext = Signed ? {X[N-1], X} : {1'b0, X};
    assign Y_ext = Signed ? {Y[N-1], Y} : {1'b0, Y};

    wire signed [2*N+1:0] product;
    assign product = X_ext * Y_ext;

    assign {OutHi, OutLo} = product[2*N-1:0];

    assign Ov = Signed ? (OutHi != {N{OutLo[N-1]}}) : (|OutHi);
endmodule