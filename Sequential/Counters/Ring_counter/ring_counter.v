 ------------------------------------------------------------
// Module: ring_counter
// Function:
//   - 4-bit ring (one-hot) counter
//   - Rotates left each clock
// Reset:
//   - Synchronous, active HIGH
// ------------------------------------------------------------
module ring_counter (
    input        clk,
    input        rst,
    output reg [3:0] count
);

    always @(posedge clk) begin
        if (rst) begin
            // Initialize to a valid one-hot state
            count <= 4'b0001;
        end
        else begin
            // Rotate left with wrap-around
            count <= {count[2:0], count[3]};
        end
    end

endmodule
