`timescale 1ns / 1ps
// ------------------------------------------------------------
// Testbench: up_down_counter_tb
// ------------------------------------------------------------
module up_down_counter_tb;

    reg        clk;
    reg        rst;
    reg        enable;
    reg        up_down;
    wire [3:0] count;

    // Instantiate DUT
    up_down_counter dut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .up_down(up_down),
        .count(count)
    );

    // Clock generation: 10 ns period
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        enable = 0;
        up_down = 1'b1; // default up
       
        // Apply reset
        #12;
        rst = 0;

        // -----------------------------
        // Count UP
        // -----------------------------
        enable = 1;
        up_down = 1'b1; // up
        #50;            // 5 clock cycles

        // -----------------------------
        // Hold
        // -----------------------------
        enable = 0;
        #20;

        // -----------------------------
        // Count DOWN
        // -----------------------------
        enable = 1;
        up_down = 1'b0; // down
        #50;            // 5 clock cycles

        // End simulation
        #20;
        $finish;
    end

    // Dump waveform
    initial begin
        $dumpfile("up_down_counter.vcd");
        $dumpvars(0, up_down_counter_tb);
    end

endmodule
