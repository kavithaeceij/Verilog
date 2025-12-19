// ------------------------------------------------------------
// Module: up_down_counter
// Width : 4-bit
// Function:
//   - enable = 1 : counter updates
//   - up_down = 1: count up
//   - up_down = 0: count down
// Reset:
//   - Synchronous, active HIGH
// ------------------------------------------------------------
module up_down_counter (
    input        clk,
    input        rst,
    input        enable,
    input        up_down,      // 1 = up, 0 = down
    output reg [3:0] count
);

    always @(posedge clk) begin
        if (rst) begin
            // Reset counter to zero
            count <= 4'b0000;
        end
        else if (enable) begin
            if (up_down)
                count <= count + 1'b1; // count up
            else
                count <= count - 1'b1; // count down
        end
        // else: hold current value
    end

endmodule
