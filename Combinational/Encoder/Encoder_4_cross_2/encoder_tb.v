`timescale 1ns/1ps

module encoder_tb;

    reg  [3:0] data;   // Testbench drives this
    wire [1:0] y;      // Output from DUT

    // Instantiate DUT (Device Under Test)
    encoder e1 (
        .data(data),
        .y(y)
    );

    initial begin
        // Create VCD waveform dump
        $dumpfile("encoder_tb.vcd");
        $dumpvars(0, encoder_tb);

        // Monitor signal changes in console
        $monitor($time, " data=%b  y=%b", data, y);

        // Test patterns
        data = 4'b0000; #10;   // invalid, triggers default
        data = 4'b0001; #10;   // expect 00
        data = 4'b0010; #10;   // expect 01
        data = 4'b0100; #10;   // expect 10
        data = 4'b1000; #10;   // expect 11

        $finish;              // End simulation
    end

endmodule

