//Bitwise left shift

module shift_left #(parameter WIDTH=8) (
    input  wire [WIDTH-1:0] In,
    output wire [WIDTH-1:0] Out
);
    assign Out = { In[WIDTH-2:0], 1'b0 };
endmodule

