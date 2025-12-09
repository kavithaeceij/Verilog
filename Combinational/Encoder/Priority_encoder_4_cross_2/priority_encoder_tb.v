`timescale 1ns/1ps
// -------------------------------------------------------------
// Testbench for 4-to-2 Priority Encoder
// -------------------------------------------------------------
// Applies patterns to 'data' and observes 'y'.
// Includes cases where multiple bits are 1 to check priority.
// -------------------------------------------------------------

module priority_encoder_tb;

    reg  [3:0] data;   // Testbench drives this
    wire [1:0] y;      // Output from DUT

    // Instantiate DUT (Device Under Test)
    priority_encoder e1 (
        .data(data),
        .y(y)
    );

    initial begin
        // Create VCD waveform dump
        $dumpfile("waves.vcd");
        $dumpvars(0, priority_encoder_tb);

        // Monitor signal changes in console
        $monitor($time, " data=%b  y=%b", data, y);

        // Test patterns
        data = 4'b0000; #10;   // No bits set -> expect 00 (default)
        data = 4'b0001; #10;   // bit0 -> 00
        data = 4'b0010; #10;   // bit1 -> 01
        data = 4'b0100; #10;   // bit2 -> 10
        data = 4'b1000; #10;   // bit3 -> 11 (highest priority)

        // Multiple bits set (priority cases)
        data = 4'b1111; #10;   // all 1s -> 11 (bit3 wins)
        data = 4'b1100; #10;   // bits3,2 -> 11 (bit3 wins)
        data = 4'b0011; #10;   // bits1,0 -> 01 (bit1 wins)
        data = 4'b0110; #10;   // bits2,1 -> 10 (bit2 wins)

        $finish;               // End simulation
    end

endmodule


