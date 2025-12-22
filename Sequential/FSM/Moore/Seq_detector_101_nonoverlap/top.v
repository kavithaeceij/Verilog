`timescale 1ns / 1ps

module top;

    reg clk;
    reg rst;
    reg in;
    wire detect;

    // Instantiate DUT
    seq_detector_101_non_overlap dut (
        .clk(clk),
        .rst(rst),
        .in(in),
        .detect(detect)
    );

    // -----------------------------------------------------
    // Clock generation: 10 time-unit period
    // -----------------------------------------------------
    always #5 clk = ~clk;

    // -----------------------------------------------------
    // Test stimulus
    // -----------------------------------------------------
    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        in  = 0;

        // Apply reset for 2 clock cycles
        #12;
        rst = 0;

        // Apply input sequence: 1 0 1 0 1
     
        #10 in = 1;   // 1
        #10 in = 0;   // 0
        #10 in = 1;   // 1 -> DETECT = 1
        #10 in = 0;   // 0
        #10 in = 1;   // 1 -> no second detect

        #20 $finish;
    end

    // -----------------------------------------------------
    // Monitor for debugging
    // -----------------------------------------------------
    initial begin
        $monitor("Time=%0t | in=%b | detect=%b",
                  $time, in, detect);
    end
     // Dump waveform
    initial begin
        $dumpfile("waves.vcd");
        $dumpvars(0, top);
    end


endmodule
