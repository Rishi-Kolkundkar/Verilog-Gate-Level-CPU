module decoder3_8 ( 
    input wire A0,A1,A2,
    output wire [7:0] Y
);
    wire n0,n1,n2;
    not(n0,A0);
    not(n1,A1);
    not(n2,A2);

    and(Y[0],n0,n1,n2);
    and(Y[1],n2,n1,A0);
    and(Y[2],n2,A1,n0);
    and(Y[3],n2, A1, A0);
    and(Y[4],A2,n1,n0);
    and(Y[5],A2,n1,A0);
    and(Y[6],A2,A1,n0);
    and(Y[7],A2,A1,A0);




endmodule
