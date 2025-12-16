module dff_tb;

    reg clk;
    reg reset;
    reg d;
    wire q;

    // DUT instantiation
    dff uut (
        .clk  (clk),
        .reset(reset),
        .d    (d),
        .q    (q)
    );

    // ----------------------------------
    // Clock generation TASK
    // ----------------------------------
    task clock_gen;
        begin
            forever begin
                clk = 1'b0;
                #5;
                clk = 1'b1;
                #5;
            end
        end
    endtask

    // ----------------------------------
    // Start clock
    // ----------------------------------
    initial begin
        clock_gen;
    end

    // ----------------------------------
    // Stimulus
    // ----------------------------------
    initial begin
        // Waveform
        $dumpfile("dff.vcd");
        $dumpvars(0, dff_tb);

        // Initialize signals
        clk   = 0;
        reset = 1;
        d     = 0;

        // Hold reset for some time
        #12;
        reset = 0;     // release reset

        // Apply data
        #10 d = 1;
        #10 d = 0;
        #10 d = 1;

        // Assert reset again
        #7  reset = 1;
        #10 reset = 0;

        #20;
        $finish;
    end

endmodule
