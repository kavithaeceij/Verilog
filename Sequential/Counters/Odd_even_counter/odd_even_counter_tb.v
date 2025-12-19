`timescale 1ns / 1ps
// ------------------------------------------------------------
// Testbench: odd_even_counter_tb
// ------------------------------------------------------------
module odd_even_counter_tb;

    reg        clk;
    reg        rst;
    reg        odd_even;   // 0 = even, 1 = odd
    reg        enable;
    wire [3:0] count;

    // Instantiate DUT
    odd_even_counter dut (
        .clk(clk),
        .rst(rst),
        .odd_even(odd_even),
        .enable(enable),
        .count(count)
    );

    // Clock generation: 10 ns period
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk      = 0;
        rst      = 1;
        odd_even = 0;   // even mode
        enable   = 0;

        // -----------------------------
        // Reset in EVEN mode
        // -----------------------------
        #12;
        rst = 0;

        // Enable counting (EVEN)
        enable = 1;
        #40;   // several clock cycles

        // -----------------------------
        // Hold counter
        // -----------------------------
        enable = 0;
        #20;

        // -----------------------------
        // Reset in ODD mode
        // -----------------------------
        odd_even = 1;   // odd mode
        rst = 1;
        #10;
        rst = 0;

        // Enable counting (ODD)
        enable = 1;
        #40;

        // End simulation
        #20;
        $finish;
    end

    // Dump waveform
    initial begin
        $dumpfile("odd_even_counter.vcd");
        $dumpvars(0, odd_even_counter_tb);
    end

endmodule
