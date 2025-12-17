module tb_dff_using_t;

    reg clk;
    reg reset;
    reg d;
    wire q;

    // DUT instantiation
    dff_using_t dut (
        .clk(clk),
        .reset(reset),
        .d(d),
        .q(q)
    );

    // Clock generation (10 time units period)
    always #5 clk = ~clk;

    initial begin
        // Initial values
        clk   = 0;
        reset = 1;
        d     = 0;

        // Apply reset
        #10 reset = 0;

        // Change D between clock edges
        #10 d = 0;   // q should stay 0
        #10 d = 1;   // q should become 1 at next clk
        #10 d = 1;   // q should stay 1
        #10 d = 0;   // q should become 0 at next clk

        #20 $finish;
    end

    // Monitor output
    initial begin
        $monitor("Time=%0t | clk=%b | reset=%b | d=%b | q=%b",
                  $time, clk, reset, d, q);
    end
    initial begin
        $dumpfile("waves.vcd");
        $dumpvars(0, tb_dff_using_t);
    end


endmodule

