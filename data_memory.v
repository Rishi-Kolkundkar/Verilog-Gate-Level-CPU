module data_memory (
    input  wire [7:0] Address,
    input  wire [7:0] WriteData,
    input  wire       MemWrite,
    input  wire       MemRead,
    input  wire       CLK,
    output wire [7:0] ReadData
);

    //Step 1: Decode address for per-word write enable
    wire [255:0] select;
    decoder8_256 u_dec (.A(Address), .Y(select));

    wire [255:0] we;
    genvar i;
    generate
        for (i=0; i<256; i=i+1) begin : gen_we
            and g_and(we[i], select[i], MemWrite);
        end
    endgenerate

    //Step 2: 256 x 8-bit registers
    wire [7:0] mem_q [255:0];
    generate
        for (i=0; i<256; i=i+1) begin : gen_mem
            eight_bit_register u_reg (.D(WriteData), .CLK(CLK), .EN(we[i]), .Q(mem_q[i]), .AR(1'b0));
        end
    endgenerate

    //Step 3: Read path: per-bit 256-to-1 mux
    wire [7:0] read_word;
    genvar b, k;
    generate
        for (b=0; b<8; b=b+1) begin : gen_read
            wire [255:0] bit_bus;
            for (k=0; k<256; k=k+1) begin : gather_bits
                buf bbuf (bit_bus[k], mem_q[k][b]);
            end
            mux256_1_bit_8to1 u_mux (.D(bit_bus), .Addr(Address), .Y(read_word[b]));
        end
    endgenerate

    //Step 4: Gate output with MemRead
    
    mux_2_to_1 #(.WIDTH(8)) finsel (
    .In0(8'b0),
    .In1(read_word),
    .Sel(MemRead),
    .Out(ReadData)
);

endmodule
