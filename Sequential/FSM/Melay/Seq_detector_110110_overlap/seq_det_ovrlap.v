module seq_detector_110110_overlap (
    input  clk,
    input  rst,
    input  in,
    output reg detect
);

parameter S0 = 3'b000,
          S1 = 3'b001,
          S2 = 3'b010,
          S3 = 3'b011,
          S4 = 3'b100,
          S5 = 3'b101;

reg [2:0] current_state, next_state;

// State register
always @(posedge clk) begin
    if (rst)
        current_state <= S0;
    else
        current_state <= next_state;
end

// Next-state + output logic (MEALY, OVERLAPPING)
always @(*) begin
    next_state = current_state;
    detect     = 1'b0;   // default (IMPORTANT)

    case (current_state)

        S0 : begin //0
            if (in) next_state = S1;
        end

        S1 : begin //1
            if (in) next_state = S2;
            else    next_state = S0;
        end

        S2 : begin //11
            if (in) next_state = S2;
            else    next_state = S3;
        end

        S3 : begin //110
            if (in) next_state = S4;
            else    next_state = S3;
        end

        S4 : begin //1101
            if (in) next_state = S5;
            else    next_state = S0;
        end

        S5 : begin //11011
            if (in)
                next_state = S2;
            else begin
                detect     = 1'b1; // 110110 detected
                next_state = S3;   // OVERLAP: retain "110"
            end
        end

        default : next_state = S0;
    endcase
end

endmodule
