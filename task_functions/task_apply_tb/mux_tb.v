module task_apply_stimulus_tb;

    reg  a;
    reg  b;
    reg  sel;
    wire y;

    // Instantiate DUT
    mux_2x1 dut (
        .a(a),
        .b(b),
        .sel(sel),
        .y(y)
    );

    // --------------------------------------------------
    // Task: apply_inputs
    // Purpose:
    //   - Apply inputs to the DUT
    //   - Wait for some time
    // --------------------------------------------------
    task apply_inputs;
        input a_in;
        input b_in;
        input sel_in;
        begin
            a   = a_in;
            b   = b_in;
            sel = sel_in;
            #10;                // Timing allowed in task
        end
    endtask


    // --------------------------------------------------
    // Test sequence
    // --------------------------------------------------
    initial begin
        // Waveform
        $dumpfile("task_apply_stimulus.vcd");
        $dumpvars(0, task_apply_stimulus_tb);

        $display("a b sel | y");
        $display("-----------");

        // Use task instead of repeated assignments
        apply_inputs(0, 0, 0);  $display("%b %b  %b  | %b", a, b, sel, y);
        apply_inputs(0, 1, 0);  $display("%b %b  %b  | %b", a, b, sel, y);
        apply_inputs(1, 0, 0);  $display("%b %b  %b  | %b", a, b, sel, y);

        apply_inputs(0, 0, 1);  $display("%b %b  %b  | %b", a, b, sel, y);
        apply_inputs(0, 1, 1);  $display("%b %b  %b  | %b", a, b, sel, y);
        apply_inputs(1, 0, 1);  $display("%b %b  %b  | %b", a, b, sel, y);

        $finish;
    end

endmodule
