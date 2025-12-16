// --------------------------------------------------
// 2x1 Multiplexer
// --------------------------------------------------
module mux_2cross1 (
    input  a,          // Input 0
    input  b,          // Input 1
    input  sel,        // Select line
    output reg y       // Output
);

always @(*) begin
    if (sel == 0)
        y = a;          // If sel=0, pass input a
    else
        y = b;          // If sel=1, pass input b
end

endmodule


// --------------------------------------------------
// 16x1 Multiplexer using 2x1 Multiplexers
// Hierarchical design (16 → 8 → 4 → 2 → 1)
// --------------------------------------------------
module mux_16cross1 (
    input  [15:0] data,   // 16 data inputs
    input  [3:0]  sel,    // 4 select lines
    output         y      // Final output
);

    // -------- Stage 1 wires (16 → 8) --------
    wire a, b, c, d, e, f, g, h;

    // -------- Stage 2 wires (8 → 4) --------
    wire i, j, k, l;

    // -------- Stage 3 wires (4 → 2) --------
    wire m, n;


    // -------- Stage 1 : sel[0] --------
    // Each mux selects between two data inputs
    mux_2cross1 m1 (.a(data[0]),  .b(data[1]),  .sel(sel[0]), .y(a));
    mux_2cross1 m2 (.a(data[2]),  .b(data[3]),  .sel(sel[0]), .y(b));
    mux_2cross1 m3 (.a(data[4]),  .b(data[5]),  .sel(sel[0]), .y(c));
    mux_2cross1 m4 (.a(data[6]),  .b(data[7]),  .sel(sel[0]), .y(d));
    mux_2cross1 m5 (.a(data[8]),  .b(data[9]),  .sel(sel[0]), .y(e));
    mux_2cross1 m6 (.a(data[10]), .b(data[11]), .sel(sel[0]), .y(f));
    mux_2cross1 m7 (.a(data[12]), .b(data[13]), .sel(sel[0]), .y(g));
    mux_2cross1 m8 (.a(data[14]), .b(data[15]), .sel(sel[0]), .y(h));


    // -------- Stage 2 : sel[1] --------
    mux_2cross1 m9  (.a(a), .b(b), .sel(sel[1]), .y(i));
    mux_2cross1 m10 (.a(c), .b(d), .sel(sel[1]), .y(j));
    mux_2cross1 m11 (.a(e), .b(f), .sel(sel[1]), .y(k));
    mux_2cross1 m12 (.a(g), .b(h), .sel(sel[1]), .y(l));


    // -------- Stage 3 : sel[2] --------
    mux_2cross1 m13 (.a(i), .b(j), .sel(sel[2]), .y(m));
    mux_2cross1 m14 (.a(k), .b(l), .sel(sel[2]), .y(n));


    // -------- Stage 4 : sel[3] --------
    // Final selection
    mux_2cross1 m15 (.a(m), .b(n), .sel(sel[3]), .y(y));

endmodule






