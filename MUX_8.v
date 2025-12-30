module MUX_8 (
    input wire [7:0] A,
    input wire [2:0] S,
    output wire Y
);

    wire ns0;
    not(ns0,S[0]);

    wire ns1;
    not(ns1,S[1]);

    wire ns2;
    not(ns2,S[2]);

    wire r0,r1,r2,r3,r4,r5,r6,r7;

    and(r0,ns0,ns1,ns2,A[0]);
    and(r1,S[0],ns1,ns2,A[1]);
    and(r2,ns0,S[1],ns2,A[2]);
    and(r3,S[0],S[1],ns2,A[3]);
    and(r4,ns0,ns1,S[2],A[4]);
    and(r5,S[0],ns1,S[2],A[5]);
    and(r6,ns0,S[1],S[2],A[6]);
    and(r7,S[0],S[1],S[2],A[7]);

    or(Y,r0,r1,r2,r3,r4,r5,r6,r7);

endmodule
