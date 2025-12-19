`timescale 1ns / 1ps
// ------------------------------------------------------------
// Testbench: load_counter_tb
// ------------------------------------------------------------
module load_counter_tb;

    reg        clk;
    reg        rst;
    reg        load;
    reg        enable;
    reg  [3:0] data_in;
    wire [3:0] count;

    // Instantiate DUT
    load_counter dut (
        .clk(clk),
        .rst(rst),
        .load(load),
        .enable(enable),
        .data_in(data_in),
        .count(count)
    );

    // Clock generation: 10 ns period
    always #5 clk = ~clk;

    initial begin
        // -----------------------------
        // Initial values
        // -----------------------------
        clk     = 0;
        rst     = 1;
        load    = 0;
        enable  = 0;
        data_in = 4'b0000;

        // -----------------------------
        // Apply reset
        // -----------------------------
        #12;
        rst = 0;

        // -----------------------------
        // Load value = 5
        // -----------------------------
        data_in = 4'b0101;   // 5
        load    = 1;
        enable  = 1;         // enable also high (load has priority)
        #10;                 // one clock

        // -----------------------------
        // Count from loaded value
        // -----------------------------
        load   = 0;          // disable load
        enable = 1;          // start counting
        #40;                 // several clocks

        // -----------------------------
        // Hold counter
        // -----------------------------
        enable = 0;
        #20;

        // -----------------------------
        // Load new value = 12
        // -----------------------------
        data_in = 4'b1100;   // 12
        load    = 1;
        #10;

        // -----------------------------
        // Count again
        // -----------------------------
        load   = 0;
        enable = 1;
        #30;

        // End simulation
        #20;
        $finish;
    end

    // Dump waveform
    initial begin
        $dumpfile("load_counter.vcd");
        $dumpvars(0, load_counter_tb);
    end

endmodule
