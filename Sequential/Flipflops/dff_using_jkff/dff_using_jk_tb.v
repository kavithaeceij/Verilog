module tb_dff_using_jk;

    reg clk;
    reg reset;
    reg d;
    wire q;

    // Instantiate DUT
    dff_using_jk dut (
        .clk(clk),
        .reset(reset),
        .d(d),
        .q(q)
    );

    // Clock generation: 10 time unit period
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk   = 0;
        reset = 1;
        d     = 0;

        // Apply reset
        #10 reset = 0;

        // Apply D values
        #10 d = 1;
        #10 d = 0;
        #10 d = 1;
        #10 d = 1;
        #10 d = 0;

        #20 $finish;
    end

    // Monitor for console
    initial begin
        $monitor("Time=%0t | reset=%b | d=%b | q=%b", $time, reset, d, q);
    end
     initial begin
        $dumpfile("waves.vcd");
        $dumpvars(0, tb_dff_using_jk);
    end


endmodule
