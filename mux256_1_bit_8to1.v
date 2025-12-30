module mux256_1_bit_8to1 (
    input  wire [255:0] D,     // 256 data inputs
    input  wire [7:0]   Addr,  // Address
    output wire         Y
);
    
    
    wire [31:0] s0;
    genvar g0;
    generate
        for (g0=0; g0<32; g0=g0+1) begin : stage0
            wire [7:0] grp;
            assign grp = { D[8*g0+7], D[8*g0+6], D[8*g0+5], D[8*g0+4],
                           D[8*g0+3], D[8*g0+2], D[8*g0+1], D[8*g0+0] };
            MUX_8 m (.A(grp), .S(Addr[2:0]), .Y(s0[g0]));
        end
    endgenerate

    
    wire [3:0] s1;
    genvar g1;
    generate
        for (g1=0; g1<4; g1=g1+1) begin : stage1
            wire [7:0] grp;
            assign grp = { s0[8*g1+7], s0[8*g1+6], s0[8*g1+5], s0[8*g1+4],
                           s0[8*g1+3], s0[8*g1+2], s0[8*g1+1], s0[8*g1+0] };
            MUX_8 m (.A(grp), .S(Addr[5:3]), .Y(s1[g1]));
        end
    endgenerate


    wire [7:0] grp_last;
    assign grp_last = { 4'b0000, s1[3], s1[2], s1[1], s1[0] };
    MUX_8 mlast (.A(grp_last), .S({1'b0, Addr[7:6]}), .Y(Y));
endmodule
