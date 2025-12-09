/*

//======================================
// HALF ADDER - GATE-LEVEL MODELING
//======================================
module half_adder_gate(
    input  a,          // 1-bit input A
    input  b,          // 1-bit input B
    output sum,        // 1-bit SUM output
    output carry       // 1-bit CARRY output
);

    // Gate-level primitives
    // XOR gate produces SUM = A ⊕ B
    xor u1 (sum,  a, b);   

    // AND gate produces CARRY = A · B
    and u2 (carry, a, b);   

endmodule

//======================================
// HALF ADDER - DATAFLOW MODELING
//======================================
module half_adder_dataflow(
    input  a,          // 1-bit input A
    input  b,          // 1-bit input B
    output sum,        // 1-bit SUM output
    output carry       // 1-bit CARRY output
);

        assign sum   = a ^ b;    
        assign carry = a & b;    

endmodule
*/

//======================================
// HALF ADDER - BEHAVIORAL MODELING
//======================================
module half_adder_behav(
    input  a,          // 1-bit input A
    input  b,          // 1-bit input B
    output reg sum,    // reg because assigned in always block
    output reg carry
);

    // always @(*) → combinational block (sensitive to all inputs)
    always @(*) begin
        // SUM = A XOR B
        sum   = a ^ b;

        // CARRY = A AND B
        carry = a & b;
    end

endmodule

`timescale 1ns/1ps

module top;
    reg  a, b;               // stimulus (inputs driven by testbench)
    wire sum, carry;         // outputs from DUT (Device Under Test)

    // Gate-level
    // half_adder_gate     dut (.a(a), .b(b), .sum(sum), .carry(carry));

    // Dataflow
    // half_adder_dataflow dut (.a(a), .b(b), .sum(sum), .carry(carry));

    // Behavioral
    half_adder_behav    dut (.a(a), .b(b), .sum(sum), .carry(carry));

    initial begin
        // For waveform
        $dumpfile("half_adder.vcd");
        $dumpvars(0, top);

        // For console output
        $monitor($time, " a=%b b=%b sum=%b carry=%b", a, b, sum, carry);

        // Apply all input combinations
        a = 0; b = 0;  #10;
        a = 0; b = 1;  #10;
        a = 1; b = 0;  #10;
        a = 1; b = 1;  #10;

        $finish;
    end
endmodule

