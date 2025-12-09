`timescale 1ns/1ps
// -------------------------------------------------------------
// Testbench for 4-bit ALU
// -------------------------------------------------------------
module alu4_tb;

    // Testbench signals
    reg  [3:0] a, b;
    reg  [2:0] sel;
    wire [3:0] y;

    // DUT Instantiation
    alu4 uut (
        .a(a),
        .b(b),
        .sel(sel),
        .y(y)
    );

    //------------------------------------------------------------
    // MONITOR BLOCK (runs throughout simulation)
    //------------------------------------------------------------
    initial begin
        $monitor($time, " sel=%b  a=%b  b=%b  y=%b", sel, a, b, y);
    end

    //------------------------------------------------------------
    // STIMULUS BLOCK (test patterns applied here)
    //------------------------------------------------------------
    initial begin
        // Create VCD waveform file
        $dumpfile("waves.vcd");
        $dumpvars(0, alu4_tb);

        // -------------------------------
        // Apply ALU operations
        // -------------------------------

        // 000 : Addition
        sel = 3'b000;  a = 4'b0011;  b = 4'b0001; #10;   
        // 001 : Subtraction
        sel = 3'b001;  a = 4'b0101;  b = 4'b0001; #10;  
        // 010 : AND
        sel = 3'b010;  a = 4'b1100;  b = 4'b1010; #10;   

        // 011 : OR
        sel = 3'b011;  a = 4'b1100;  b = 4'b0011; #10;  
        // 100 : NOT A
        sel = 3'b100;  a = 4'b1010;  b = 4'bxxxx; #10;  
        // 101 : XOR
        sel = 3'b101;  a = 4'b1100;  b = 4'b1010; #10;  

        // 110 : Pass B
        sel = 3'b110;  a = 4'bxxxx;  b = 4'b1001; #10;   

        // 111 : Increment A
        sel = 3'b111;  a = 4'b0111;  b = 4'bxxxx; #10;  

        $finish;  // End simulation
    end

endmodule
