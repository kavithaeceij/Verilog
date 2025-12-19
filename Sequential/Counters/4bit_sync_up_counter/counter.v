// ------------------------------------------------------------
// Module: up_counter
// Width : 4-bit
// Function:
//   - Counts up on each clock when enable = 1
//   - Holds value when enable = 0
// Reset:
//   - Synchronous, active HIGH
// ------------------------------------------------------------
module up_counter (
    input        clk,     // Clock
    input        rst,     // Synchronous reset
    input        enable,  // Count enable
    output reg [3:0] count
);

    always @(posedge clk) begin
        if (rst) begin
            // Reset counter to zero
            count <= 4'b0000;
        end
        else if (enable) begin
            // Increment counter
            count <= count + 1'b1;
        end
        // else: hold current value
    end

endmodule
