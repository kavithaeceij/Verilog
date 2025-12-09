//=========================================================
// SR flip-flop with asynchronous active-low reset
// S = Set, R = Reset
//=========================================================
module sr_ff(
    input       clk,      // clock input
    input       reset_n,  // active-low asynchronous reset
    input       s,        // set input
    input       r,        // reset input
    output reg  y         // output (flip-flop state)
);

        always @(posedge clk or negedge reset_n) begin
       
        if (!reset_n) begin
            y <= 1'b0;             // reset state
        end
        else begin
            // S=0, R=0 → hold previous state
            if (s == 1'b0 && r == 1'b0) begin
                y <= y;            
            end
            // S=0, R=1 → reset
            else if (s == 1'b0 && r == 1'b1) begin
                y <= 1'b0;
            end
            // S=1, R=0 → set
            else if (s == 1'b1 && r == 1'b0) begin
                y <= 1'b1;
            end
            // S=1, R=1 → illegal condition
            // Here we choose to force y = 0 (design choice)
            else begin
                y <= 1'b0;
            end
        end
    end

endmodule
