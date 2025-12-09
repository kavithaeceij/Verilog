// 2:1 Multiplexer
// sel = 0 → y = d0
// sel = 1 → y = d1

module mux2(
    input  d0,      // Input 0
    input  d1,      // Input 1
    input  sel,     // Select line
    output y        // Output of mux
);

    // Continuous assignment (combinational logic)
    assign y = sel ? d1 : d0;

endmodule

