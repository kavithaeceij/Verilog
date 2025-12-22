`timescale 1ns / 1ps
module dff_using_sr_tb;
reg clk,d,reset;
wire q;
dff_using_sr dut(clk,d,reset,q);
initial begin
    clk = 0; d = 0; reset = 0;
    forever #5 clk = ~clk;
end
initial begin
    #5 reset = 0;
    repeat (20) begin

    	    @(negedge clk)
        d = $urandom_range(0,1);
        #3;
    end
    $finish;
end
//always @(posedge clk)
   // $display("POSEDGE @%0t : d=%b q=%b RST=%b", $time, d, q,reset);
always @(posedge clk)
    $strobe("AFTER CLK: d=%b q=%b RST=%b", d, q,reset);
initial begin
    reset = 0; #28;
    reset = 1; #10;
    reset = 0; #10;
    reset = 1; #10;
    reset = 0;
end
initial begin
   // $monitor($time," clk=%b reset=%b d=%b q=%b", clk, reset, d, q);
        $dumpfile("dff_using_sr.vcd");
    $dumpvars(0,dff_using_sr_tb);
end
endmodule

/*
* OUTPUT
VCD info: dumpfile dff_using_sr.vcd opened for output.
                   0 clk=0 reset=0 d=0 q=x
                   5 clk=1 reset=0 d=1 q=x
                   8 clk=1 reset=0 d=0 q=x
                  10 clk=0 reset=0 d=0 q=x
                  15 clk=1 reset=0 d=0 q=0
                  17 clk=1 reset=0 d=1 q=0
                  20 clk=0 reset=0 d=1 q=0
                  23 clk=0 reset=0 d=0 q=0
                  25 clk=1 reset=0 d=0 q=0
                  28 clk=1 reset=1 d=0 q=0
                  29 clk=1 reset=1 d=1 q=0
                  30 clk=0 reset=1 d=1 q=0
                  35 clk=1 reset=1 d=1 q=0
                  38 clk=1 reset=0 d=1 q=0
                  40 clk=0 reset=0 d=1 q=0
                  45 clk=1 reset=0 d=1 q=1
                  48 clk=1 reset=1 d=1 q=1
                  50 clk=0 reset=1 d=0 q=1
                  55 clk=1 reset=1 d=0 q=0
                  58 clk=1 reset=0 d=0 q=0
                  59 clk=1 reset=0 d=1 q=0
                  60 clk=0 reset=0 d=1 q=0
                  62 clk=0 reset=0 d=0 q=0
dff_using_sr_tb.v:15: $finish called at 65 (1s)
                  65 clk=1 reset=0 d=0 q=0
* 
*/
