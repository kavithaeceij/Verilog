`timescale 1ns / 1ps
// ------------------------------------------------------------
// Testbench: ring_counter_tb
// ------------------------------------------------------------
module ring_counter_tb;

    reg        clk;
    reg        rst;
    wire [3:0] count;

    // Instantiate DUT
    ring_counter dut (
        .clk(clk),
        .rst(rst),
        .count(count)
    );

    // Clock: 10 ns period
    always #5 clk = ~clk;

    initial begin
        // Initialize
        clk = 0;
        rst = 1;

        // Apply reset
        #12;
        rst = 0;

        // Let it run
        #80;

        // Re-apply reset to confirm re-initialization
        rst = 1;
        #10;
        rst = 0;

        #40;
        $finish;
    end

    // Waveform dump
    initial begin
        $dumpfile("ring_counter.vcd");
        $dumpvars(0, ring_counter_tb);
    end

endmodule
