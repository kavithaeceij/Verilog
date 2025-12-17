`timescale 1ns/1ps

module tb_sr_using_dff;

    reg clk;
    reg reset;
    reg s, r;
    wire q;

    // DUT instantiation
    sr_using_dff dut (
        .clk   (clk),
        .reset (reset),
        .s     (s),
        .r     (r),
        .q     (q)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Reset + stimulus
    initial begin
        // Initialize
        reset = 1;
        s = 0;
        r = 0;

        // Release reset
        #10 reset = 0;

        // 1) Hold (S=0, R=0)
        #10 s = 0; r = 0;

        // 2) Set (S=1, R=0)
        #10 s = 1; r = 0;

        // 3) Hold again
        #10 s = 0; r = 0;

        // 4) Reset (S=0, R=1)
        #10 s = 0; r = 1;

        // 5) Hold
        #10 s = 0; r = 0;

        // 6) Invalid case (S=1, R=1) – for observation
        #10 s = 1; r = 1;

        #20 $finish;
    end

    // Monitor
    initial begin
        $monitor("time=%0t clk=%b reset=%b s=%b r=%b q=%b",
                  $time, clk, reset, s, r, q);
    end

    // Waveform dump
    initial begin
        $dumpfile("sr_using_dff.vcd");
        $dumpvars(0, tb_sr_using_dff);
    end

endmodule
