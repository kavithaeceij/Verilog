module pipo_tb;

    reg        clk;
    reg        rst;
    reg        enable;
    reg  [3:0] pin;
    wire [3:0] pout;

    // DUT
    pipo dut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .pin(pin),
        .pout(pout)
    );

    // Clock generation (10 time unit period)
    always #5 clk = ~clk;

    initial begin
        // Init
        clk = 0;
        rst = 1;
        enable = 0;
        pin = 4'b0000;

        // Reset
        #12;
        rst = 0;

        // Load data
        enable = 1;
        pin = 4'b1010;
        #10;

        // Change input but disable load
        enable = 0;
        pin = 4'b0101;
        #10;

        // Enable again
        enable = 1;
        #10;

        #20;
        $finish;
    end

    // Waveform dump
    initial begin
        $dumpfile("pipo.vcd");
        $dumpvars(0, pipo_tb);
    end

endmodule
