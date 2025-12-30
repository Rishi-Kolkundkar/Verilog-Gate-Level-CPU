# MyCPU-16: A Custom 16-bit RISC CPU in Verilog



This repository documents the complete design, implementation, and programming of **MyCPU-16**, a custom 16-bit RISC (Reduced Instruction Set Computer) processor. Built from the ground up using Verilog, this project serves as a practical demonstration of fundamental computer architecture principles, from digital logic design to assembly-level programming.

The entire journey involved designing the Instruction Set Architecture (ISA), implementing the datapath and control unit, writing an assembler in Python, and successfully running a program on the final hardware simulation.

## Key Features

- **Custom 16-bit RISC ISA:** A simple yet powerful instruction set with R-Type, I-Type, and J-Type formats.
- **Gate-Level Verilog Design:** Implemented using basic logic gates and modules, providing a clear view of the hardware structure.
- **Single-Cycle Datapath:** A classic single-cycle processor design.
- **Custom Assembler:** A Python script is included to translate assembly code into the Verilog ROM module, streamlining the development process.
- **Proven in Simulation:** The CPU has been successfully tested with a factorial program (`5! = 120`), proving the correctness of the design and its ability to handle loops and conditional branches.

---

## Instruction Set Architecture (ISA)

The MyCPU-16 ISA is designed for simplicity and educational clarity. It features 8 general-purpose registers (`R0`-`R7`), where `R0` is hardwired to zero.

### Instruction Formats

| Type | 15-12 | 11-9 | 8-6 | 5-3 | 2-0 | Description |
| :--- |:---:|:---:|:---:|:---:|:---:|:--- |
| **R-Type** | `0000` | `Rs` | `Rt` | `Rd` |`Funct`| Register-to-register operations. |
| **I-Type** | Opcode | `Rs` | `Rt` | \multicolumn{2}{c|}{Immediate (6-bit)} | Operations with an immediate value. |
| **J-Type** | `0010` | \multicolumn{3}{c|}{Address (8-bit)} | `----` | Unconditional jumps. |

### Instruction Set

| Mnemonic | Opcode | Funct | Type | Syntax | Operation |
|:---|:---:|:---:|:---:|:---|:---|
| `add` | `0000` | `010` | R | `add rd, rs, rt` | `Rd = Rs + Rt` |
| `sub` | `0000` | `011` | R | `sub rd, rs, rt` | `Rd = Rs - Rt` |
| `slt` | `0000` | `100` | R | `slt rd, rs, rt` | `Rd = (Rs < Rt) ? 1 : 0` |
| `and` | `0000` | `000` | R | `and rd, rs, rt` | `Rd = Rs & Rt` |
| `or`  | `0000` | `001` | R | `or rd, rs, rt`  | `Rd = Rs \| Rt` |
| `addi`| `1000` | - | I | `addi rt, rs, imm` | `Rt = Rs + Imm` |
| `beq` | `1011` | - | I | `beq rs, rt, offset` | `if (Rs==Rt) PC += offset` |
| `j`   | `0010` | - | J | `j addr` | `PC = addr` |
| `halt`| `1111` | - | - | `halt` | Stops the simulation. |
| `nop` | `0000` | - | - | `nop` | No operation (`add r0,r0,r0`) |

---

## Project Structure

```
.
├── alu.v                 # Arithmetic Logic Unit
├── control_unit.v        # Main control logic, decodes opcodes
├── cpu.v                 # Top-level CPU module, connects all components
├── instruction_memory.v  # The program ROM, holds the machine code
├── tb_cpu.v              # The testbench for simulating the CPU
└── assembler.py          # Python script to assemble code into a Verilog ROM
```

---

## Getting Started

To compile and run a simulation of the CPU, you will need a Verilog simulator like [Icarus Verilog](http://iverilog.icarus.com/).

### 1. Compile the Verilog Source

Compile all the Verilog modules, including the testbench, into a single simulation file.

```sh
iverilog -o tb_cpu.vvp *.v
```

### 2. Run the Simulation

Execute the compiled file using `vvp`. The testbench will start the clock and print the state of the CPU at each cycle.

```sh
vvp tb_cpu.vvp
```

You will see output logs showing the Program Counter (PC), the instruction being executed, and the data being written to the register file, like this:

```
Time=25000 | PC=00 | Instr=8041 | ALU=01 | RegWrite=1 | WAddr=1 | WData=01
Time=30000 | PC=02 | Instr=8085 | ALU=05 | RegWrite=1 | WAddr=2 | WData=05
...
```

---

## Showcase: Factorial of 5

The `instruction_memory.v` file in this repository contains the machine code for a program that calculates the factorial of 5 (5! = 120). This program demonstrates the CPU's ability to handle loops, branches, and multi-step calculations.

Here is the assembly source code for the successful factorial program:

```assembly
// R1: FINAL_RESULT, R2: N, R3: MULT_COUNTER, R4: VALUE_TO_ADD, R5: ONE
// -- Initialization --
addi r1, r0, 1       // FINAL_RESULT = 1
addi r2, r0, 5       // N = 5
addi r5, r0, 1       // ONE = 1

// -- OUTER_LOOP (at PC=0x06) --
beq r2, r5, 8        // if (N == 1) branch to HALT (at PC=0x1A)

// -- Setup for Multiplication --
add r4, r1, r0       // VALUE_TO_ADD = FINAL_RESULT
addi r3, r2, -1      // MULT_COUNTER = N - 1

// -- INNER_LOOP (at PC=0x0C) --
beq r3, r0, 3        // if (MULT_COUNTER == 0) branch to END_INNER (at PC=0x14)
add r1, r1, r4       // FINAL_RESULT += VALUE_TO_ADD (Efficient accumulation)
addi r3, r3, -1      // MULT_COUNTER--
j 12                 // Jump back to INNER_LOOP

// -- END_INNER (at PC=0x14) --
nop                  // Pipeline stall

// -- END_OUTER --
addi r2, r2, -1      // N--
j 6                  // Jump back to OUTER_LOOP

// -- HALT (at PC=0x1A) --
halt
```

Running the simulation with this ROM will show the final value `0x78` (120) being written to `R1`.

## Development Tool: Python Assembler

An interactive Python script (`assembler.py`) was developed to make programming the CPU easier. It provides a menu-driven interface to write assembly instructions, which it then converts into a ready-to-use `instruction_memory.v` file, which essentially the ROM.

```python
# To run the assembler:
python3 assembler.py
```


