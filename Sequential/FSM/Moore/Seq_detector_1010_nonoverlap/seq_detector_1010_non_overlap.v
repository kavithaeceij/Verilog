module seq_detector_1010_non_overlap (
    input  clk,        // Clock
    input  rst,        // Synchronous reset (active high)
    input  in,         // Serial input bit
    output reg detect  // Output: 1 when "1010" is detected
);
 parameter S0 = 3'b000;
 parameter S1 = 3'b001;
 parameter S2 = 3'b010;
 parameter S3 = 3'b011;
 parameter S4 = 3'b100;

reg [2:0] current_state, next_state;

always@(posedge clk)begin
  if (rst)
      current_state <= S0;
  else
       current_state <= next_state;
end
always@(*) begin
       next_state = current_state;
 case(current_state)
    S0 : begin//0
     if(in)
      next_state = S1;
     else
      next_state = S0;end
    S1: begin //1
       if(in)
          next_state = S1;
       else
          next_state = S2;end
    S2 : begin//10
           if(in)
          next_state = S3;
       else
          next_state = S0;end
   S3 : begin//101
           if(in)
          next_state = S1;
       else
          next_state = S4;end
  S4 :begin
        next_state = S0;
   end
   default : next_state = S0;
  endcase
end

always@(*) begin
   detect = 1'b0;
 if(current_state == S4)
   detect = 1'b1;
  end
endmodule

        



      
