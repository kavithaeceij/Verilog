//***************************************************************
// 2x1 Multiplexer
//***************************************************************
module mux_2cross1(
    input  a,          // Input bit 0
    input  b,          // Input bit 1
    input  sel,        // Select line
    output reg y       // Output
);

    // Combinational logic
    always @(*) begin
        if (sel == 1'b0)
            y = a;     // When sel = 0, choose a
        else
            y = b;     // When sel = 1, choose b
    end

endmodule


//***************************************************************
// 4x1 Multiplexer using 2x1 muxes (Structural modeling)
//***************************************************************
module mux_4cross1(
    input  [3:0] d,      // 4 data inputs
    input  [1:0] sel,    // 2-bit select
    output  y         // Output
);

    // Intermediate wires for outputs of lower multiplexers
    wire x0, x1;

    // First level multiplexers: use sel[0]
    mux_2cross1 m1(.a(d[0]), .b(d[1]), .sel(sel[0]), .y(x0));
    mux_2cross1 m2(.a(d[2]), .b(d[3]), .sel(sel[0]), .y(x1));

    // Second-level multiplexer: use sel[1]
    mux_2cross1 m3(.a(x0), .b(x1), .sel(sel[1]), .y(y));

endmodule


