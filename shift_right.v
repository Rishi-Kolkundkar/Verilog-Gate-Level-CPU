// module shift_right (
//     input  wire [7:0] A,
//     input  wire [2:0] S,
//     output wire [7:0] Y
// );
//     // Each Y[i] = A[i+S] if valid, else 0
//     MUX_8 MUX_80 ({A[0], A[1], A[2], A[3], A[4], A[5], A[6], A[7]}, S, Y[0]);
//     MUX_8 MUX_81 ({A[1], A[2], A[3], A[4], A[5], A[6], A[7], 1'b0}, S, Y[1]);
//     MUX_8 MUX_82 ({A[2], A[3], A[4], A[5], A[6], A[7], 1'b0, 1'b0}, S, Y[2]);
//     MUX_8 MUX_83 ({A[3], A[4], A[5], A[6], A[7], 1'b0, 1'b0, 1'b0}, S, Y[3]);
//     MUX_8 MUX_84 ({A[4], A[5], A[6], A[7], 1'b0, 1'b0, 1'b0, 1'b0}, S, Y[4]);
//     MUX_8 MUX_85 ({A[5], A[6], A[7], 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}, S, Y[5]);
//     MUX_8 MUX_86 ({A[6], A[7], 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}, S, Y[6]);
//     MUX_8 MUX_87 ({A[7], 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}, S, Y[7]);
// endmodule

module shift_right (
    input  wire [7:0] A,
    input  wire [2:0] S,
    output wire [7:0] Y
);
    assign Y = A >> S;
endmodule
