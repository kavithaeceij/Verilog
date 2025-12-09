// -------------------------------------------------------------
// 4-bit ALU
// -------------------------------------------------------------
// Inputs:
//   a   - 4-bit operand
//   b   - 4-bit operand
//   sel - 3-bit operation select
// Output:
//   y   - 4-bit ALU result
//
// Modeling: Behavioral (always @(*), case statement)
// -------------------------------------------------------------

module alu4(
    input  [3:0] a,
    input  [3:0] b,
    input  [2:0] sel,
    output reg [3:0] y
);

always @(*) begin
    // Default value to avoid latches
    y = 4'b0000;

    case (sel)
        3'b000: y = a + b;        // Addition
        3'b001: y = a - b;        // Subtraction
        3'b010: y = a & b;        // AND
        3'b011: y = a | b;        // OR
        3'b100: y = ~a;           // NOT A
        3'b101: y = a ^ b;        // XOR
        3'b110: y = b;            // Pass-through B
        3'b111: y = a + 1;        // Increment A
        default: y = 4'b0000;     // Default case
    endcase
end

endmodule       
