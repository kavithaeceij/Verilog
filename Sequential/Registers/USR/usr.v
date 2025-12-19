// ------------------------------------------------------------
// Module: usr (Universal Shift Register)
// Width : 4-bit
// Modes:
//   00 -> Hold (do nothing)
//   01 -> Parallel Load
//   10 -> Shift Right (MSB filled with 0)
//   11 -> Shift Left  (LSB filled with 0)
// Reset:
//   Synchronous, active HIGH
// ------------------------------------------------------------
module usr (
    input        clk,        // Clock
    input        rst,        // Synchronous reset
    input  [1:0] mode,       // Operation select
    input  [3:0] data,       // Parallel input data
    output reg [3:0] y       // Parallel output
);

    reg [3:0] q;             // Internal register

    // Sequential logic
    always @(posedge clk) begin
        if (rst) begin
            // Clear register on reset
            q <= 4'b0000;
        end
        else begin
            case (mode)
                2'b00: begin
                    // Hold: retain previous value
                    q <= q;
                end

                2'b01: begin
                    // Parallel load
                    q <= data;
                end

                2'b10: begin
                    // Shift right
                    // MSB is filled with 0
                    q[3] <= 1'b0;
                    q[2] <= q[3];
                    q[1] <= q[2];
                    q[0] <= q[1];
                end

                2'b11: begin
                    // Shift left
                    // LSB is filled with 0
                    q[3] <= q[2];
                    q[2] <= q[1];
                    q[1] <= q[0];
                    q[0] <= 1'b0;
                end
            endcase
        end
    end

    // Parallel output
    always @(*) begin
        y = q;
    end

endmodule
