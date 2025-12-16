module tb_mux_16cross1;

    reg  [15:0] data;
    reg  [3:0]  sel;
    wire        y;

    // DUT instantiation
    mux_16cross1 uut (
        .data(data),
        .sel (sel),
        .y   (y)
    );

    // -------------------------
    // Waveform dump block
    // -------------------------
    initial begin
        $dumpfile("mux_16x1_tb.vcd");
        $dumpvars(0, tb_mux_16cross1);
    end

    // -------------------------
    // Stimulus block
    // -------------------------
integer i;

initial begin
    data = 16'b1011_0101_1100_0011;

    for (i = 0; i < 16; i = i + 1) begin
        sel = i[3:0];   // assign loop value to sel
        #10;
        $display("Time=%0t sel=%0d y=%b expected=%b",
                 $time, sel, y, data[sel]);
    end

    $finish;
end
  
endmodule
