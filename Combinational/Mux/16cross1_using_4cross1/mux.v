module mux_4cross1 (
    input  [3:0] data,
    input  [1:0] sel,
    output reg   y
);

always @(*) begin
    case (sel)
        2'b00: y = data[0];
        2'b01: y = data[1];
        2'b10: y = data[2];
        2'b11: y = data[3];
        default: y = 1'b0;
    endcase
end

endmodule

module mux_16cross1 (
    input  [15:0] data,
    input  [3:0]  sel,
    output        y
);

wire a, b, c, d;

    // First stage: 4 groups of 4 inputs
    mux_4cross1 m1 (
        .data(data[3:0]),
        .sel (sel[1:0]),
        .y   (a)
    );

    mux_4cross1 m2 (
        .data(data[7:4]),
        .sel (sel[1:0]),
        .y   (b)
    );

    mux_4cross1 m3 (
        .data(data[11:8]),
        .sel (sel[1:0]),
        .y   (c)
    );

    mux_4cross1 m4 (
        .data(data[15:12]),
        .sel (sel[1:0]),
        .y   (d)
    );

    // Second stage: select one of the four outputs
    mux_4cross1 m5 (
        .data({d, c, b, a}),
        .sel (sel[3:2]),
        .y   (y)
    );

endmodule
