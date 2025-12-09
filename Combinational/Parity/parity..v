module parity(
    input  [3:0] data,     // 4-bit input data
    input        mode,     // 0 = even parity, 1 = odd parity
    output reg   parity    // parity output
);

    // -----------------------------------------------
    // TASK: Even Parity Generator
    // -----------------------------------------------
    task even_parity_generator;
        input  [3:0] data_in;
        output       parity_out;
        integer i;
        reg temp;
    begin
        temp = 0;
        for (i = 0; i < 4; i = i + 1) begin
            temp = temp ^ data_in[i];
        end
        parity_out = temp;          // even parity
    end
    endtask

    // -----------------------------------------------
    // TASK: Odd Parity Generator
    // -----------------------------------------------
    task odd_parity_generator;
        input  [3:0] data_in;
        output       parity_out;
        integer i;
        reg temp;
    begin
        temp = 0;
        for (i = 0; i < 4; i = i + 1) begin
            temp = temp ^ data_in[i];
        end
        parity_out = ~temp;         // odd parity = NOT(even parity)
    end
    endtask

    // -----------------------------------------------
    // Choose which task to call based on mode
    // -----------------------------------------------
    always @(*) begin
        if (mode == 1'b0) begin
            // Generate EVEN parity
            even_parity_generator(data, parity);
        end
        else begin
            // Generate ODD parity
            odd_parity_generator(data, parity);
        end
    end

endmodule
