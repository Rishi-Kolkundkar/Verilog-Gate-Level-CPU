/*
 * Branch Target Address = (PC_in + 2) + (SignExtend(Offset) << 1)
 * Handles 8-bit inputs with 9-bit adder outputs.
 */
module PC_Branch_Adder (
    input  wire [7:0] PC_in_add2,
    input  wire [5:0] Offset,
    output wire [7:0] Branch_PC_out
);

    

    //Step 2: Process the Offset
    wire [7:0] sign_extended_offset;
    wire [7:0] shifted_offset;

    // 2a: Sign extend the 6-bit offset to 8 bits
    sign_extend u_sign_ext (
        .In(Offset),
        .Out(sign_extended_offset)
    );

    // 2b: Shift left by 1 (multiply by 2)
    shift_left u_shift (
        .In(sign_extended_offset),
        .Out(shifted_offset)
    );

    // --- Step 3: Final Addition ---
    wire [8:0] branch_sum;
    radder u_branch_adder (
        .A(PC_in_add2[7:0]),        // PC+2
        .B(shifted_offset),         // 8-bit offset
        .Cin(1'b0),        
        .Y(branch_sum)             // 9-bit output
    );

    // --- Step 4: Truncate to 8 bits for PC output ---
    assign Branch_PC_out = branch_sum[7:0];

endmodule
