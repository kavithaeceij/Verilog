//=========================================================
// JK Flip-Flop (Edge Triggered) with Active-Low Async Reset
//=========================================================
module jk_ff(
    input       clk,       // clock input
    input       reset_n,   // active-low asynchronous reset
    input       j,         // J input
    input       k,         // K input
    output reg  y          // output (flip-flop state)
);

    // Flip-flop updates only on the rising edge of the clock
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            y <= 1'b0;        // asynchronous reset
        end
        else begin
            case ({j, k})
                2'b00: y <= y;       // hold
                2'b01: y <= 1'b0;    // reset
                2'b10: y <= 1'b1;    // set
                2'b11: y <= ~y;      // toggle
            endcase
        end
    end

endmodule
