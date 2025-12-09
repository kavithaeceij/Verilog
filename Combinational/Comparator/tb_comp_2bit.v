// Testbench for 2-bit Comparator
// No inputs/outputs here because testbench only drives and observes signals
`timescale 1ns/1ps

module tb_comp_2bit;

reg  [1:0] a;     // Testbench drives a
reg  [1:0] b;     // Testbench drives b
wire       gt;    // Output from DUT
wire       lt;    // Output from DUT
wire       eq;    // Output from DUT

// Instantiate the design under test (DUT)
comp_2bit c1 (
    .a  (a),
    .b  (b),
    .gt (gt),
    .lt (lt),
    .eq (eq)
);

initial begin
    // Dump file creation for waveform viewing
    $dumpfile("wave.vcd");        // File to save waveforms
    $dumpvars(0, tb_comp_2bit);   // Dump all signals in testbench

    // Print values on console whenever any value changes
    $monitor($time, " a=%h b=%h gt=%h lt=%h eq=%h", a, b, gt, lt, eq);

    // Apply stimulus
    a = 2; b = 1; #5;   // a > b case
    a = 3; b = 3; #5;   // a == b case
    a = 0; b = 3; #5;   // a < b case
    a = 1; b = 2; #5;   // a < b case

    $finish;             // End simulation
end

endmodule
