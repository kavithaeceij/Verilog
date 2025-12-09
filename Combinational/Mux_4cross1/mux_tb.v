module mux_4_tb;

    reg       i0, i1, i2, i3;  // Inputs driven by testbench
    reg [1:0] sel;             // Select signal
    wire      y;               // Output from DUT

    // Instantiate Device Under Test (DUT)
    mux_4 m1 (
        .i0  (i0),
        .i1  (i1),
        .i2  (i2),
        .i3  (i3),
        .sel (sel),
        .y   (y)
    );

    initial begin
        // Dump waveform file for GTKWave
        $dumpfile("mux_4_tb.vcd");
        $dumpvars(0, mux_4_tb);

        // Display values whenever a change occurs
        $monitor($time, " sel=%b  i0=%b  i1=%b  i2=%b  i3=%b  y=%b", sel,i0,i1,i2,i3,y);

        // Apply test vectors
        sel = 2'b00; i0 = 1; i1 = 0; i2 = 0; i3 = 0; #10;   // Expect y = 1
        sel = 2'b01; i0 = 0; i1 = 1; i2 = 0; i3 = 0; #10;   // Expect y = 1
        sel = 2'b10; i0 = 0; i1 = 0; i2 = 1; i3 = 0; #10;   // Expect y = 1
        sel = 2'b11; i0 = 0; i1 = 0; i2 = 0; i3 = 1; #10;   // Expect y = 1

        $finish;   // End simulation
    end

endmodule
