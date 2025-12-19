`timescale 1ns / 1ps
// ------------------------------------------------------------
// Testbench: mod_counter_tb
// ------------------------------------------------------------
module mod_counter_tb;

    reg        clk;
    reg        rst;
    reg        enable;
    wire [3:0] count;

    // Instantiate DUT
    mod_counter dut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .count(count)
    );

    // Clock generation: 10 ns period
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk    = 0;
        rst    = 1;
        enable = 0;

        // Apply reset
        #12;
        rst = 0;

        // -----------------------------
        // Enable counting (Mod-10)
        // -----------------------------
        enable = 1;
        #120;   // Enough cycles to see wrap from 9 -> 0

        // -----------------------------
        // Hold counter
        // -----------------------------
        enable = 0;
        #30;

        // -----------------------------
        // Enable again
        // -----------------------------
        enable = 1;
        #40;

        // End simulation
        #20;
        $finish;
    end

    // Dump waveform
    initial begin
        $dumpfile("mod10_counter.vcd");
        $dumpvars(0, mod_counter_tb);
    end

endmodule
