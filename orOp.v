module orOp (
    input wire [7:0] A,
    input wire [7:0] B,
    output wire [7:0] Y
);
    
    or(Y[0], A[0], B[0]);
    or(Y[1], A[1], B[1]);
    or(Y[2], A[2], B[2]);
    or(Y[3], A[3], B[3]);
    or(Y[4], A[4], B[4]);
    or(Y[5], A[5], B[5]);
    or(Y[6], A[6], B[6]);
    or(Y[7], A[7], B[7]);


endmodule
