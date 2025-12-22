module seq_detector_1010_mealy_non_overlap (
    input  clk,
    input  rst,        // synchronous reset
    input  in,         // serial input
    output reg detect  // goes high when 1010 is detected
);

    // State encoding
    parameter S0 = 2'b00,   // no match
              S1 = 2'b01,   // seen '1'
              S2 = 2'b10,   // seen '10'
              S3 = 2'b11;   // seen '101'

    reg [1:0] current_state, next_state;

    // 1. State register
    always @(posedge clk) begin
        if (rst)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // 2. Next-state + output logic (Mealy)
    always @(*) begin
        // defaults
        next_state = current_state;
        detect     = 1'b0;

        case (current_state)

            S0: begin // 0
                if (in)
                    next_state = S1;
            end

            S1: begin // 1
                if (in)
                    next_state = S1;
                else
                    next_state = S2;
            end

            S2: begin // 10
                if (in)
                    next_state = S3;
                else
                    next_state = S0;
            end

            S3: begin // 101
                if (!in) begin
                    detect     = 1'b1; // 1010 detected
                    next_state = S0;   // NON-overlap reset
                end
                else
                    next_state = S1;
            end

            default: next_state = S0;
        endcase
    end

endmodule
