// module control_unit (
//     input  wire [3:0] Opcode,
//     output wire       RegWrite,
//     output wire       RegDst,
//     output wire       ALUSrc,
//     output wire       MemtoReg,
//     output wire       MemRead,
//     output wire       MemWrite,
//     output wire       Branch,
//     output wire       Jump,
//     output wire [1:0] ALUOp
// );

//     // Invert opcode bits
//     wire nO0, nO1, nO2, nO3;
//     not (nO0, Opcode[0]);
//     not (nO1, Opcode[1]);
//     not (nO2, Opcode[2]);
//     not (nO3, Opcode[3]);

//     // One-hot opcode decoding
//     wire op_R, op_J, op_ADDI, op_BEQ, op_LW, op_SW;

//     // R-type: 0000
//     and (op_R, nO3, nO2, nO1, nO0);

//     // J-type: 0010
//     wire nO3b, nO2b, nO0b;
//     not (nO3b, Opcode[3]);
//     not (nO2b, Opcode[2]);
//     not (nO0b, Opcode[0]);
//     and (op_J, nO3b, nO2b, Opcode[1], nO0b);

//     // ADDI: 1000
//     wire nO2c, nO1c, nO0c;
//     not (nO2c, Opcode[2]);
//     not (nO1c, Opcode[1]);
//     not (nO0c, Opcode[0]);
//     and (op_ADDI, Opcode[3], nO2c, nO1c, nO0c);

//     // BEQ: 1011
//     wire nO2d;
//     not (nO2d, Opcode[2]);
//     and (op_BEQ, Opcode[3], nO2d, Opcode[1], Opcode[0]);

//     // LW: 1001
//     wire nO2e, nO1e;
//     not (nO2e, Opcode[2]);
//     not (nO1e, Opcode[1]);
//     and (op_LW, Opcode[3], nO2e, nO1e, Opcode[0]);

//     // SW: 1010
//     wire nO2f, nO0f;
//     not (nO2f, Opcode[2]);
//     not (nO0f, Opcode[0]);
//     and (op_SW, Opcode[3], nO2f, Opcode[1], nO0f);

//     // --- Control signals ---
//     or  (RegWrite, op_R, op_ADDI, op_LW);
//     buf (RegDst, op_R); // R-type uses rd
//     or  (ALUSrc, op_ADDI, op_LW, op_SW);
//     buf (MemtoReg, op_LW);
//     buf (MemRead, op_LW);
//     buf (MemWrite, op_SW);
//     buf (Branch, op_BEQ);
//     buf (Jump, op_J);

//     // ALUOp[1:0]
//     // ALUOp = 00 → lw/sw/addi
//     // ALUOp = 01 → beq
//     // ALUOp = 10 → R-type
//     wire aluop0, aluop1;
//     buf (aluop0, op_BEQ); // ALUOp[0] = 1 for beq
//     buf (aluop1, op_R);   // ALUOp[1] = 1 for R-type
//     assign ALUOp = {aluop1, aluop0};

// endmodule

module control_unit (
    input  wire [3:0] Opcode,
    output wire       RegWrite,
    output wire       RegDst,
    output wire       ALUSrc,
    output wire       MemtoReg,
    output wire       MemRead,
    output wire       MemWrite,
    output wire       Branch,
    output wire       Jump,
    output wire [1:0] ALUOp
);

    // Invert opcode bits
    wire nO0, nO1, nO2, nO3;
    not (nO0, Opcode[0]);
    not (nO1, Opcode[1]);
    not (nO2, Opcode[2]);
    not (nO3, Opcode[3]);

    // One-hot opcode decoding
    wire op_R, op_J, op_ADDI, op_BEQ, op_LW, op_SW;

    // R-type: 0000
    and (op_R, nO3, nO2, nO1, nO0);

    // J-type: 0010
    wire nO3b, nO2b, nO0b;
    not (nO3b, Opcode[3]);
    not (nO2b, Opcode[2]);
    not (nO0b, Opcode[0]);
    and (op_J, nO3b, nO2b, Opcode[1], nO0b);

    // ADDI: 1000
    wire nO2c, nO1c, nO0c;
    not (nO2c, Opcode[2]);
    not (nO1c, Opcode[1]);
    not (nO0c, Opcode[0]);
    and (op_ADDI, Opcode[3], nO2c, nO1c, nO0c);

    // BEQ: 1011
    wire nO2d;
    not (nO2d, Opcode[2]);
    and (op_BEQ, Opcode[3], nO2d, Opcode[1], Opcode[0]);

    // LW: 1001
    wire nO2e, nO1e;
    not (nO2e, Opcode[2]);
    not (nO1e, Opcode[1]);
    and (op_LW, Opcode[3], nO2e, nO1e, Opcode[0]);

    // SW: 1010
    wire nO2f, nO0f;
    not (nO2f, Opcode[2]);
    not (nO0f, Opcode[0]);
    and (op_SW, Opcode[3], nO2f, Opcode[1], nO0f);

    // --- Control signals ---
    wire regwrite_raw;
    or  (regwrite_raw, op_R, op_ADDI, op_LW);
    buf (RegDst, op_R);
    or  (ALUSrc, op_ADDI, op_LW, op_SW);
    buf (MemtoReg, op_LW);
    buf (MemRead, op_LW);
    buf (MemWrite, op_SW);
    buf (Branch, op_BEQ);
    buf (Jump, op_J);

    // ALUOp[1:0]
    wire aluop0, aluop1;
    buf (aluop0, op_BEQ); // ALUOp[0] = 1 for beq
    buf (aluop1, op_R);   // ALUOp[1] = 1 for R-type
    assign ALUOp = {aluop1, aluop0};

    // --- Safe default gating ---
    wire any_match;
    or (any_match, op_R, op_J, op_ADDI, op_BEQ, op_LW, op_SW);
    and (RegWrite, regwrite_raw, any_match);

endmodule
