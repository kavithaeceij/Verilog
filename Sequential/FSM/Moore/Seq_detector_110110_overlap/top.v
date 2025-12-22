// ---------------------------------------------------------
// Testbench for Overlapping Sequence Detector 110110
// ---------------------------------------------------------
module top;

    reg clk;
    reg rst;
    reg in;
    wire detect;

    // Instantiate DUT
    seq_detector_110110_overlap dut (
        .clk(clk),
        .rst(rst),
        .in(in),
        .detect(detect)
    );

    // -----------------------------------------------------
    // Clock generation (10 time-unit period)
    // -----------------------------------------------------
    always #5 clk = ~clk;

    // -----------------------------------------------------
    // Test stimulus
    // -----------------------------------------------------
    initial begin
        clk = 0;
        rst = 1;
        in  = 0;

        // Apply reset
        #12 rst = 0;

        // Input sequence: 110110110
        // Because OVERLAPPING is enabled,
        // detection should happen TWICE

        #10 in = 1;   // 1
        #10 in = 1;   // 11
        #10 in = 0;   // 110
        #10 in = 1;   // 1101
        #10 in = 1;   // 11011
        #10 in = 0;   // 110110 -> DETECT = 1

        #10 in = 1;   // overlap starts (110)
        #10 in = 1;
        #10 in = 0;   // 110110 -> DETECT = 1 again

        #20 $finish;
    end

    // -----------------------------------------------------
    // Monitor for easy debugging
    // -----------------------------------------------------
    initial begin
        $monitor("Time=%0t | in=%b | detect=%b",
                  $time, in, detect);
    end

endmodule
