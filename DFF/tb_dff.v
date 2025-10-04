module tb_dff;
    reg clk, rst_n, d;
    wire q;

    // instantiate DFF
    dff uut (
        .clk(clk),
        .rst_n(rst_n),
        .d(d),
        .q(q)
    );

    // clock generation (10ns period)
    always #5 clk = ~clk;

    initial begin
        $dumpfile("dff.vcd");  // for GTKWave
        $dumpvars(0, tb_dff);

        // init
        clk = 0; d = 0; rst_n = 0;

        // release reset after 10ns
        #12 rst_n = 1;

        // drive some values
        #10 d = 1;
        #10 d = 0;
        #10 d = 1;

        #50 $finish;
    end
endmodule
