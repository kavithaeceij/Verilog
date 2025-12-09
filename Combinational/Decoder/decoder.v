// -------------------------------------------------------------
// 2-to-4 Decoder using if–else (Behavioral Combinational Logic)
// -------------------------------------------------------------

//
// Style:
//   * always @(*)            → combinational procedural block
//   * blocking '='           → used for combinational assignments
//   * default assignment     → avoids latch inference
// -------------------------------------------------------------

module decoder(input [1:0] data, output reg [3:0] out);

always @(*) begin

    // Default value to avoid unintended latch creation
    out = 4'b0000;

    // Check all input combinations
    if (data == 2'b00) begin
        out = 4'b0001;
    end
    else if (data == 2'b01) begin
        out = 4'b0010;
    end
    else if (data == 2'b10) begin
        out = 4'b0100;
    end
    else if (data == 2'b11) begin
        out = 4'b1000;
    end
    else begin
        out = 4'b0000;   // Safe fallback (should not occur)
    end

end

endmodule    
