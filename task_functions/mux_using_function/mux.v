// --------------------------------------------------
// 2x1 Multiplexer using FUNCTION
// Purpose: Understand how a function is used
// --------------------------------------------------
module mux2_using_function (
    input  a,          // Input 0
    input  b,          // Input 1
    input  sel,        // Select line
    output reg y       // Output
);

    // ----------------------------------------------
    // Function: mux2_func
    // - Computes mux output
    // - No timing
    // - Returns a single value
    // ----------------------------------------------
    function mux2_func;
        input a;
        input b;
        input sel;
        begin
            mux2_func = (sel == 0) ? a : b;
        end
    endfunction


    // ----------------------------------------------
    // Using the function inside combinational logic
    // ----------------------------------------------
    always @(*) begin
        y = mux2_func(a, b, sel);
    end

endmodule
