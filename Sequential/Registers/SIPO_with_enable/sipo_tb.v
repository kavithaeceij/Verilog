// ------------------------------------------------------------
// Testbench for SIPO shift register
// ------------------------------------------------------------

// ------------------------------------------------------------
// Testbench for SIPO with Enable
// ------------------------------------------------------------

module sipo_tb;

    reg        clk;
    reg        rst;
    reg        sin;
    reg        enable;
    wire [3:0] sout;

    // Instantiate DUT
    sipo dut (
        .clk(clk),
        .rst(rst),
        .sin(sin),
        .enable(enable),
        .sout(sout)
    );

    // Clock generation: 10 time unit period
    always #5 clk = ~clk;

    initial begin
        // Initialize inputs
        clk    = 0;
        rst    = 1;
        sin    = 0;
        enable = 0;

        // Hold reset for 2 clock edges
        #12;
        rst = 0;

        // Enable shifting
        enable = 1;

        // Apply serial input bits (1 per clock)
        #10 sin = 1;   // shift 1
        #10 sin = 0;   // shift 2

        // Disable shifting for one clock
        enable = 0;
        #10;           // no shift happens here

        // Enable shifting again
        enable = 1;
        #10 sin = 1;   // shift 3
        #10 sin = 1;   // shift 4

        #20 $finish;
    end

    // Dump waveform
    initial begin
        $dumpfile("waves.vcd");
        $dumpvars(0, sipo_tb);
    end

endmodule
