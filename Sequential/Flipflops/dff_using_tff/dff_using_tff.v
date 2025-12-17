module dff_using_t (
    input  wire clk,
    input  wire reset,   // synchronous reset
    input  wire d,
    output reg  q
);

    wire t;

    // D to T conversion
    assign t = d ^ q;

    // T flip-flop behavior
    always @(posedge clk) begin
        if (reset)
            q <= 1'b0;
        else begin
            if (t == 1'b0)
                q <= q;     // hold
            else
                q <= ~q;    // toggle
        end
    end

endmodule
