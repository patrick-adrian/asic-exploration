// alu.v - Simple 8-bit ALU
module alu (
    input  [7:0] a, b,       // operands
    input  [2:0] op,         // operation select
    output reg [7:0] result  // result
);

always @(*) begin
    case(op)
        3'b000: result = a + b;       // ADD
        3'b001: result = a - b;       // SUB
        3'b010: result = a & b;       // AND
        3'b011: result = a | b;       // OR
        3'b100: result = a ^ b;       // XOR
        3'b101: result = a << 1;      // Shift Left
        3'b110: result = a >> 1;      // Shift Right
        3'b111: result = ~a;          // NOT
        default: result = 8'b0;
    endcase
end

endmodule
