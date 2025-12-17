// D Flip-Flop using JK Flip-Flop
module dff_using_jk (
    input  wire clk,
    input  wire reset,   // synchronous reset
    input  wire d,
    output reg  q
);

    wire j, k;

    // Conversion: D -> JK
 
   assign j = d;
    assign k = ~d;

    // JK Flip-Flop behavior
    always @(posedge clk) begin
        if (reset)
            q <= 1'b0;
        else begin
            case ({j, k})
                2'b00: q <= q;     // hold
                2'b01: q <= 1'b0;  // reset
                2'b10: q <= 1'b1;  // set
                2'b11: q <= ~q;    // toggle (will never occur here)
            endcase
        end
    end

endmodule
