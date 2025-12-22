`timescale 1ns / 1ps

module jkff_using_sr_tb;
reg clk, reset, j, k;
wire q;
jkff_using_sr dut(clk, reset, j, k, q);
initial begin
    clk = 0; {j,k} = 0;
    forever #5 clk = ~clk;
end
initial begin
    repeat (20) begin
        {j,k} = $urandom_range(2'b00,2'b11);
        #3;
    end
    $finish;
end
initial begin
    reset = 0; #28;
    reset = 1; #10;
    reset = 0;
end
initial begin
    $monitor($time," clk=%b reset=%b j=%b k=%b q=%b", clk, reset, j, k, q);
    $dumpfile("jkff_using_sr.vcd");
    $dumpvars(0,jkff_using_sr_tb);
end
endmodule

/*
* OUTPUT
VCD info: dumpfile jkff_using_sr.vcd opened for output.
                   0 clk=0 reset=0 j=1 k=0 q=x
                   3 clk=0 reset=0 j=0 k=1 q=x
                   5 clk=1 reset=0 j=0 k=1 q=x
                   6 clk=1 reset=0 j=0 k=0 q=x
                  10 clk=0 reset=0 j=0 k=0 q=x
                  12 clk=0 reset=0 j=1 k=0 q=x
                  15 clk=1 reset=0 j=1 k=1 q=x
                  18 clk=1 reset=0 j=0 k=0 q=x
                  20 clk=0 reset=0 j=0 k=0 q=x
                  24 clk=0 reset=0 j=1 k=0 q=x
                  25 clk=1 reset=0 j=1 k=0 q=x
                  28 clk=1 reset=1 j=1 k=0 q=x
                  30 clk=0 reset=1 j=1 k=0 q=x
                  35 clk=1 reset=1 j=1 k=0 q=0
                  36 clk=1 reset=1 j=1 k=1 q=0
                  38 clk=1 reset=0 j=1 k=1 q=0
                  40 clk=0 reset=0 j=1 k=1 q=0
                  45 clk=1 reset=0 j=0 k=1 q=1
                  50 clk=0 reset=0 j=0 k=1 q=1
                  54 clk=0 reset=0 j=1 k=1 q=1
                  55 clk=1 reset=0 j=1 k=1 q=0
                  57 clk=1 reset=0 j=0 k=0 q=0
jkff_using_sr_tb.v:14: $finish called at 60 (1s)
                  60 clk=0 reset=0 j=0 k=0 q=0
* 
*/
