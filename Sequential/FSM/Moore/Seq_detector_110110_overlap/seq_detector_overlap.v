module seq_detector_110110_overlap (
    input  clk,        // Clock
    input  rst,        // Synchronous reset (active high)
    input  in,         // Serial input bit
    output reg detect 
);

parameter S0 = 3'b000,
          S1 = 3'b001,
          S2 = 3'b010,
          S3 = 3'b011,
          S4 = 3'b100,
          S5 = 3'b101,
          S6 = 3'b110;

reg [2:0] current_state, next_state;

// State register
always @(posedge clk) begin
    if (rst)                                  
        current_state <= S0;
    else
        current_state <= next_state;
end

// Next-state logic (OVERLAPPING)
always @(*) begin
    next_state = current_state;

    case (current_state)

        S0 : begin //0
            if (in)
                next_state = S1;
            else
                next_state = S0;
        end

        S1 : begin //1
            if (in)
                next_state = S2;
            else
                next_state = S0;
        end             

        S2 : begin //11
            if (in)
                next_state = S2;
            else
                next_state = S3;
        end

        S3 : begin //110
            if (in)
                next_state = S4;
            else
                next_state = S3;
        end

        S4 : begin //1101
            if (in)
                next_state = S5;
            else
                next_state = S0;
        end

        S5 : begin //11011
            if (in)
                next_state = S2;
            else
                next_state = S6;
        end

        S6 : begin //110110
            next_state = S3;   // overlap: retain "110"
        end

        default : next_state = S0;
    endcase
end

// Output logic (Moore FSM)
always @(*) begin
    detect = 1'b0;
    if (current_state == S6)
        detect = 1'b1;
end

endmodule
