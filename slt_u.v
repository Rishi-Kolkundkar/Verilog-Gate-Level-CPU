module slt_u (
    input  wire [7:0] A,
    input  wire [7:0] B,
    output wire       Y
);
    wire [8:0] diff;

    sub u_sub (
        .A(A),
        .B(B),
        .Y(diff)
    );

    // SLT = 1 if A < B
    assign Y = diff[7];  // MSB of (A-B) in two's complement
endmodule

