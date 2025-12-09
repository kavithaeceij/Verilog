`timescale 1ns/1ps

module tff_tb;

    // Testbench signals
    reg  clk;
    reg  reset_n;
    reg  t;
    wire y;

    // DUT (Device Under Test) instantiation
    tff t1 (
        .clk    (clk),
        .reset_n(reset_n),
        .t      (t),
        .y      (y)
    );

    // Clock generation: 10 ns period (100 MHz)
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;   // toggle every 5 ns
    end

    // Stimulus: reset + T patterns
    initial begin
        // Initial values
        reset_n = 1'b0;   // start in reset
        t       = 1'b0;

        #12;
        reset_n = 1'b1;  

        #20;
        t = 1'b0;
        #20;
        t = 1'b1;
        #40;
        t = 1'b0;
        #40;
        t = 1'b1;
        #100;
        $finish;
    end

    // Monitor: print signal values whenever any of them changes
    initial begin
        $monitor("time=%0t  clk=%b  reset_n=%b  t=%b  y=%b",
                 $time, clk, reset_n, t, y);
    end

    // Waveform dump for GTKWave / viewer
    initial begin
        $dumpfile("tff_tb.vcd");   // output VCD file name
        $dumpvars(0, tff_tb);      // dump all signals in this TB hierarchy
    end

endmodule

