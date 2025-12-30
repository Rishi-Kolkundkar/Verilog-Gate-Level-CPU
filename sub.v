module sub (
    input  wire [7:0] A,
    input  wire [7:0] B,
    output wire [8:0] Y
);
    wire [7:0] B_not = ~B;

    // Single ripple adder with Cin=1
    radder add_stage (
        .A(A),
        .B(B_not),
        .Cin(1'b1),
        .Y(Y)
    );
endmodule
