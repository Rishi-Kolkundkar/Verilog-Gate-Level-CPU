module PC_adder (
    input wire [7:0] PC_in,
    output wire [7:0] PC_out
);  
    wire [8:0] temp;
    radder u_adder (
        .A(PC_in),
        .B(8'b00000010),
        .Cin(1'b0),
        .Y(temp)
    );
    
    assign PC_out = temp[7:0];
    


endmodule
