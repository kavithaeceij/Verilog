// ------------------------------------------------------------
// SIPO (Serial-In Parallel-Out) Shift Register
// ------------------------------------------------------------
// - 4-bit internal shift register
// - Shift RIGHT operation
// - Serial input enters at MSB (q[3])
// - Parallel output available on sout[3:0]
// - Synchronous reset (active HIGH)
// ------------------------------------------------------------

module sipo (
    input        clk,    // Clock signal
    input        rst,    // Synchronous reset (active HIGH)
    input        sin,    // Serial input (1-bit)
    input enable,
    output [3:0] sout    // Parallel output (4-bit)
);

    reg [3:0] q;         // Internal 4-bit shift register (storage)

    // Shift operation on every positive clock edge
    always @(posedge clk) begin
        if (rst)
            // Clear all bits of the shift register on reset
            q <= 4'b0000;
        else begin
	    if (enable) begin
            q[3] <= sin;   // Serial input goes into MSB
            q[2] <= q[3];  // Previous q[3] moves to q[2]
            q[1] <= q[2];  // Previous q[2] moves to q[1]
	    q[0] <= q[1];  // Previous q[1] moves to q[0] 
            end
	    else
	       q <=q;
        end
    end

    // Parallel output: all bits available together
    assign sout = q;

endmodule
