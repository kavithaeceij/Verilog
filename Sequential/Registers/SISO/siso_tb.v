// ------------------------------------------------------------
// Testbench for SISO shift register
// ------------------------------------------------------------

module siso_tb;

    reg clk;
    reg rst;
    reg sin;
    wire sout;

    // Instantiate DUT
    siso s1 (
        .clk(clk),
        .rst(rst),
        .sin(sin),
        .sout(sout)
    );

    // Clock generation: 10 time unit period
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        sin = 0;

        // Hold reset for 2 clock cycles
        #12;
        rst = 0;

        // Apply serial input bits
        #10 sin = 1;
        #10 sin = 0;
        #10 sin = 1;
        #10 sin = 1;

        #20 $finish;
    end

    // Dump waveform
    initial begin
        $dumpfile("waves.vcd");
        $dumpvars(0, siso_tb);
    end

endmodule    
     
