module dl (
    output wire Q,
    output wire Qbar,
    input wire CLK,
    input wire D,
    input wire AR  // asynchronous reset (active high)
);
    wire nD, s, r;
    wire ar_n, s_masked, r_masked;
    wire q_int ;
    wire qbar_int;

    // Invert D and AR
    not (nD, D);
    not (ar_n, AR);


    and (s, nD, CLK);
    and (r, D, CLK);


    

   nor  (q_int, s, qbar_int, AR);
    nor (qbar_int, r, q_int,AR);

    
    buf  (Q, q_int);
    buf  (Qbar,qbar_int);
endmodule
