module odd_even_counter(
    input        clk,
    input        rst,
    input        odd_even,   // 0 = even, 1 = odd
    input        enable,
    output reg [3:0] count
);

    always @(posedge clk) begin
        if (rst) begin
            if (odd_even)
                count <= 4'b0001;   // odd start
            else
                count <= 4'b0000;   // even start
        end
        else if (enable) begin
            count <= count + 4'd2;  // step by 2
        end
        // else: hold count
    end

endmodule   

