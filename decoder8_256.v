module decoder8_256 (
    input  wire [7:0] A,
    output wire [255:0] Y
);

    // Inverted inputs
    wire [7:0] nA;
    genvar i;
    generate
        for (i=0; i<8; i=i+1) begin : invert_inputs
            not g_not(nA[i], A[i]);
        end
    endgenerate

    // Generate all 256 outputs
    genvar j;
    generate
        for (j=0; j<256; j=j+1) begin : gen_outputs
            wire [7:0] sel_bits;

            // For each input bit, select inverted or non-inverted using MUX_2
            MUX_2 mux0 (.A({nA[0], A[0]}), .S(j[0]), .Y(sel_bits[0]));
            MUX_2 mux1 (.A({nA[1], A[1]}), .S(j[1]), .Y(sel_bits[1]));
            MUX_2 mux2 (.A({nA[2], A[2]}), .S(j[2]), .Y(sel_bits[2]));
            MUX_2 mux3 (.A({nA[3], A[3]}), .S(j[3]), .Y(sel_bits[3]));
            MUX_2 mux4 (.A({nA[4], A[4]}), .S(j[4]), .Y(sel_bits[4]));
            MUX_2 mux5 (.A({nA[5], A[5]}), .S(j[5]), .Y(sel_bits[5]));
            MUX_2 mux6 (.A({nA[6], A[6]}), .S(j[6]), .Y(sel_bits[6]));
            MUX_2 mux7 (.A({nA[7], A[7]}), .S(j[7]), .Y(sel_bits[7]));

            // AND all 8 selected bits together to form Y[j]
            and g_and(Y[j], sel_bits[0], sel_bits[1], sel_bits[2],
                               sel_bits[3], sel_bits[4], sel_bits[5],
                               sel_bits[6], sel_bits[7]);
        end
    endgenerate

endmodule
