module tff_using_dff (
    input  wire clk,
    input  wire reset,   // synchronous reset
    input  wire t,       // toggle input
    output reg  q
);

    wire d;

    // T to D conversion
    assign d = t ^ q;

    // D flip-flop
    always @(posedge clk) begin
        if (reset)
            q <= 1'b0;
        else
            q <= d;
    end

endmodule
