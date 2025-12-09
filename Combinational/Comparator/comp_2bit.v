// 2-bit Comparator
// Compares two 2-bit numbers a and b
// Outputs:
//   gt = 1 when a > b
//   lt = 1 when a < b
//   eq = 1 when a == b

module comp_2bit(
    input  [1:0] a,     // 2-bit input a
    input  [1:0] b,     // 2-bit input b
    output reg   gt,    // greater-than output
    output reg   lt,    // less-than output
    output reg   eq     // equal output
);

always @(*) begin
    // Default values for outputs (combinational logic)
    gt = 0;
    lt = 0;
    eq = 0;

    // Comparator logic
    if (a == b)
        eq = 1;       // a equal to b
    else if (a > b)
        gt = 1;       // a greater than b
    else
        lt = 1;       // a less than b
end

endmodule
