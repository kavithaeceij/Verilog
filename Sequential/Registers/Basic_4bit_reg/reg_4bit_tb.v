`timescale 1ns/1ps
module reg4bit_tb;

    reg        clk;
    reg        rst;
    reg  [3:0] a;
    wire [3:0] q;

    // Instantiate the DUT (Device Under Test)
    reg4bit dut (
        .clk(clk),
        .rst(rst),
        .a(a),
        .q(q)
    );

    // Clock generation: 10 time unit period
    always #5 clk = ~clk;

    initial begin
        // Initial values
        clk = 0;
        rst = 1;
        a   = 4'b0000;

        // Hold reset for 2 clock cycles
        #12;
        rst = 0;

        // Apply input data
        #10 a = 4'b0011;
        #10 a = 4'b1010;
        #10 a = 4'b1111;

        // Assert reset again
        #10 rst = 1;
        #10 rst = 0;

        // New data after reset
        #10 a = 4'b0101;

        // End simulation
        #20 $finish;
    end

endmodule
