module ALU (
    input  wire [7:0] A,
    input  wire [7:0] B,
    input  wire [2:0] ALUOp, 
    output wire [7:0] Result,
    output wire       Zero,
    output wire       Negative,
    output wire       Carry,
    output wire       Overflow
);

    // Intermediate results
    wire [8:0] add_result;
    wire [8:0] sub_result;
    wire [7:0] and_result;
    wire [7:0] or_result;
    wire       slt_result;
    wire [7:0] sll_result;
    wire [7:0] srl_result;
    wire [7:0] sra_result;

    // Units
    radder u_add (.A(A), .B(B), .Cin(1'b0), .Y(add_result));
    sub    u_sub (.A(A), .B(B), .Y(sub_result));
    op_and u_and (.A(A), .B(B), .Y(and_result));
    orOp   u_or  (.A(A), .B(B), .Y(or_result));
    slt_u  u_slt (.A(A), .B(B), .Y(slt_result));
    shift_left_logical u_sll (.A(A), .S(B[2:0]), .Y(sll_result));
    shift_right        u_srl (.A(A), .S(B[2:0]), .Y(srl_result));
    shift_right_arithmetic u_sra (.A(A), .S(B[2:0]), .Y(sra_result));

    // Pad SLT to 8 bits
    wire [7:0] slt_result_8bit = {7'b0, slt_result};

    // Final result bits via muxes
    wire [7:0] final_result_reg;

    genvar i;
    generate
        for (i=0; i<8; i=i+1) begin : alu_muxes
            MUX_8 alu_mux (
                {sra_result[i], srl_result[i], sll_result[i], slt_result_8bit[i],
                 sub_result[i], add_result[i], or_result[i], and_result[i]},
                ALUOp,
                final_result_reg[i]
            );
        end
    endgenerate

    assign Result = final_result_reg;

    // Flags
    nor(Zero, Result[0], Result[1], Result[2], Result[3],
               Result[4], Result[5], Result[6], Result[7]);

    // assign Zero = 1'b0;
    assign Negative = Result[7];

    // Carry flag
    wire carry_from_add = add_result[8];
    wire carry_from_sub = sub_result[8]; // borrow indicator

    MUX_8 carry_mux (
        {1'b0, 1'b0, 1'b0, 1'b0,
         carry_from_sub, carry_from_add, 1'b0, 1'b0},
        ALUOp,
        Carry
    );

    // Overflow flag
    wire sA = A[7];
    wire sB = B[7];
    wire sR = Result[7];

    wire add_overflow, sub_overflow;
    wire sA_eq_sB, sA_neq_sR, sA_neq_sB;

    xnor(sA_eq_sB, sA, sB);
    xor (sA_neq_sR, sA, sR);
    and (add_overflow, sA_eq_sB, sA_neq_sR);

    xor (sA_neq_sB, sA, sB);
    and (sub_overflow, sA_neq_sB, sA_neq_sR);

    MUX_8 overflow_mux (
        {1'b0, 1'b0, 1'b0, 1'b0,
         sub_overflow, add_overflow, 1'b0, 1'b0},
        ALUOp,
        Overflow
    );

endmodule
