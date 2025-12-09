// T flip-flop with asynchronous active-low reset
module tff(
    input       clk,      // clock input
    input       reset_n,  // active-low asynchronous reset
    input       t,        // toggle input
    output reg  y         // output (flip-flop state)
);

    // Trigger on rising edge of clock OR falling edge of active-low reset
    always @(posedge clk or negedge reset_n) begin
        // Asynchronous reset: when reset_n = 0, clear output immediately
        if (!reset_n)
            y <= 1'b0;        // reset state
        // When T = 0, hold previous value (no change)
        else if (t == 1'b0)
            y <= y;           
        // When T = 1, toggle the output
        else if (t == 1'b1)
            y <= ~y;          // toggle y
    end

endmodule

 
