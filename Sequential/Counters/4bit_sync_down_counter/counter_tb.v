`timescale 1ns / 1ps
// ------------------------------------------------------------
// Testbench: up_counter_tb
// ------------------------------------------------------------
module up_counter_tb;

    reg        clk;
    reg        rst;
    reg        enable;
    wire [3:0] count;

    // Instantiate DUT
    up_counter dut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .count(count)
    );

    // Clock generation: 10 ns period
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        enable = 0;

        // Apply reset for ~1 clock
        #12;
        rst = 0;

        // Enable counting
        enable = 1;
        #50;   // 5 clock cycles

        // Disable counting (hold)
        enable = 0;
        #30;

        // Enable again
        enable = 1;
        #40;

        // End simulation
        #100;
        $finish;
    end

    // Dump waveform
    initial begin
        $dumpfile("waves.vcd");
        $dumpvars(0, up_counter_tb);
    end

endmodule
