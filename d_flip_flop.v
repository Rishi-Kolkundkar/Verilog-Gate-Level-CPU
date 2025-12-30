module d_flip_flop (
    input wire AR,   // Asynchronous Reset (active-high)
    input wire D,    // Data input
    input wire CLK,  // Clock input
    input wire EN,   // Enable input
    output wire Q    // Output
);
    wire nck, interq, d_final;


    // Invert clock for master latch
    not (nck, CLK);

    
    
    MUX_2 m1 ({D,Q},EN, d_final);

    // Master latch with AR
    dl master (
        .CLK(nck),
        .D(d_final),
        .AR(AR),
        .Q(interq),
        .Qbar() // unused
    );

    // Slave latch with AR
    dl slave (
        .CLK(CLK),
        .D(interq),
        .AR(AR),
        .Q(Q),
        .Qbar() // unused
    );
endmodule
