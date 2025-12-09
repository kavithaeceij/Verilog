// -------------------------------------------------------------
// D Flip-Flop with reset (two variants)
// -------------------------------------------------------------
// Ports:
//   clk   : clock input
//   reset : reset input (active HIGH in both examples below)
//   d     : data input
//   q     : registered output
//
// NOTE:
//   - This file shows BOTH reset styles.
//   - By default, ASYNCHRONOUS RESET block is enabled,
//     and SYNCHRONOUS RESET block is commented.
//   - To switch, just comment/uncomment the right always block.
// -------------------------------------------------------------

module dff (
    input  clk,     // Clock
    input  reset,   // Reset (active HIGH)
    input  d,       // Data input
    output reg q    // Registered output
);

    // ---------------------------------------------------------
    // 1) SYNCHRONOUS RESET (ACTIVE HIGH)
    // ---------------------------------------------------------
    // Behavior:
    //   - Reset is checked ONLY on posedge clk.
    //   - If reset=1 at clock edge, q goes to 0.
    //   - If reset=0 at clock edge, q takes value of d.
    //
    // Uncomment this block to use synchronous reset and
    // comment the asynchronous block below.
    /*
    always @(posedge clk) begin
        if (reset)
            q <= 1'b0;   // reset output
        else
            q <= d;      // capture data on clock edge
    end
    */

    // ---------------------------------------------------------
    // 2) ASYNCHRONOUS RESET (ACTIVE HIGH)
    // ---------------------------------------------------------
    // Behavior:
    //   - Reset is in the sensitivity list.
    //   - As soon as reset goes 0->1, q is cleared immediately.
    //   - Otherwise, on clock edge, q takes value of d.
    //
    // This block is ACTIVE by default.
    // ---------------------------------------------------------
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 1'b0;   // immediate reset when reset=1
        else
            q <= d;      // normal DFF behavior on clock
    end

endmodule
