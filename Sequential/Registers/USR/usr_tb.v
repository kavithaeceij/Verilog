module usr_tb;

    reg        clk;
    reg        rst;
    reg  [1:0] mode;
    reg  [3:0] data;
    wire [3:0] y;

    // Instantiate DUT
    usr dut (
        .clk(clk),
        .rst(rst),
        .mode(mode),
        .data(data),
        .y(y)
    );

    // Clock generation: 10 time unit period
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk  = 0;
        rst  = 1;
        mode = 2'b00;
        data = 4'b0000;

        // Apply reset
        #12;
        rst = 0;

        // -----------------------------
        // Parallel Load
        // -----------------------------
        data = 4'b1011;
        mode = 2'b01;   // load
        #10;

        // -----------------------------
        // Hold
        // -----------------------------
        mode = 2'b00;   // hold
        #10;

        // -----------------------------
        // Shift Right (4 clocks)
        // -----------------------------
        mode = 2'b10;
        #40;

        // -----------------------------
        // Parallel Load again
        // -----------------------------
        data = 4'b1101;
        mode = 2'b01;
        #10;

        // -----------------------------
        // Shift Left (4 clocks)
        // -----------------------------
        mode = 2'b11;
        #40;

        // End simulation
        #20;
        $finish;
    end

    // Dump waveform
    initial begin
        $dumpfile("usr.vcd");
        $dumpvars(0, usr_tb);
    end

endmodule
