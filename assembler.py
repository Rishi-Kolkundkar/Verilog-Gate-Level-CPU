import sys

def assemble(instruction):
    """
    Assembles a single line of MyCPU-16 assembly into a 16-bit hex code.
    This version uses only numerical inputs for addresses and immediates.
    """
    opcodes = {
        'add':  '0000', 'sub':  '0000', 'slt':  '0000', 'and': '0000', 'or': '0000',
        'addi': '1000', 'lw':   '1001', 'sw':   '1010',
        'beq':  '1011', 'j':    '0010', 'halt': '1111'
    }
    functs = {'add': '010', 'sub': '011', 'slt': '100', 'and': '000', 'or': '001'}

    parts = instruction.replace(',', ' ').split()
    mnemonic = parts[0].lower()

    if mnemonic == 'halt': return "F000"
    if mnemonic == 'nop': return "0001"

    if mnemonic in functs: # R-Type
        rd = format(int(parts[1][1:]), '03b')
        rs = format(int(parts[2][1:]), '03b')
        rt = format(int(parts[3][1:]), '03b')
        binary = opcodes[mnemonic] + rs + rt + rd + functs[mnemonic]
    elif mnemonic in ['addi', 'beq']: # I-Type
        rt = format(int(parts[1][1:]), '03b')
        rs = format(int(parts[2][1:]), '03b')
        imm_val = int(parts[3])
        imm_bin = format(imm_val & 0x3F, '06b') # Handles two's complement via bitwise AND
        binary = opcodes[mnemonic] + rs + rt + imm_bin
    elif mnemonic == 'j': # J-Type
        target_addr = int(parts[1], 0) # Handles hex (0x) or decimal
        addr_bin = format(target_addr, '08b')
        binary = opcodes[mnemonic] + "0000" + addr_bin
    else:
        raise ValueError(f"Unknown mnemonic or format for '{mnemonic}'")

    return hex(int(binary, 2))[2:].upper().zfill(4)

def get_validated_input(prompt, min_val, max_val, base=10):
    """Helper function to get a validated integer from the user."""
    while True:
        try:
            val_str = input(prompt)
            val = int(val_str, base)
            if min_val <= val <= max_val:
                return val
            else:
                print(f"  Error: Value must be between {min_val} and {max_val}.")
        except ValueError:
            print(f"  Error: Please enter a valid number in base {base}.")

def generate_verilog(program_lines, filename="instruction_memory.v"):
    """Generates a Verilog module from a list of assembled instructions."""
    try:
        with open(filename, 'a') as f:
            f.write("module instruction_memory (\n")
            f.write("    input  wire [7:0]  Address,\n")
            f.write("    output reg  [15:0] Instruction\n")
            f.write(");\n")
            f.write("    always @(*) begin\n")
            f.write("        case (Address >> 1)\n")
            for i, line in enumerate(program_lines):
                hex_code = assemble(line)
                f.write(f"            8'd{i}: Instruction = 16'h{hex_code}; // {line}\n")
            f.write("            default: Instruction = 16'hF000;\n")
            f.write("        endcase\n")
            f.write("    end\n")
            f.write("endmodule\n")
        print(f"\n Success! Verilog module written to '{filename}'.")
    except Exception as e:
        print(f"\n---FATAL ERROR---\nCould not generate Verilog file. Reason: {e}")

def main():
    program_lines = []
    print("--- MyCPU-16 Interactive Assembler (Simple Version) ---")
    while True:
       
        print("\n" + "="*30)
        print("Current Program:")
        if not program_lines: print("  (empty)")
        else:
            for i, line in enumerate(program_lines): print(f"  {i:2d}: {line}")
        print("="*30)
        print("\nChoose an action:")
        print("  1. R-Type (add, sub, slt, etc.)")
        print("  2. I-Type (addi, beq)")
        print("  3. J-Type (j)")
        print("  4. Add 'nop' or 'halt'")
        print("\n  0. Finish and Generate Verilog File")

        choice = input("Enter your choice: ")
        
        if choice == '1': # R-Type
            mnemonic = input("Mnemonic (add, sub, slt, and, or): ").lower()
            if mnemonic not in ['add', 'sub', 'slt', 'and', 'or']: continue
            rd = get_validated_input("Rd (0-7): ", 0, 7)
            rs = get_validated_input("Rs (0-7): ", 0, 7)
            rt = get_validated_input("Rt (0-7): ", 0, 7)
            program_lines.append(f"{mnemonic} r{rd}, r{rs}, r{rt}")
        elif choice == '2': # I-Type
            mnemonic = input("Mnemonic (addi, beq): ").lower()
            if mnemonic not in ['addi', 'beq']: continue
            rt = get_validated_input("Rt (0-7): ", 0, 7)
            rs = get_validated_input("Rs (0-7): ", 0, 7)
            if mnemonic == 'beq':
                imm = get_validated_input("Branch Offset (-32 to 31): ", -32, 31)
            else: # addi
                imm = get_validated_input("Immediate Value (-32 to 31): ", -32, 31)
            program_lines.append(f"{mnemonic} r{rt}, r{rs}, {imm}")
        elif choice == '3': # J-Type
            addr = get_validated_input("Jump Address (0-255): ", 0, 255)
            program_lines.append(f"j {addr}")
        elif choice == '4':
            cmd = input("Command (nop, halt): ").lower()
            if cmd in ['nop', 'halt']: program_lines.append(cmd)
        elif choice == '0':
            generate_verilog(program_lines)
            sys.exit()
        else:
            print("\nInvalid choice.")

if __name__ == "__main__":
    main()