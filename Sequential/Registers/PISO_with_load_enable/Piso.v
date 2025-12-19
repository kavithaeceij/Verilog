// ------------------------------------------------------------
// Module: PISO (Parallel-In Serial-Out) Shift Register
// Function:
//   - Loads 4-bit parallel data when load = 1
//   - Shifts data right when shift_right = 1
//   - Outputs data serially (LSB first)
// Reset:
//   - Synchronous, active HIGH
// ------------------------------------------------------------
module piso (
    input        clk,        // Clock signal
    input        rst,        // Synchronous reset (active HIGH)
    input  [3:0] pin,        // Parallel input data
    input        load,       // Load control (parallel load)
    input        shift_right,// Shift control (right shift)
    output       sout        // Serial output (LSB)
);

    reg [3:0] q;             // Internal shift register

    // Sequential logic
    always @(posedge clk) begin
        if (rst) begin
            // Reset clears the register
            q <= 4'b0000;
        end
        else if (load) begin
            // Load parallel data in one clock
            q <= pin;
        end
        else if (shift_right) begin
            // Right shift operation (LSB first)
            // MSB is filled with 0
            q[3] <= 1'b0;
            q[2] <= q[3];
            q[1] <= q[2];
            q[0] <= q[1];
        end
        // else: hold previous value (no operation)
    end

    // Serial output taken from LSB
    assign sout = q[0];

endmodule
