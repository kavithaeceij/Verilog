// ------------------------------------------------------------
// SISO (Serial-In Serial-Out) Shift Register
// ------------------------------------------------------------
// - 4-bit internal shift register
// - Shift RIGHT operation
// - Serial input enters at MSB (q[3])
// - Serial output taken from LSB (q[0])
// - Synchronous reset (active HIGH)
// ------------------------------------------------------------

module siso (
    input  clk,    // Clock signal
    input  rst,    // Synchronous reset (active HIGH)
    input  sin,    // Serial input (1-bit)
    output sout    // Serial output (1-bit)
);

    reg [3:0] q;   // Internal 4-bit shift register (storage)

    // Shift operation happens on every positive clock edge
    always @(posedge clk) begin
        if (rst)
            // On reset, clear all bits of the shift register
            q <= 4'b0000;
        else begin
            // Shift RIGHT operation:
            // New bit enters at MSB, existing bits move right
            q[3] <= sin;   // Serial input goes into MSB
            q[2] <= q[3];  // Previous q[3] moves to q[2]
            q[1] <= q[2];  // Previous q[2] moves to q[1]
            q[0] <= q[1];  // Previous q[1] moves to q[0]
        end
    end

    // Serial output is taken from the LSB
    assign sout = q[0];

endmodule
