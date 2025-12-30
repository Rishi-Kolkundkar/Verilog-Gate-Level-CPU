//This version of the testbench is for Diagnostic purposes to see the under the hood working of the CPU. 
// `timescale 1ns/1ps

// module cpu_tb;

//     reg CLK;
//     reg rst;

//     wire [7:0]  PC_out;
//     wire [15:0] Instruction_out;
//     wire [7:0]  ALUResult_out;
//     wire        RegWrite_out;
//     wire [2:0]  WriteRegAddr_out;
//     wire [7:0]  WriteRegData_out;

//     // Instantiate CPU
//     cpu DUT (
//         .CLK(CLK),
//         .rst(rst),
//         .PC_out(PC_out),
//         .Instruction_out(Instruction_out),
//         .ALUResult_out(ALUResult_out),
//         .RegWrite_out(RegWrite_out),
//         .WriteRegAddr_out(WriteRegAddr_out),
//         .WriteRegData_out(WriteRegData_out)
//     );

//     // Clock generation: 10ns period
//     initial begin
//         CLK = 0;
//         forever #5 CLK = ~CLK;
//     end

//     // Reset sequence
//     initial begin
//         rst = 1;
//         #10 rst = 0;  // release reset after 10ns
//     end

//     // Monitor outputs
//     initial begin
//         $monitor("Time=%0t | PC=%h | Instr=%h | ALU=%h | RegWrite=%b | WAddr=%d | WData=%h",
//                  $time, PC_out, Instruction_out, ALUResult_out,
//                  RegWrite_out, WriteRegAddr_out, WriteRegData_out);
//     end

//     // End simulation after 200ns
//     initial begin
//         #400 $finish;
//     end

// endmodule



//Simplified testbench
`timescale 1ns/1ps

module tb_cpu;

    // Inputs to the CPU
    reg CLK;
    reg rst;

    // Outputs from the CPU
    wire [7:0]  PC_out;
    wire [15:0] Instruction_out;
    wire [7:0]  ALUResult_out;
    wire        RegWrite_out;
    wire [2:0]  WriteRegAddr_out;
    wire [7:0]  WriteRegData_out;

    // Instantiate the CPU
    cpu uut (
        .CLK(CLK),
        .rst(rst),
        .PC_out(PC_out),
        .Instruction_out(Instruction_out),
        .ALUResult_out(ALUResult_out),
        .RegWrite_out(RegWrite_out),
        .WriteRegAddr_out(WriteRegAddr_out),
        .WriteRegData_out(WriteRegData_out)
    );

    // Clock generation
    initial begin
        CLK = 0;
        forever #10 CLK = ~CLK; // Create a clock with a 20ns period
    end

    // Simulation control and monitoring
    initial begin
        // 1. Apply reset
        rst = 1;
        #25; // Hold reset for a bit
        rst = 0;

        // 2. Monitor the outputs on every positive clock edge
        $monitor("Time=%0t | PC=%02h | Instr=%04h | ALU=%02h | RegWrite=%d | WAddr=%d | WData=%02h",
                 $time, PC_out, Instruction_out, ALUResult_out, RegWrite_out, WriteRegAddr_out, WriteRegData_out);

        // 3. Set a timeout to end the simulation
        #10000; // Run  (enough for the loop)
        $display("Simulation timed out. Finishing.");
        $finish;
    end

endmodule

