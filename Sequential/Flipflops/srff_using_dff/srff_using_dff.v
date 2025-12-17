module sr_using_dff (
    input  wire clk,
    input  wire reset,   // synchronous reset
    input  wire s,       // set
    input  wire r,       // reset
    output reg  q
);

    wire d;

    // SR to D conversion
    assign d = s | (q & ~r);

    // D flip-flop
    always @(posedge clk) begin
        if (reset)
            q <= 1'b0;
        else
            q <= d;
    end

endmodule

