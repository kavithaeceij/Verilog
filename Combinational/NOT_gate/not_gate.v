// Simple Not gate
module not_gate(a,o);             // Module declaration with ports a (input) and o (output)
input a;                          // 'a' is a 1-bit input
output o;                         // 'o' is a 1-bit output

assign o = ~a;                    // Dataflow modeling: output 'o' is bitwise NOT of input 'a'

endmodule                         // End of NOT gate design module

//Testbench
module top;                       // Testbench module (no ports)
reg a;                            // 'a' is declared as reg because testbench drives it
wire o;                           // 'o' is wire because it receives output from design

not_gate n1(.a(a),.o(o));         // Instantiating the not_gate module
                                  // .a(a) → connect testbench 'a' to module input 'a'
                                  // .o(o) → connect testbench 'o' to module output 'o'

initial                           // Initial block starts at simulation time 0
 begin
   $monitor($time," output = %b input = %b",o,a);
                                  // $monitor prints values whenever 'a' or 'o' changes
                                  // %b prints binary values, $time prints current simulation time

        a = 0;                    // At time 0, set input 'a' to 0 → o becomes 1
       #10 a = 1;                 // At time 10, set 'a' to 1 → o becomes 0
       #10 a = 0;                 // At time 20, set 'a' to 0 → o becomes 1
       #10 a = 1;                 // At time 30, set 'a' to 1 → o becomes 0
   end                            // End of stimulus block
endmodule                         // End of testbench module
