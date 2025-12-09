// -------------------------------------------------------------
// 4-to-2 Priority Encoder
// -------------------------------------------------------------
// Priority: data[3] > data[2] > data[1] > data[0]
// 
// Examples:
//   data = 0001 -> y = 00
//   data = 0010 -> y = 01
//   data = 0100 -> y = 10
//   data = 1000 -> y = 11
//   data = 0110 -> y = 10 (bit2 has higher priority than bit1)
//   data = 1111 -> y = 11 (bit3 wins)
// -------------------------------------------------------------

module priority_encoder(
    input  [3:0] data,   // 4-bit input, multiple bits may be 1
    output reg [1:0] y   // 2-bit encoded output
);

always @(*) begin
    // Default assignment to avoid latch when data == 4'b0000
    y = 2'b00;

    if (data[3]) begin
        y = 2'b11;      // Highest priority
    end
    else if (data[2]) begin
        y = 2'b10;
    end
    else if (data[1]) begin
        y = 2'b01;
    end
    else if (data[0]) begin
        y = 2'b00;      // Lowest priority
    end
    // If all bits are 0, y stays 2'b00 (from default)
end

endmodule


