module Register_File (
    input wire [2:0] read_reg1,
    input wire [2:0] read_reg2,
    input wire [2:0] write_reg,
    input wire [7:0] write_data,
    input wire CLK,
    input wire write_enable,
    output wire [7:0] read_data1,
    output wire [7:0] read_data2
);
    wire [7:0] Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7;
    wire [7:0] loc_enable;
    wire [7:0] local_enable;

    decoder3_8 reg_en_gen (
        .A0(write_reg[0]), 
        .A1(write_reg[1]),
        .A2(write_reg[2]),
        .Y(loc_enable)
    );
    assign local_enable[0] = 1'b0;
    and(local_enable[1], loc_enable[1],write_enable);
    and(local_enable[2], loc_enable[2],write_enable);
    and(local_enable[3], loc_enable[3],write_enable);
    and(local_enable[4], loc_enable[4],write_enable);
    and(local_enable[5], loc_enable[5],write_enable);
    and(local_enable[6], loc_enable[6],write_enable);
    and(local_enable[7], loc_enable[7],write_enable);


    assign Q0 = 8'b00000000;

    eight_bit_register R1 (
        .AR(1'b0),
        .D(write_data),
        .CLK(CLK),
        .EN(local_enable[1]),
        .Q(Q1)
    );

     eight_bit_register R2 (
        .AR(1'b0),
        .D(write_data),
        .CLK(CLK),
        .EN(local_enable[2]),
        .Q(Q2)
    );

     eight_bit_register R3 (
        .AR(1'b0),
        .D(write_data),
        .CLK(CLK),
        .EN(local_enable[3]),
        .Q(Q3)
    );

     eight_bit_register R4 (
        .AR(1'b0),
        .D(write_data),
        .CLK(CLK),
        .EN(local_enable[4]),
        .Q(Q4)
    );

     eight_bit_register R5 (
        .AR(1'b0),
        .D(write_data),
        .CLK(CLK),
        .EN(local_enable[5]),
        .Q(Q5)
    );


     eight_bit_register R6 (
        .AR(1'b0),
        .D(write_data),
        .CLK(CLK),
        .EN(local_enable[6]),
        .Q(Q6)
    );

     eight_bit_register R7 (
        .AR(1'b0),
        .D(write_data),
        .CLK(CLK),
        .EN(local_enable[7]),
        .Q(Q7)
    );

//read_reg 1
    MUX_8 mux0 (
    .A({Q7[0], Q6[0], Q5[0], Q4[0], Q3[0], Q2[0], Q1[0], Q0[0]}), 
    .S(read_reg1), 
    .Y(read_data1[0])
    );

    MUX_8 mux1 (
    .A({Q7[1], Q6[1], Q5[1], Q4[1], Q3[1], Q2[1], Q1[1], Q0[1]}), 
    .S(read_reg1), 
    .Y(read_data1[1])
    );

    MUX_8 mux2 (
    .A({Q7[2], Q6[2], Q5[2], Q4[2], Q3[2], Q2[2], Q1[2], Q0[2]}), 
    .S(read_reg1), 
    .Y(read_data1[2])
    );

    MUX_8 mux3 (
    .A({Q7[3], Q6[3], Q5[3], Q4[3], Q3[3], Q2[3], Q1[3], Q0[3]}), 
    .S(read_reg1), 
    .Y(read_data1[3])
    );


    MUX_8 mux4 (
    .A({Q7[4], Q6[4], Q5[4], Q4[4], Q3[4], Q2[4], Q1[4], Q0[4]}), 
    .S(read_reg1), 
    .Y(read_data1[4])
    );

    MUX_8 mux5 (
    .A({Q7[5], Q6[5], Q5[5], Q4[5], Q3[5], Q2[5], Q1[5], Q0[5]}), 
    .S(read_reg1), 
    .Y(read_data1[5])
    );

    MUX_8 mux6 (
    .A({Q7[6], Q6[6], Q5[6], Q4[6], Q3[6], Q2[6], Q1[6], Q0[6]}), 
    .S(read_reg1), 
    .Y(read_data1[6])
    );

    MUX_8 mux7 (
    .A({Q7[7], Q6[7], Q5[7], Q4[7], Q3[7], Q2[7], Q1[7], Q0[7]}), 
    .S(read_reg1), 
    .Y(read_data1[7])
    );


// read_reg2
    MUX_8 mux02 (
    .A({Q7[0], Q6[0], Q5[0], Q4[0], Q3[0], Q2[0], Q1[0], Q0[0]}), 
    .S(read_reg2), 
    .Y(read_data2[0])
    );

    MUX_8 mux12 (
    .A({Q7[1], Q6[1], Q5[1], Q4[1], Q3[1], Q2[1], Q1[1], Q0[1]}), 
    .S(read_reg2), 
    .Y(read_data2[1])
    );

    MUX_8 mux22 (
    .A({Q7[2], Q6[2], Q5[2], Q4[2], Q3[2], Q2[2], Q1[2], Q0[2]}), 
    .S(read_reg2), 
    .Y(read_data2[2])
    );

    MUX_8 mux32 (
    .A({Q7[3], Q6[3], Q5[3], Q4[3], Q3[3], Q2[3], Q1[3], Q0[3]}), 
    .S(read_reg2), 
    .Y(read_data2[3])
    );


    MUX_8 mux42 (
    .A({Q7[4], Q6[4], Q5[4], Q4[4], Q3[4], Q2[4], Q1[4], Q0[4]}), 
    .S(read_reg2), 
    .Y(read_data2[4])
    );

    MUX_8 mux52 (
    .A({Q7[5], Q6[5], Q5[5], Q4[5], Q3[5], Q2[5], Q1[5], Q0[5]}), 
    .S(read_reg2), 
    .Y(read_data2[5])
    );

    MUX_8 mux62 (
    .A({Q7[6], Q6[6], Q5[6], Q4[6], Q3[6], Q2[6], Q1[6], Q0[6]}), 
    .S(read_reg2), 
    .Y(read_data2[6])
    );

    MUX_8 mux72 (
    .A({Q7[7], Q6[7], Q5[7], Q4[7], Q3[7], Q2[7], Q1[7], Q0[7]}), 
    .S(read_reg2), 
    .Y(read_data2[7])
    );


endmodule
