module DIV_N_bit #(parameter N = 32) (X, Y, Signed, OutQ, OutR, D0, Ov);
    input [N-1:0] X, Y;
    input Signed;
    output [N-1:0] OutQ, OutR;
    output D0, Ov;

    wire signed [N-1:0] X_signed = X;
    wire signed [N-1:0] Y_signed = Y;

    assign D0 = ~| Y;
    assign Ov = Signed & X[N-1] & (~|X[N-2:0]) & (&Y);

    assign OutQ = D0 ? (Signed ? (X[N-1] ? {1'b1, {N-1{1'b0}}} : {1'b0, {N-1{1'b1}}}) : {N{1'b1}}) 
                    : (Signed ? (Ov ? {1'b1, {N-1{1'b0}}} : (X_signed / Y_signed)) : (X / Y));
    assign OutR = D0 ? {N{1'b0}} : (Signed ? (Ov ? {N{1'b0}} : (X_signed % Y_signed)) : (X % Y));
endmodule