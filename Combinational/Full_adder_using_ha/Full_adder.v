
module half_adder(
    input  a,
    input  b,
    output sum,
    output carry
);
    assign sum   = a ^ b;   // XOR gives sum
    assign carry = a & b;   // AND gives carry
endmodule


// Full Adder using two half adders + OR gate
module full_adder(
    input  a,       // Input bit A
    input  b,       // Input bit B
    input  cin,     // Carry-in
    output sum,     // Final SUM output
    output cout     // Final CARRY output
);
 // Internal wires to connect the two half adders
wire s1;
wire c1;
wire c2;
   // First Half Adder (adds A and B)
half_adder h1(.a(a),.b(b),.sum(c1),.carry(c1));
 // Second Half Adder (adds S1 and Cin)
half_adder h2(.a(s1),.b(cin),.sum(sum),.carry(c2));
 // Final carry (C1 OR C2)
    assign cout = c1 | c2;

endmodule


module full_adder_tb;

    reg  a, b, cin;      // Inputs to the DUT
    wire sum, cout;      // Outputs from the DUT

    // Instantiate the Full Adder
    full_adder dut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial begin
        // Waveform generation
        $dumpfile("full_adder.vcd");
        $dumpvars(0, full_adder_tb);

        // Header for console output
        $display("A B Cin | Sum Cout");
        $display("------------------");

        // Monitor prints values whenever any signal changes
        $monitor("%b %b  %b  |  %b    %b", a, b, cin, sum, cout);

        // Apply all 8 combinations
        a=0; b=0; cin=0; #10;
        a=0; b=0; cin=1; #10;
        a=0; b=1; cin=0; #10;
        a=0; b=1; cin=1; #10;
        a=1; b=0; cin=0; #10;
        a=1; b=0; cin=1; #10;
        a=1; b=1; cin=0; #10;
        a=1; b=1; cin=1; #10;

        $finish;
    end

endmodule
