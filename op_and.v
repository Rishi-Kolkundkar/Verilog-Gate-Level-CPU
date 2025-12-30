module op_and (
    input wire [7:0] A,
    input wire [7:0] B,
    output wire [7:0] Y
);
    
    and(Y[0], A[0], B[0]);
    and(Y[1], A[1], B[1]);
    and(Y[2], A[2], B[2]);
    and(Y[3], A[3], B[3]);
    and(Y[4], A[4], B[4]);
    and(Y[5], A[5], B[5]);
    and(Y[6], A[6], B[6]);
    and(Y[7], A[7], B[7]);


endmodule
