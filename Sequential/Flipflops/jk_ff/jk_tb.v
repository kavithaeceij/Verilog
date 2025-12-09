`timescale 1ns/1ps

//=========================================================
// Testbench for JK Flip-Flop (jk_ff)
//=========================================================
module jk_ff_tb;

    // Testbench signals
    reg  clk;
    reg  reset_n;
    reg  j;
    reg  k;
    wire y;

    // Instantiate DUT (Device Under Test)
    jk_ff dut (
        .clk    (clk),
        .reset_n(reset_n),
        .j      (j),
        .k      (k),
        .y      (y)
    );

    // Clock generation: 10 ns period (100 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Input stimulus
    initial begin
        // Initial values
        reset_n = 0;
        j = 0;
        k = 0;

        // Apply reset
        #12 reset_n = 1;

        // 1) Hold: J=0, K=0
        #20 j = 0; k = 0;

        // 2) Reset: J=0, K=1
        #20 j = 0; k = 1;

        // 3) Set: J=1, K=0
        #20 j = 1; k = 0;

        // 4) Toggle: J=1, K=1
        #40 j = 1; k = 1;

        // 5) Hold again
        #20 j = 0; k = 0;

        // Finish simulation
        #50 $finish;
    end

    // Monitor changes
    initial begin
        $monitor("time=%0t  clk=%b  reset_n=%b  j=%b  k=%b  y=%b",
                  $time, clk, reset_n, j, k, y);
    end

    // VCD dump for GTKWave
    initial begin
        $dumpfile("jk_ff_tb.vcd");
        $dumpvars(0, jk_ff_tb);
    end

endmodule
