`timescale 1ns/1ps

`include "Final.v"

module Final_TB;

    reg Clk;
    reg Rst;
    reg [3:0] A;
    reg [3:0] B;
    reg Cin;

    wire [3:0] S;
    wire Cout;

    Adder uut(Clk, Rst, A, B, Cin, S, Cout);

    initial
    begin
        Clk = 0;
        Rst = 0;
        #1
        Rst = 1;
        forever #5 Clk = ~Clk; // 6, 16, 26, ...
    end

    initial begin
        $dumpfile("Final.vcd");
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