module eight_bit_register (
    input wire AR,   // Asynchronous Reset input (active-high)
    input wire[7:0] D,    // Data input
    input wire CLK,  // Clock input
    input wire EN,   //Enable
    output wire [7:0] Q    // Output
);


    //LSB FF
    d_flip_flop d0(
        .D(D[0]),
        .CLK(CLK),
        .EN(EN),
        .AR(AR),
        .Q(Q[0])
    );

    
    d_flip_flop d1(
        .D(D[1]),
        .CLK(CLK),
        .EN(EN),
        .AR(AR),
        .Q(Q[1])
    );


    d_flip_flop d2(
        .D(D[2]),
        .CLK(CLK),
        .EN(EN),
        .AR(AR),
        .Q(Q[2])
    );

    d_flip_flop d3(
        .D(D[3]),
        .CLK(CLK),
        .EN(EN),
        .AR(AR),
        .Q(Q[3])
    );

    d_flip_flop d4(
        .D(D[4]),
        .CLK(CLK),
        .EN(EN),
        .AR(AR),
        .Q(Q[4])
    );

    d_flip_flop d5(
        .D(D[5]),
        .CLK(CLK),
        .EN(EN),
        .AR(AR),
        .Q(Q[5])
    );


    d_flip_flop d6(
        .D(D[6]),
        .CLK(CLK),
        .EN(EN),
        .AR(AR),
        .Q(Q[6])
    );

    //MSB FF
    d_flip_flop d7(
        .D(D[7]),
        .CLK(CLK),
        .EN(EN),
        .AR(AR),
        .Q(Q[7])
    );

endmodule
