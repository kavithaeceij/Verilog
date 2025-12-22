module dff_using_sr(
    input clk,d,reset,
    output q
);
srff dut1(clk, reset, d, ~d, q);
endmodule

module srff(
    input clk, reset, s, r,
    output reg q
);
always @(posedge clk) begin
    if(reset) q<=0;
    else begin
        case({s,r})
            2'b00: q <= q;
            2'b01: q <= 1'b0;
            2'b10: q <= 1'b1;
            2'b11: q <= 1'bx;
        endcase
    end
end
endmodule
