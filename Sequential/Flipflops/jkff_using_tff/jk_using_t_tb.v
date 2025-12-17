`timescale 1ns/1ps

module tb_jk_using_t;

    reg clk;
    reg reset;
    reg j, k;
    wire q;

    // DUT instantiation
    jk_using_t dut (
        .clk   (clk),
        .reset (reset),
        .j     (j),
        .k     (k),
        .q     (q)
    );

    // -------------------------------
    // Start CLOCK (runs forever)
    // -------------------------------
    initial begin
        clock_generation(clk);
    end

    // -------------------------------
    // Reset + Stimulus
    // -------------------------------
    initial begin
        // Initialize inputs
        j = 0;
        k = 0;

        // Apply reset
        reset_gen(reset);

        // 1) Hold: J=0, K=0
        #20 j = 0; k = 0;

        // 2) Reset: J=0, K=1
        #20 j = 0; k = 1;

        // 3) Set: J=1, K=0
        #20 j = 1; k = 0;

        // 4) Toggle: J=1, K=1
        #40 j = 1; k = 1;

        // 5) Hold again
        #20 j = 0; k = 0;

        #50 $finish;
    end

    // -------------------------------
    // Clock generation task
    // -------------------------------
    task clock_generation;
        output reg clock;
    begin
        clock = 0;
        forever #5 clock = ~clock;
    end
    endtask

    // -------------------------------
    // Reset generation task
    // -------------------------------
    task reset_gen;
        output reg reset;
    begin
        reset = 1;
        #10 reset = 0;
    end
    endtask

    // -------------------------------
    // Waveform dump
    // -------------------------------
    initial begin
        $dumpfile("jk_using_t_tb.vcd");
        $dumpvars(0, tb_jk_using_t);
    end

endmodule
 task clock_genration;
 output reg clock;
  begin 
   clock = 0;
  forever #5 clock = ~clock;
 end
endtask

task rst_gen;
output reg rst;
begin
 rst = 1;
#10 
 rst = 0;
end
endtask

  
    // VCD dump for GTKWave
    initial begin
        $dumpfile("waves.vcd");
        $dumpvars(0,tb_jk_using_t );
    end

endmodule
