// ------------------------------------------------------------
// N-bit Register with Synchronous Reset and Enable
// ------------------------------------------------------------
// - Parameterized data width (default = 16 bits)
// - Positive-edge triggered
// - Synchronous active-HIGH reset
// - Enable-controlled data loading
// ------------------------------------------------------------

module reg_nbit #(
    parameter BITWIDTH = 16            // Width of the register
)(
    input                   clk,       // Clock signal
    input                   rst_n,       // ASynchronous reset (active Low)
    input                   enable,    // Enable signal
    input  [BITWIDTH-1:0]   a,         // N-bit data input
    output reg [BITWIDTH-1:0] q         // N-bit registered output
);

    // Sequential logic: register behavior
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            // Clear all bits of the register on reset
            q <= {BITWIDTH{1'b0}};
        else if (enable)
            // Load input data when enable is high
            q <= a;
        // else: hold previous value (implicit register behavior)
    end

endmodule

// meaning of  q <= {BITWIDTH{1'b0}};
//Take 1'b0
//Repeat it BITWIDTH times
//Concatenate all bits together
//{4{1'b0}}  →  4'b0000
//
//#(...) in a module declaration is used to define parameters for configurable RTL designs. # means not delay here..
