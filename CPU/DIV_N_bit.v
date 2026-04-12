module DIV_N_bit #(parameter N = 32) (
    input [N-1:0] X,
    input [N-1:0] Y,
    input Signed,
    output D0,
    output Ov,
    output reg [N-1:0] OutQ,
    output reg [N-1:0] OutR
);
    

    reg signed [N-1:0] X_signed;
    reg signed [N-1:0] Y_signed;
    wire [N-1:0] Q, R;

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
                    X_signed = ~X + 1;
                    Y_signed = Y;
                    OutR = ~|R ? R: (Y - R);
                    OutQ = ~|R ? (~Q + 1) : ~Q;
                end
                2'b10 : begin
                    X_signed = X;
                    Y_signed = ~Y + 1;
                    OutR = ~|R ? R : Y_signed - R;
                    OutQ = ~|R ? (~Q + 1) : ~Q;
                end
                2'b11 : begin
                    X_signed = ~X + 1;
                    Y_signed = ~Y + 1;
                    OutQ = ~|R ? Q : Q + 1;
                    OutR = ~|R ? R : Y_signed - R;
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