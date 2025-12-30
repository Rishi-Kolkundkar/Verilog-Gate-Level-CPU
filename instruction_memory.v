//Sample ROMs to test the project


//Program to calculate terms of the Fibonacci series

// module instruction_memory (
//     input  wire [7:0]  Address,
//     output reg  [15:0] Instruction
// );
//     always @(*) begin
//         case (Address >> 1)
//             8'd0: Instruction = 16'h8040; // addi r1, r0, 0
//             8'd1: Instruction = 16'h8081; // addi r2, r0, 1
//             8'd2: Instruction = 16'h810A; // addi r4, r0, 10
//             8'd3: Instruction = 16'hB105; // beq r4, r0, 5
//             8'd4: Instruction = 16'h029A; // add r3, r1, r2
//             8'd5: Instruction = 16'h040A; // add r1, r2, r0
//             8'd6: Instruction = 16'h0612; // add r2, r3, r0
//             8'd7: Instruction = 16'h893F; // addi r4, r4, -1
//             8'd8: Instruction = 16'h2006; // j 6
//             8'd9: Instruction = 16'hF000; // halt
//             default: Instruction = 16'hF000;
//         endcase
//     end
// endmodule

//Calculates 5!
module instruction_memory (
    input  wire [7:0]  Address,
    output reg  [15:0] Instruction
);
    always @(*) begin
        case (Address >> 1)
            8'd0: Instruction = 16'h8041; // addi r1, r0, 1
            8'd1: Instruction = 16'h8085; // addi r2, r0, 5
            8'd2: Instruction = 16'h8141;
            8'd3: Instruction = 16'hBA88; // beq r2, r5, 8
            8'd4: Instruction = 16'h0222; // add r4, r1, r0
            8'd5: Instruction = 16'h84FF; // addi r3, r2, -1
            8'd6: Instruction = 16'hB0C3; // beq r3, r0, 3
            8'd7: Instruction = 16'h030A; // add r1, r1, r4
            8'd8: Instruction = 16'h86FF; // addi r3, r3, -1
            8'd9: Instruction = 16'h200C; // j 12
            8'd10: Instruction = 16'h0002; // add r0, r0, r0
            8'd11: Instruction = 16'h84BF; // addi r2, r2, -1
            8'd12: Instruction = 16'h2006; // j 6
            8'd13: Instruction = 16'hF000; // halt
            default: Instruction = 16'hF000;
        endcase
    end
endmodule

