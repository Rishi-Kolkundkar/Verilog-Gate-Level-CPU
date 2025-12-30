module cpu (
    input wire CLK,
    input wire rst,

    output wire [7:0]  PC_out,
    output wire [15:0] Instruction_out,
    output wire [7:0]  ALUResult_out,
    output wire        RegWrite_out,
    output wire [2:0]  WriteRegAddr_out,
    output wire [7:0]  WriteRegData_out
);

    wire PC_src,Jump_sgn;
    wire [7:0] PC_added2, PC_added2mod, PC_curr, PC_curr_out,PC_curr_final,jump_add;
    wire [15:0] instr_out;

    assign jump_add = instr_out[7:0];
    
    mux_2_to_1 #(.WIDTH(8)) PC_select (
    .In0(PC_added2),
    .In1(PC_added2mod),
    .Sel(PC_src),
    .Out(PC_curr)
    );

    mux_2_to_1 #(.WIDTH(8)) PC_select_jump (
    .In0(PC_curr),
    .In1(jump_add),
    .Sel(Jump_sgn),
    .Out(PC_curr_final)
    );



    eight_bit_register PC_prop (
        .AR(rst),
        .D(PC_curr_final),
        .CLK(CLK),
        .EN(1'b1),
        .Q(PC_curr_out)
    );

    PC_adder PC1 (
        .PC_in(PC_curr_out),
        .PC_out(PC_added2)
    );

    instruction_memory  ROM1 (
        .Address(PC_curr_out),
        .Instruction(instr_out)
    );

    //CU input
    wire [3:0] op_code = instr_out[15:12];
    wire [2:0] funct_code = instr_out[2:0];

    //CU output
    wire mem_reg,mem_w,mem_r,brnch, ALU_src,dest_reg, reg_w;
    wire [2:0] ALU_ctrl;
    wire [1:0] ALU_temp;

    control_unit CU_main (
        .Opcode(op_code),
        .RegWrite(reg_w),
        .RegDst(dest_reg),
        .ALUSrc(ALU_src),
        .MemtoReg(mem_reg),
        .MemRead(mem_r),
        .MemWrite(mem_w),
        .Branch(brnch),
        .Jump(Jump_sgn),
        .ALUOp(ALU_temp)
    );

    alu_control ALU_GEN (
        .ALUOp(ALU_temp),
        .Funct(funct_code),
        .ALUControl(ALU_ctrl)
    );



    //Reg file input
    wire [2:0] read1 = instr_out[11:9];
    wire [2:0] read2 = instr_out[8:6];
    wire [7:0] result;
    wire [2:0] write_add;

    wire [2:0] temp1 = instr_out[8:6];
    wire [2:0] temp2 = instr_out[5:3];

    //Reg file output
    wire [7:0] read_out1, read_out2;

    mux_2_to_1 #(.WIDTH(3)) Write_reg_sel (
    .In0(temp1),
    .In1(temp2),
    .Sel(dest_reg),
    .Out(write_add)
    );

    Register_File Reg_File (
        .read_reg1(read1),
        .read_reg2(read2),
        .write_reg(write_add),
        .write_data(result),
        .CLK(CLK),
        .write_enable(reg_w),
        .read_data1(read_out1),
        .read_data2(read_out2)
    );

    wire [7:0] A_in,B_in;

    assign A_in = read_out1;

    wire [5:0] sgin = instr_out[5:0];
    
    
    PC_Branch_Adder PCBA (
        .PC_in_add2(PC_added2),
        .Offset(sgin),
        .Branch_PC_out(PC_added2mod)
    );

    wire [7:0] sgout;
    sign_extend temporary (
        .In(sgin),
        .Out(sgout)
    );

    


    mux_2_to_1 #(.WIDTH(8)) ALU_B_sel (
    .In0(read_out2),
    .In1(sgout),
    .Sel(ALU_src),
    .Out(B_in)
    );

    
    wire  [7:0] ALU_out; //ALU Output
    wire zero_flag;
    ALU alu_main (
        .A(A_in),
        .B(B_in),
        .ALUOp(ALU_ctrl),
        .Result(ALU_out),
        .Zero(zero_flag),
        .Negative(),
        .Carry(),
        .Overflow()
    );

    and (PC_src,zero_flag,brnch);

    wire [7:0] RAM_out;
    data_memory RAM_Main (
        .Address(ALU_out),
        .WriteData(read_out2),
        .CLK(CLK),
        .MemWrite(mem_w),
        .MemRead(mem_r),
        .ReadData(RAM_out)
    );

    mux_2_to_1 #(.WIDTH(8)) WriteData_reg_sel (
    .In0(ALU_out),
    .In1(RAM_out),
    .Sel(mem_reg),
    .Out(result)
    );

    assign PC_out           = PC_curr_out;
    assign Instruction_out  = instr_out;
    assign ALUResult_out    = ALU_out;
    assign RegWrite_out     = reg_w;
    assign WriteRegAddr_out = write_add;
    assign WriteRegData_out = result;



endmodule
