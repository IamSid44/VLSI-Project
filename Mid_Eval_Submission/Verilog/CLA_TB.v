// Testbench for the 4 bit carry lookahead adder
`timescale 1ns / 1ps

module CLA_TB;

    reg [3:0] A;
    reg [3:0] B;
    reg Cin;

    wire [3:0] S;
    wire Cout;

    CLA uut(A, B, Cin, S, Cout);

    initial begin
        $dumpfile("CLA.vcd");
        $dumpvars(0, uut);

        A = 4'b0000;
        B = 4'b0000;
        Cin = 0;
        #10;

        A = 4'b1111;
        B = 4'b1111;
        Cin = 0;
        #10;

        A = 4'b1111;
        B = 4'b1111;
        Cin = 1;
        #10;

        A = 4'b0101;
        B = 4'b1010;
        Cin = 0;
        #10;

        A = 4'b0101;
        B = 4'b1010;
        Cin = 1;
        #10;

        A = 4'b0000;
        B = 4'b0111;
        Cin = 0;
        #10;

        A = 4'b0000;
        B = 4'b0111;
        Cin = 1;
        #10;

        $finish;
    end

endmodule