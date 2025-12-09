module tb_mux2;

    reg  d0;
    reg  d1;
    reg  sel;
    wire y;

    // Instantiate DUT (Design Under Test)
    mux2 m1 (
        .d0  (d0),
        .d1  (d1),
        .sel (sel),
        .y   (y)
    );

    initial begin
        // Create waveform dump file
        $dumpfile("mux2_wave.vcd");
        $dumpvars(0, tb_mux2);

        // Display changes in console
        $monitor($time, " sel=%b d0=%b d1=%b y=%b", sel, d0, d1, y);

        // Testcases
        sel = 0; d0 = 0; d1 = 1; #10;   
        sel = 1; d0 = 0; d1 = 1; #10;   
        sel = 0; d0 = 1; d1 = 0; #10;   
        sel = 1; d0 = 1; d1 = 0; #10;   

        $finish;
    end

endmodule
