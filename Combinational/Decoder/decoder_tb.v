// -------------------------------------------------------------
// Testbench for 2-to-4 Decoder
module decoder_tb;

reg  [1:0] data;   // 2-bit input driven by testbench
wire [3:0] out;    // 4-bit output driven by DUT

// Instantiate the Design Under Test (DUT)
decoder d1 (
    .data(data),
    .out(out)
);

initial begin
    // Create waveform output file
    $dumpfile("decoder_tb.vcd");
    $dumpvars(0, decoder_tb);

    // Print signal values whenever any change occurs
    $monitor($time, " data=%b out=%b", data, out);

    // Apply all 2-bit input combinations
    data = 2'b00; #10;   // Expect out = 0001
    data = 2'b01; #10;   // Expect out = 0010
    data = 2'b10; #10;   // Expect out = 0100
    data = 2'b11; #10;   // Expect out = 1000

    $finish;             // End simulation
end

endmodule
