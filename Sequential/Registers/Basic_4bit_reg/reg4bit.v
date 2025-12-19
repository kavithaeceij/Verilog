// 4-bit Register with Synchronous Reset
// ------------------------------------
// - Stores 4-bit input data
// - Updates output on positive edge of clock
// - Reset is synchronous (acts only on clock edge)

module reg4bit (
    input        clk,      // Clock signal
    input        rst,      // Synchronous reset (active HIGH)
    input  [3:0] a,        // 4-bit data input
    output reg [3:0] q     // 4-bit registered output
);

    // Sequential always block (edge-triggered)
    always @(posedge clk) begin
        if (rst)
            q <= 4'b0000;  // Clear register when reset is high
        else
            q <= a;        // Load input data into register
    end

endmodule
