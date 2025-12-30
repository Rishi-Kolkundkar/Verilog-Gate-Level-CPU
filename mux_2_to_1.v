// Gate-level 2-to-1 multiplexer
module mux_2_to_1 #(parameter WIDTH = 8) (
    input  wire [WIDTH-1:0] In0,
    input  wire [WIDTH-1:0] In1,
    input  wire             Sel,
    output wire [WIDTH-1:0] Out
);

    wire nSel;
    not u_not(nSel, Sel);

    genvar i;
    generate
        for (i=0; i<WIDTH; i=i+1) begin : gen_mux
            wire a, b;
            and u_and0(a, In0[i], nSel); // In0 & ~Sel
            and u_and1(b, In1[i], Sel);  // In1 & Sel
            or  u_or(Out[i], a, b);      // Combine
        end
    endgenerate

endmodule
