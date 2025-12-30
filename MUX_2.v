module MUX_2 (
    input wire [1:0] A,
    input wire S,
    output wire Y
);
    wire ns0;
    not(ns0,S);


    wire r0,r1;

    and(r0,ns0,A[0]);
    and(r1,S,A[1]);
    

    or(Y,r0,r1);

endmodule
