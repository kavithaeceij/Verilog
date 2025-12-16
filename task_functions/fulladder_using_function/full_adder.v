module full_adder (
    input  a,
    input  b,
    input  cin,
    output reg sum,
    output reg carry
);

    // --------------------------------------------------
    // always block (combinational)
    // Calls the functions to compute outputs
    // --------------------------------------------------
    always @(*) begin
        sum   = fa_sum(a, b, cin);      // Call SUM function
        carry = fa_carry(a, b, cin);    // Call CARRY function
    end


    // --------------------------------------------------
    // Function: fa_sum
    // Purpose :
    //   Calculates the SUM of a full adder
    // Logic   :
    //   SUM = a XOR b XOR cin
    // Notes   :
    //   - Pure combinational
    //   - Returns a single value
    //   - No timing allowed inside function
    // --------------------------------------------------
    function fa_sum;
        input a;
        input b;
        input cin;
        begin
            fa_sum = a ^ b ^ cin;
      $display( "FA_SUM  %b",fa_sum);
	    
        end
    endfunction


    // --------------------------------------------------
    // Function: fa_carry
    // Purpose :
    //   Calculates the CARRY output of a full adder
    // Logic   :
    //   CARRY = (a & b) | (b & cin) | (a & cin)
    // Notes   :
    //   - Pure combinational
    //   - Represents majority logic
    // --------------------------------------------------
    function fa_carry;
        input a;
        input b;
        input cin;
        begin
            fa_carry = (a & b) | (b & cin) | (a & cin);
          $display( "FA_CARRY  %b",fa_carry);
	    
        end
    endfunction

endmodule
