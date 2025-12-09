`timescale 1ns/1ps

module parity_tb;

    reg  [3:0] data;
    reg        mode;
    wire       parity;

    // DUT instantiation
    parity dut (
        .data  (data),
        .mode  (mode),
        .parity(parity)
    );

    initial begin
        $monitor("time=%0t  data=%b  mode=%b  parity=%b",
                 $time, data, mode, parity);

        // Test EVEN parity (mode = 0)
        mode = 1'b0;

        data = 4'b0000; #10;   // 0 ones → parity 0
        data = 4'b0001; #10;   // 1 one  → parity 1
        data = 4'b0011; #10;   // 2 ones → parity 0
        data = 4'b0101; #10;   // 2 ones → parity 0
        data = 4'b0111; #10;   // 3 ones → parity 1

        // Test ODD parity (mode = 1)
        mode = 1'b1;

        data = 4'b0000; #10;   // 0 ones → parity 1 (to make total odd)
        data = 4'b0001; #10;   // 1 one  → parity 0
        data = 4'b0011; #10;   // 2 ones → parity 1
        data = 4'b0101; #10;   // 2 ones → parity 1
        data = 4'b0111; #10;   // 3 ones → parity 0

        #20 $finish;
    end

    initial begin
        $dumpfile("parity_tb.vcd");
        $dumpvars(0, parity_tb);
    end

endmodule
