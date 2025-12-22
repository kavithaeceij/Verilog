module tb_seq_detector_1010_mealy_non_overlap;

    reg clk;
    reg rst;
    reg in;
    wire detect;

    // DUT instantiation
    seq_detector_1010_mealy_non_overlap dut (
        .clk(clk),
        .rst(rst),
        .in(in),
        .detect(detect)
    );

    // Clock generation: 10 time unit period
    always #5 clk = ~clk;

    initial begin
        // Initial values
        clk = 0;
        rst = 1;
        in  = 0;

        // Apply reset
        #12 rst = 0;

        // Input sequence: 1 0 1 0 1 0
        // Non-overlapping → detect should pulse only once per 1010

        #10 in = 1;   // 1
        #10 in = 0;   // 10
        #10 in = 1;   // 101
        #10 in = 0;   // 1010 -> DETECT = 1

        #10 in = 1;   // new sequence starts
        #10 in = 0;   // 10

        #20 $finish;
    end

    // Monitor for observation
    initial begin
        $monitor("Time=%0t | in=%b | detect=%b",
                  $time, in, detect);
    end

endmodule

