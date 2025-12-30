module radder (
    input  wire [7:0] A,
    input  wire [7:0] B,
    input  wire       Cin,   
    output wire [8:0] Y
);

    wire a1,a2,a3,a4,a5,a6,a7;

    FA add1(.A(A[0]), .B(B[0]), .Cin(Cin), .S(Y[0]), .Cout(a1));
    FA add2(.A(A[1]), .B(B[1]), .Cin(a1),  .S(Y[1]), .Cout(a2));
    FA add3(.A(A[2]), .B(B[2]), .Cin(a2),  .S(Y[2]), .Cout(a3));
    FA add4(.A(A[3]), .B(B[3]), .Cin(a3),  .S(Y[3]), .Cout(a4));
    FA add5(.A(A[4]), .B(B[4]), .Cin(a4),  .S(Y[4]), .Cout(a5));
    FA add6(.A(A[5]), .B(B[5]), .Cin(a5),  .S(Y[5]), .Cout(a6));
    FA add7(.A(A[6]), .B(B[6]), .Cin(a6),  .S(Y[6]), .Cout(a7));
    FA add8(.A(A[7]), .B(B[7]), .Cin(a7),  .S(Y[7]), .Cout(Y[8]));

endmodule
