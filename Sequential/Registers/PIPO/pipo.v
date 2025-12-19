module pipo (
    input        clk,     // Clock
    input        rst,     // Synchronous reset
    input        enable,  // Load enable
    input  [3:0] pin,     // Parallel input
    output reg [3:0] pout // Parallel output
);

    always @(posedge clk) begin
        if (rst) begin
            // Clear output on reset
            pout <= 4'b0000;
        end
        else if (enable) begin
            // Load parallel data
            pout <= pin;
        end
        // else: hold previous value
    end

endmodule

