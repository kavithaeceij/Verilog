module piso_tb;

    reg        clk;
    reg        rst;
    reg [3:0]  pin;
    reg        load;
    reg        shift_right;
    wire       sout;

    // Instantiate DUT
    piso dut (
        .clk(clk),
        .rst(rst),
        .pin(pin),
        .load(load),
        .shift_right(shift_right),
        .sout(sout)
    );

    // Clock generation: 10 time unit period
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        load = 0;
        shift_right = 0;
        pin = 4'b0000;

        // Apply reset
        #12;
        rst = 0;

        // -----------------------------
        // Load parallel data (ONE clock)
        // -----------------------------
        #3;
        pin = 4'b0101;   // Data to be transmitted serially
        load = 1;
        #10;
        load = 0;

        // -----------------------------
        // Shift data out serially
        // -----------------------------
        shift_right = 1;
        #40;             // 4 clock cycles (one per bit)
        shift_right = 0;

        // End simulation
        #20;
        $finish;
    end

    // Dump waveform
    initial begin
        $dumpfile("piso.vcd");
        $dumpvars(0, piso_tb);
    end

endmodule
