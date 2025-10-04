//==============================================================
// Testbench for 8-bit ALU (matches your module ports)
//==============================================================
`timescale 1ns/1ps

module tb_alu;
    reg [7:0] a, b;
    reg [2:0] op;
    wire [7:0] result;

    // Instantiate ALU (matches your module exactly)
    alu uut (
        .a(a),
        .b(b),
        .op(op),
        .result(result)
    );

    initial begin
        $dumpfile("alu.vcd");
        $dumpvars(0, tb_alu);

        // Test patterns
        a = 8'h0A; b = 8'h03; op = 3'b000; #10; // ADD
        a = 8'h0A; b = 8'h03; op = 3'b001; #10; // SUB
        a = 8'h0A; b = 8'h03; op = 3'b010; #10; // AND
        a = 8'h0A; b = 8'h03; op = 3'b011; #10; // OR
        a = 8'h0A; b = 8'h03; op = 3'b100; #10; // XOR
        a = 8'h0A; b = 8'h03; op = 3'b101; #10; // NAND
        a = 8'h0A; b = 8'h0F; op = 3'b110; #10; // SLT
        a = 8'h0A; b = 8'h03; op = 3'b111; #10; // NOP

        #20 $finish;
    end
endmodule
