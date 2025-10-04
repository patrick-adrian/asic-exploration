//==============================================================
// D Flip-Flop (Positive-edge triggered, with async reset)
//==============================================================
module dff (
    input  wire clk,     // clock
    input  wire rst_n,   // active-low asynchronous reset
    input  wire d,       // data input
    output reg  q        // data output
);

    // sequential logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) 
            q <= 1'b0;   // reset state
        else 
            q <= d;      // capture data on rising clock edge
    end

endmodule
