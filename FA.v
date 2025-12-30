//Full Adder Module
module FA (
    input wire Cin,
    input wire A,
    input wire B,
    output wire S,
    output wire Cout
);
    xor (S, Cin, A, B);

    wire a1,a2,a3;

    and (a1,A,B);
    and(a2,B,Cin);
    and (a3,A,Cin );

    or(Cout,a1,a2,a3);
    



endmodule

