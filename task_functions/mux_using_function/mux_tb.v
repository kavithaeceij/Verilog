// --------------------------------------------------
// Testbench for mux2_using_function
// --------------------------------------------------
module tb_function_mux2;

    reg  a;
    reg  b;
    reg  sel;
    wire y;

    // DUT instantiation
    mux2_using_function dut (
        .a   (a),
        .b   (b),
        .sel (sel),
        .y   (y)
    );

    // -------------------------
    // Waveform dump
    // -------------------------
    initial begin
        $dumpfile("function_mux2.vcd");
        $dumpvars(0, tb_function_mux2);
    end

    // -------------------------
    // Stimulus
    // -------------------------
    initial begin
        $display("Time | a b sel | y");
        $display("-------------------");

        // Test all combinations
        a = 0; b = 0; sel = 0; #10;
        $display("%4t | %b %b  %b  | %b", $time, a, b, sel, y);

        a = 0; b = 1; sel = 0; #10;
        $display("%4t | %b %b  %b  | %b", $time, a, b, sel, y);

        a = 1; b = 0; sel = 0; #10;
        $display("%4t | %b %b  %b  | %b", $time, a, b, sel, y);

        a = 1; b = 1; sel = 0; #10;
        $display("%4t | %b %b  %b  | %b", $time, a, b, sel, y);

        a = 0; b = 0; sel = 1; #10;
        $display("%4t | %b %b  %b  | %b", $time, a, b, sel, y);

        a = 0; b = 1; sel = 1; #10;
        $display("%4t | %b %b  %b  | %b", $time, a, b, sel, y);

        a = 1; b = 0; sel = 1; #10;
        $display("%4t | %b %b  %b  | %b", $time, a, b, sel, y);

        a = 1; b = 1; sel = 1; #10;
        $display("%4t | %b %b  %b  | %b", $time, a, b, sel, y);

        $finish;
    end

endmodule
