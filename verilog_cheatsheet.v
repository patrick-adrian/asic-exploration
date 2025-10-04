//==============================================================
// Verilog Crash Course Cheat Sheet
// Author: Patrick Pineda
//==============================================================

//--------------------------------------------------------------
// 1. MODULES (building blocks of Verilog)
//--------------------------------------------------------------
module and_gate (
    input  wire a, b,   // inputs
    output wire y       // output
);
    assign y = a & b;   // continuous assignment
endmodule


//--------------------------------------------------------------
// 2. WIRE vs REG
//--------------------------------------------------------------
// wire = for connections, driven by assign or outputs
// reg  = for storage in always blocks
//--------------------------------------------------------------
module wire_reg_example (
    input  wire d,
    input  wire clk,
    output reg  q
);
    // sequential storage
    always @(posedge clk) begin
        q <= d;
    end
endmodule


//--------------------------------------------------------------
// 3. ALWAYS BLOCKS
//--------------------------------------------------------------
// * @(*) = combinational always block
// * @(posedge clk) = sequential always block
//--------------------------------------------------------------
module always_example (
    input  wire a, b, clk, rst,
    output reg  y, q
);
    // combinational logic
    always @(*) begin
        y = a ^ b; // blocking assignment (=)
    end

    // sequential logic
    always @(posedge clk or posedge rst) begin
        if (rst) q <= 0;
        else     q <= y; // non-blocking assignment (<=)
    end
endmodule


//--------------------------------------------------------------
// 4. BLOCKING vs NON-BLOCKING
//--------------------------------------------------------------
// Use "=" inside combinational always blocks
// Use "<=" inside sequential always blocks
//--------------------------------------------------------------


//--------------------------------------------------------------
// 5. FINITE STATE MACHINE (FSM)
//--------------------------------------------------------------
module fsm_example (
    input  wire clk, rst, start,
    output reg  busy
);
    // state encoding
    typedef enum logic [1:0] {IDLE=2'b00, LOAD=2'b01, EXEC=2'b10} state_t;
    state_t state, next_state;

    // sequential state update
    always @(posedge clk or posedge rst) begin
        if (rst) state <= IDLE;
        else     state <= next_state;
    end

    // combinational next-state logic
    always @(*) begin
        case (state)
            IDLE: next_state = start ? LOAD : IDLE;
            LOAD: next_state = EXEC;
            EXEC: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // outputs
    always @(*) begin
        busy = (state != IDLE);
    end
endmodule


//--------------------------------------------------------------
// 6. PARAMETERS & GENERATE
//--------------------------------------------------------------
module adder_array #(
    parameter WIDTH = 8
)(
    input  wire [WIDTH-1:0] a, b,
    output wire [WIDTH-1:0] sum
);
    genvar i;
    generate
        for (i = 0; i < WIDTH; i = i+1) begin : bit_adders
            assign sum[i] = a[i] ^ b[i]; // simple XOR add (demo)
        end
    endgenerate
endmodule


//--------------------------------------------------------------
// 7. TESTBENCH BASICS
//--------------------------------------------------------------
module tb;
    reg a, b;
    wire y;

    and_gate uut (.a(a), .b(b), .y(y)); // instantiate unit under test

    initial begin
        $monitor("Time=%0t a=%b b=%b y=%b", $time, a, b, y);

        a=0; b=0; #10;
        a=1; b=0; #10;
        a=1; b=1; #10;
        $finish;
    end
endmodule


//--------------------------------------------------------------
// 8. MEMORY (ROM / RAM)
//--------------------------------------------------------------
module memory_example;
    reg [7:0] mem [0:255]; // 256 x 8-bit memory

    initial begin
        $readmemh("program.hex", mem); // load from file
    end
endmodule


//--------------------------------------------------------------
// 9. SYSTEM TASKS
//--------------------------------------------------------------
// * $display, $monitor = print to console
// * $stop = pause simulation
// * $finish = end simulation
// * $dumpfile/$dumpvars = write waveforms for GTKWave
//--------------------------------------------------------------

