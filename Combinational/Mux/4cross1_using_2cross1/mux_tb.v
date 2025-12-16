`timescale 1ns/1ps

module tb_mux_4cross1;

    reg  [3:0] d;      // Inputs to the mux
    reg  [1:0] sel;    // Select lines
    wire y;            // Output

    // Instantiate DUT
    mux_4cross1 uut (
        .d(d),
        .sel(sel),
        .y(y)
    );
      // -------------------------
    // Waveform dump block
    // -------------------------
    initial begin
        $dumpfile("mux_4x1_tb.vcd");
        $dumpvars(0, tb_mux_4cross1);
    end


    initial begin
        // Display header
        $display("Time | d3 d2 d1 d0 | sel | y");
        $display("----------------------------------");

        // Apply test vectors
        d = 4'b1010;   // d3=1 d2=0 d1=1 d0=0

        sel = 2'b00; #10;   // Expect y = d0 = 0
        $display("%4t | %b | %b  | %b", $time, d, sel, y);

        sel = 2'b01; #10;   // Expect y = d1 = 1
        $display("%4t | %b | %b  | %b", $time, d, sel, y);

        sel = 2'b10; #10;   // Expect y = d2 = 0
        $display("%4t | %b | %b  | %b", $time, d, sel, y);

        sel = 2'b11; #10;   // Expect y = d3 = 1
        $display("%4t | %b | %b  | %b", $time, d, sel, y);

        // Change data
        d = 4'b1101;

        sel = 2'b00; #10;   // y = d0 = 1
        $display("%4t | %b | %b  | %b", $time, d, sel, y);

        sel = 2'b01; #10;   // y = d1 = 0
        $display("%4t | %b | %b  | %b", $time, d, sel, y);

        sel = 2'b10; #10;   // y = d2 = 1
        $display("%4t | %b | %b  | %b", $time, d, sel, y);

        sel = 2'b11; #10;   // y = d3 = 1
        $display("%4t | %b | %b  | %b", $time, d, sel, y);
   
        $finish;
    end

endmodule
