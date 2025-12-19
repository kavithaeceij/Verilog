module reg_nbit_tb;

    // Parameter for testbench (must match DUT override)
    parameter BITWIDTH = 16;

    reg                    clk;
    reg                    rst_n;
    reg                    enable;
    reg  [BITWIDTH-1:0]    a;
    wire [BITWIDTH-1:0]    q;

    // Instantiate DUT with parameter override
    reg_nbit #(
        .BITWIDTH(BITWIDTH)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
        .a(a),
        .q(q)
    );

    // Clock generation: 10 time unit period
    always #5 clk = ~clk;

    initial begin
        // Initial values
        clk    = 0;
        rst_n    = 0;
        enable = 0;
        a      = 0;

        // Hold reset for 2 clock edges
        #12;
        rst_n = 1;

        // Enable = 1 → register should load data
        #10 enable = 1; a = 16'h00AA;
        #10 a = 16'h1234;
        #10 a = 16'hFFFF;

        // Disable enable → register should hold value
        #10 enable = 0; a = 16'h5555;

        // Assert reset again (sync reset)
        #10 rst_n = 0;
        #10 rst_n = 1;

        // Load new data after reset
        #10 enable = 1; a = 16'h00F0;

        #20 $finish;
    end
    initial begin
        // VCD dump for waveform
        $dumpfile("waves.vcd");
        $dumpvars(0, reg_nbit_tb);
end


endmodule
