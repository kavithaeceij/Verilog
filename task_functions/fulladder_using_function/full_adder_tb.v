module full_adder_tb;
reg X;
reg Y;
reg Z;
wire SUM;
wire CARRY;
 full_adder f1(.a(X),.b(Y),.cin(Z),.sum(SUM),.carry(CARRY));

initial begin
        // Waveform generation
        $dumpfile("full_adder.vcd");
        $dumpvars(0, full_adder_tb);

               // Monitor prints values whenever any signal changes
        $monitor("%b %b  %b  |  %b    %b", X, Y, Z, SUM, CARRY);

        // Apply all 8 combinations
        X=0; Y=0; Z=0; #10;
        X=0; Y=0; Z=1; #10;
        X=0; Y=1; Z=0; #10;
        X=0; Y=1; Z=1; #10;
        X=1; Y=0; Z=0; #10;
       
        $finish;
    end

endmodule
