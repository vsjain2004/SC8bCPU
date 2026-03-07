module DIV_N_bit #(parameter N = 32) (X, Y, Signed, OutQ, OutR, D0, Ov);
    input [N-1:0] X, Y;
    input Signed;
    output reg [N-1:0] OutQ, OutR;
    output D0, Ov;

    reg signed [N-1:0] X_signed;
    reg signed [N-1:0] Y_signed;
    wire [N-1:0] Q, R;
    reg [N-1:0] Q_mid;
    integer i;
    reg found;

    assign D0 = ~| Y;
    assign Ov = Signed & X[N-1] & (~|X[N-2:0]) & (&Y);

    assign Q = D0 ? (Signed ? (X[N-1] ? {1'b1, {N-1{1'b0}}} : {1'b0, {N-1{1'b1}}}) : {N{1'b1}}) 
                    : (Signed ? (Ov ? {1'b1, {N-1{1'b0}}} : (X_signed / Y_signed)) : (X / Y));
    assign R = D0 ? {N{1'b0}} : (Signed ? (Ov ? {N{1'b0}} : (X_signed % Y_signed)) : (X % Y));

    always @* begin
        if(Signed) begin
            case ({Y[N-1], X[N-1]})
                2'b00 : begin
                    X_signed = X;
                    Y_signed = Y;
                    OutQ = Q;
                    OutR = R;
                end
                2'b01 : begin
                    X_signed = X;
                    Y_signed = Y;
                    OutR = R;
                    OutQ = Q;
                    found = 0;
                    for (i = N-1; i >= 0; i = i - 1) begin
                        if (!found) begin
                            if (Q[i])
                                found = 1;
                            else
                                OutQ[i] = 1'b1;
                        end
                    end
                end
                2'b10 : begin
                    X_signed = ~X + 1;
                    Y_signed = ~Y + 1;
                    OutR = R;
                    Q_mid = Q;
                    found = 0;
                    for (i = N-1; i >= 0; i = i - 1) begin
                        if (!found) begin
                            if (Q[i])
                                found = 1;
                            else
                                Q_mid[i] = 1'b1;
                        end
                    end
                    OutQ = Q_mid + 1;
                end
                2'b11 : begin
                    X_signed = ~X + 1;
                    Y_signed = ~Y + 1;
                    OutQ = Q + 1;
                    OutR = R;
                end
                default: ;
            endcase
        end
        else begin
            OutQ = Q;
            OutR = R;
        end
    end
endmodule