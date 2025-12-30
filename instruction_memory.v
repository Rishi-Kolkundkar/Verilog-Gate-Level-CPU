// module instruction_memory (
//     input  wire [7:0]  Address,
//     output reg  [15:0] Instruction
// );
//     always @(*) begin
//         case (Address >> 1)
//             // --- Initialization ---
//             8'd0:  Instruction = 16'h8041; // 0x00: addi r1, r0, 1  (Result = 1)
//             8'd1:  Instruction = 16'h8085; // 0x02: addi r2, r0, 5  (n = 5)
//             8'd2:  Instruction = 16'h83C1; // 0x04: addi r7, r0, 1  (Constant 1 in R7)

//             // --- Outer Loop: Check if R2 <= 1 ---
//             8'd3:  Instruction = 16'hB5C8; // 0x06: beq r2, r7, 8   (If n == 1, jump 8 to Halt at 0x18)

//             // --- Setup Multiplication: R1 = R1 * R2 ---
//             // We multiply by adding R1 to itself (R2-1) times.
//             8'd4:  Instruction = 16'h0222; // 0x08: add r4, r1, r0  (R4 = current result)
//             8'd5:  Instruction = 16'h84FF; // 0x0A: addi r3, r2, -1 (R3 = multiplier - 1)

//             // --- Inner Loop: Repeated Addition ---
//             8'd6:  Instruction = 16'hB603; // PC=0x0C: beq r3, r0, 3 (Jumps to PC 0x14)
//             8'd7:  Instruction = 16'h028a; // PC=0x0E: add r1, r1, r4
//             8'd8:  Instruction = 16'h86FF; // PC=0x10: addi r3, r3, -1
//             8'd9:  Instruction = 16'h200C; // PC=0x12: j 0x0C
//             8'd10: Instruction = 16'h84FF; // PC=0x14: addi r2, r2, -1
//             8'd11: Instruction = 16'h2006; // 0x16: j 0x06          (Back to Outer Check)

//             // --- Finish ---
//             8'd12: Instruction = 16'hF000; // 0x18: halt           (0x78 should be in R1) [cite: 17, 18]

//             default: Instruction = 16'hF000;
//         endcase
//     end
// endmodule


//Fibonacci
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
