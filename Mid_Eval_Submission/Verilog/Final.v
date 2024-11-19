`timescale 1ns/1ps

`include "CLA.v"

// Positive Edge Triggered Active Low Asynchronous Reset FLip FLip
module DFF(input D, input Clk, input Reset, output reg Q);
    
    always @(posedge Clk or negedge Reset) 
    begin
        if(!Reset)
        begin
            Q <= 1'b0;
            // Not_Q <= 1'b1;
        end
        else
        begin
            Q <= D;
            // Not_Q <= ~D;
        end
    end

endmodule

module Adder(input Clk, input Rst, input [3:0] A, input [3:0] B, input Cin, output [3:0] S, output Cout);
    
    wire [3:0]Ain;
    wire [3:0]Bin;
    wire Cin_in;
    wire [3:0]Sout;
    wire Cout_out;

    DFF DFF0(A[0], Clk, Rst, Ain[0]);
    DFF DFF1(A[1], Clk, Rst, Ain[1]);
    DFF DFF2(A[2], Clk, Rst, Ain[2]);
    DFF DFF3(A[3], Clk, Rst, Ain[3]);

    DFF DFF4(B[0], Clk, Rst, Bin[0]);
    DFF DFF5(B[1], Clk, Rst, Bin[1]);
    DFF DFF6(B[2], Clk, Rst, Bin[2]);
    DFF DFF7(B[3], Clk, Rst, Bin[3]);

    DFF DFF8(Cin, Clk, Rst, Cin_in);

    CLA CLA0(Ain, Bin, Cin_in, Sout, Cout_out);

    DFF DFF9(Sout[0], Clk, Rst, S[0]);
    DFF DFF10(Sout[1], Clk, Rst, S[1]);
    DFF DFF11(Sout[2], Clk, Rst, S[2]);
    DFF DFF12(Sout[3], Clk, Rst, S[3]);

    DFF DFF13(Cout_out, Clk, Rst, Cout);

endmodule