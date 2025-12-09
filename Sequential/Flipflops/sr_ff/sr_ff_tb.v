//=========================================================
// Testbench for SR flip-flop (sr_ff)
//=========================================================
module sr_ff_tb;

    // Testbench signals
    reg  clk;
    reg  reset_n;
    reg  s;
    reg  r;
    wire y;

    // DUT instantiation
    sr_ff dut (
        .clk    (clk),
        .reset_n(reset_n),sr_ff_tb.vcd
        .s      (s),
        .r      (r),
        .y      (y)
    );

    // Clock generation: 10 ns period (100 MHz)
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;    // toggle every 5 ns
    end

    // Stimulus: reset + S/R patterns
    initial begin
        // Initial values
        reset_n = 1'b0;  // start in reset (active-low)
        s       = 1'b0;
        r       = 1'b0;

        // Keep reset active for some time
        #15;
        reset_n = 1'b1;  // release reset

        // 1) S=0, R=0 → hold state
        #20;
        s = 1'b0;
        r = 1'b0;

        // 2) S=1, R=0 → set (y should go to 1)
        #20;
        s = 1'b1;
        r = 1'b0;

        // 3) S=0, R=1 → reset (y should go to 0)
        #20;
        s = 1'b0;
        r = 1'b1;

        // 4) S=1, R=1 → illegal condition
        #20;
        s = 1'b1;
        r = 1'b1;

        // 5) Back to hold (S=0, R=0) and observe behavior
        #20;
        s = 1'b0;
        r = 1'b0;

        // Run a bit more then finish
        #50;
        $finish;
    end

    // Monitor: print signal values whenever any changes
    initial begin
        $monitor("time=%0t  clk=%b  reset_n=%b  s=%b  r=%b  y=%b",
                 $time, clk, reset_n, s, r, y);
    end

    // Waveform dump for GTKWave or other viewers
    initial begin
        $dumpfile("sr_ff_tb.vcd");   // output VCD file name
        $dumpvars(0, sr_ff_tb);      // dump all signals in this TB hierarchy
    end

endmodule
