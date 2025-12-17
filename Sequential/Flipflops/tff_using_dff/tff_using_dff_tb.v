`timescale 1ns/1ps

module tb_tff_using_dff;

    reg clk;
    reg reset;
    reg t;
    wire q;

    // DUT instantiation
    tff_using_dff dut (
        .clk   (clk),
        .reset (reset),
        .t     (t),
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
        t = 0;

        // Release reset
        #10 reset = 0;

        // Hold (T = 0)
        #10 t = 0;
        #10 t = 0;

        // Toggle (T = 1)
        #10 t = 1;
        #10 t = 1;
        #10 t = 1;

        // Hold again
        #10 t = 0;

        // Toggle again
        #10 t = 1;

        #20 $finish;
    end

    // Monitor
    initial begin
        $monitor("time=%0t clk=%b reset=%b t=%b q=%b",
                  $time, clk, reset, t, q);
    end

    // Waveform dump
    initial begin
        $dumpfile("tff_using_dff.vcd");
        $dumpvars(0, tb_tff_using_dff);
    end

endmodule
