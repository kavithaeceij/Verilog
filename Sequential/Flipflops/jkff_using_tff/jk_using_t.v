module jk_using_t(
    input  wire clk,
    input  wire reset,
    input  wire j,
    input  wire k,
    output reg  q
);

    wire t;

    // JK to T conversion
    assign t = (j & ~q) | (k & q);

    // T flip-flop behaviour
    always @(posedge clk) begin
        if (reset)
            q <= 1'b0;
        else if (t)
            q <= ~q;   // toggle
        else
            q <= q;    // hold
    end

endmodule
