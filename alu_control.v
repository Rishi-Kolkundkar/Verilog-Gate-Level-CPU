module alu_control (
    input  wire [1:0] ALUOp,      // from main control unit
    input  wire [2:0] Funct,      // instr[2:0]
    output wire [2:0] ALUControl  // to ALU
);
    wire nALUOp0, nALUOp1;
    not (nALUOp0, ALUOp[0]);
    not (nALUOp1, ALUOp[1]);

    // Select signals
    wire selADD, selSUB, selRtype;
    and (selADD, nALUOp1, nALUOp0);      // ALUOp=00 → ADD
    and (selSUB, nALUOp1, ALUOp[0]);     // ALUOp=01 → SUB
    and (selRtype, ALUOp[1], nALUOp0);   // ALUOp=10 → R-type (use Funct)

    // Bit 0: (R ? Funct[0] : ADD:0, SUB:1)
    wire b0_r, b0_sub;
    and (b0_r,   selRtype, Funct[0]);
    // SUB forces bit0=1 → just selSUB
    buf (b0_sub, selSUB);
    or  (ALUControl[0], b0_r, b0_sub);

    // Bit 1: (R ? Funct[1] : ADD:1, SUB:1)
    wire b1_r, b1_add, b1_sub;
    and (b1_r,   selRtype, Funct[1]);
    buf (b1_add, selADD);  // ADD forces bit1=1
    buf (b1_sub, selSUB);  // SUB forces bit1=1
    or  (ALUControl[1], b1_r, b1_add, b1_sub);

    // Bit 2: (R ? Funct[2] : ADD:0, SUB:0)
    and (ALUControl[2], selRtype, Funct[2]); // constants are 0 so no extra term

endmodule
