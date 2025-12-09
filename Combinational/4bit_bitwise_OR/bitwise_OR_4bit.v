//==============================
// 4-bit Bitwise OR Gate
//==============================

module bitwise_OR(input [3:0] a, input [3:0] b, output [3:0] y);
    assign y = a | b;          // Bitwise OR: each bit of a OR b
endmodule


//==============================
// Testbench
//==============================
`timescale 1ns/1ps

module top;
    reg  [3:0] a, b;           // 4-bit inputs
    wire [3:0] y;              // 4-bit output

    // Instantiation
    bitwise_OR b1 (.a(a), .b(b), .y(y));

    initial begin
        // -------------------------------
        // Waveform dump
        // -------------------------------
        $dumpfile("wave.vcd");  // Output file
        $dumpvars(0, top);      // Dump all signals in testbench
        // -------------------------------
        $monitor($time, " a=%b  b=%b  y=%b", a, b, y);

        a = 4'b0000; b = 4'b0000;     // 0000 OR 0000 = 0000
        #10 a = 4'b1100; b = 4'b1010; // 1100 OR 1010 = 1110
        #10 a = 4'b0110; b = 4'b0011; // 0110 OR 0011 = 0111
        #10 a = 4'b1111; b = 4'b0001; // 1111 OR 0001 = 1111
        #10;
    end
endmodule
