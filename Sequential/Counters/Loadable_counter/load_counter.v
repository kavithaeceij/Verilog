// ------------------------------------------------------------
// Module: load_counter
// Function:
//   - Synchronous 4-bit loadable up counter
// Priority:
//   reset > load > enable
// ------------------------------------------------------------
module load_counter (
    input        clk,        // Clock
    input        rst,        // Synchronous reset
    input        load,       // Load control
    input        enable,     // Count enable
    input  [3:0] data_in,    // Load value
    output reg [3:0] count   // Counter output
);

    always @(posedge clk) begin
        if (rst) begin
            count <= 4'b0000;           // Reset
        end
        else if (load) begin
            count <= data_in;           // Load has priority
        end
        else if (enable) begin
            count <= count + 1'b1;      // Increment
        end
        // else: hold count
    end

endmodule

