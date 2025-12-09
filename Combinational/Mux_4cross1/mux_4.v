 // -------------------------------------------------------------
// 4:1 Multiplexer (Behavioral Combinational Modelling)
// -------------------------------------------------------------
// This design uses:
//   * always @(*)        → combinational always block
//   * case(sel)          → behavioral selection logic
//   * blocking '='       → because this is combinational logic
//
// This is a perfect example of BEHAVIORAL COMBINATIONAL modelling.
// -------------------------------------------------------------

module mux_4 (
    input       i0,          // Input line 0
    input       i1,          // Input line 1
    input       i2,          // Input line 2
    input       i3,          // Input line 3
    input [1:0] sel,         // 2-bit select line
    output reg  y            // Output (reg because assigned inside always)
);

always @(*) begin
    // Behavioral combinational logic using case
    case (sel)
        2'b00 : y = i0;      // When sel = 00 → y = i0
        2'b01 : y = i1;      // When sel = 01 → y = i1
        2'b10 : y = i2;      // When sel = 10 → y = i2
        2'b11 : y = i3;      // When sel = 11 → y = i3
        default: y = 1'b0;   //  default value
    endcase
end

endmodule
