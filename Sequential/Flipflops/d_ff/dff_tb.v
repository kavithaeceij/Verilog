`timescale 1ns/1ps
// -------------------------------------------------------------
// Testbench for D Flip-Flop
// -------------------------------------------------------------
// This TB works for BOTH sync and async versions in dff.v.
// You only need to switch which always block is active there.
// -------------------------------------------------------------

module dff_tb;

    reg clk;
    reg reset;
    reg d;
    wire q;

    // DUT instantiation
    dff uut (
        .clk  (clk),
        .reset(reset),
        .d    (d),
        .q    (q)
    );

    // ---------------------------------------------------------
    // Clock generation: 10ns period (100 MHz equivalent)
    // ---------------------------------------------------------
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;   // Toggle clock every 5ns
    end

    // ---------------------------------------------------------
    // Monitor block: prints signal values whenever they change
    // ---------------------------------------------------------
    initial begin
        $monitor($time, " clk=%b reset=%b d=%b q=%b", clk, reset, d, q);
    end

    // ---------------------------------------------------------
    // Stimulus block: drives reset and data
    // ---------------------------------------------------------
    initial begin
        // VCD dump for waveform
        $dumpfile("dff_tb.vcd");
        $dumpvars(0, dff_tb);

        // Initialize
        reset = 1'b0;
        d     = 1'b0;

        // -----------------------------------------------------
        // 1) Apply reset pulse
        // -----------------------------------------------------
        #2;        // small delay before asserting reset
        reset = 1'b1;  // assert reset
        #10;
        reset = 1'b0;  // deassert reset

        // -----------------------------------------------------
        // 2) Drive some data values
        // -----------------------------------------------------
        #5;  d = 1'b0;   // should capture 0 on next clk edge
        #10; d = 1'b1;   // should capture 1 on next clk edge
        #10; d = 1'b0;   // back to 0
        #10; d = 1'b1;   // back to 1

        // -----------------------------------------------------
        // 3) Another reset pulse during operation
        // -----------------------------------------------------
        #7;  reset = 1'b1;  // assert reset again
        #8;  reset = 1'b0;  // release reset

        #20;
        $finish;
    end

endmodule
