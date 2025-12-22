// ---------------------------------------------------------
// Non-overlapping Sequence Detector for pattern "101"
// Moore FSM (output depends only on state)
// ---------------------------------------------------------
module seq_detector_101_non_overlap (
    input  clk,        // Clock
    input  rst,        // Synchronous reset (active high)
    input  in,         // Serial input bit
    output reg detect  // Output: 1 when "101" is detected
);

    // -----------------------------------------------------
    // State encoding
    // We need 4 states -> 2 bits are sufficient
    // -----------------------------------------------------
    parameter S0 = 2'b00,  // No match
              S1 = 2'b01,  // Seen '1'
              S2 = 2'b10,  // Seen '10'
              S3 = 2'b11;  // Seen '101' (detect state)

    // -----------------------------------------------------
    // State registers
    // current_state : present state (stored in flip-flops)
    // next_state    : next state (combinational decision)
    // -----------------------------------------------------
    reg [1:0] current_state, next_state;

    // -----------------------------------------------------
    // 1. State register (sequential logic)
    // Updates state only on clock edge
    // -----------------------------------------------------
    always @(posedge clk) begin
        if (rst)
            current_state <= S0;      // Reset FSM to initial state
        else
            current_state <= next_state;
    end

    // -----------------------------------------------------
    // 2. Next-state logic (combinational)
    // Determines where to go next
    // -----------------------------------------------------
    always @(*) begin
        // Default assignment avoids latches
        next_state = current_state;

        case (current_state)

            // No match yet
            S0: begin
                if (in)
                    next_state = S1;  // First '1' matched
                else
                    next_state = S0;
            end

            // Seen '1'
            S1: begin
                if (in)
                    next_state = S1;  // Still seeing '1'
                else
                    next_state = S2;  // Seen '10'
            end

            // Seen '10'
            S2: begin
                if (in)
                    next_state = S3;  // Seen '101' -> detect
                else
                    next_state = S0;  // Match broken
            end

            // Seen '101' (NON-overlapping)
            S3: begin
                next_state = S0;      // Reset after detection
            end

            default: next_state = S0;
        endcase
    end

    // -----------------------------------------------------
    // 3. Output logic (Moore FSM)
    // Output depends ONLY on current state
    // -----------------------------------------------------
    always @(*) begin
        detect = 1'b0;                // Default
        if (current_state == S3)
            detect = 1'b1;            // Assert when pattern detected
    end

endmodule
