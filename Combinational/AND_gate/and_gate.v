//==============================
// Gate-level 2-input AND gate
//==============================
module and_gate(a, b, y);
    input  a;          // Input 1
    input  b;          // Input 2
    output y;          // Output

    // Gate-level modeling using primitive 'and'
    and g1 (y, a, b);  // y = a AND b
endmodule


//==============================
// Testbench for AND gate
//==============================
module top;
    reg  a, b;         // Testbench drives inputs
    wire y;            // Output from DUT (Device Under Test)

    // Instantiate the AND gate (DUT)
    and_gate a1 (.a(a), .b(b), .y(y));

    initial begin
        $monitor($time, "  a=%b  b=%b  y=%b", a, b, y);

        a = 0; b = 0;        // 0 AND 0 = 0
        #10 a = 1; b = 0;    // 1 AND 0 = 0
        #10 a = 0; b = 1;    // 0 AND 1 = 0
        #10 a = 1; b = 1;    // 1 AND 1 = 1
    end
endmodule
