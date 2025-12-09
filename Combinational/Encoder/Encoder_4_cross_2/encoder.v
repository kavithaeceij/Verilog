`timescale 1ns/1ps
// -------------------------------------------------------------
// 4-to-2 Encoder (Behavioral, Case Modeling)
// -------------------------------------------------------------
// in : one-hot input (only one bit should be 1)
// y  : 2-bit encoded binary output
//
// -------------------------------------------------------------

module encoder(input [3:0] data, output reg [1:0] y);

always @(*) begin
    case (data)
        4'b0001: y = 2'b00;
        4'b0010: y = 2'b01;
        4'b0100: y = 2'b10;
        4'b1000: y = 2'b11;
        default: y = 2'b00;   // Safe default
    endcase
end

endmodule
