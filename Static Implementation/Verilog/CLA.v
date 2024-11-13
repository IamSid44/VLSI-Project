// Verilog Structural Description of a 4 Bit Carry Lookahead Adder
`timescale 1ns / 1ps

module PG_Block(input A, input B, output P_Not, output G_Not, output S);

    nor Gate1(P_Not, A, B);
    nand Gate2(G_Not, A, B);
    xor Gate3(S, A, B);

endmodule

module Helper_Block(input Gi_Not, input Pi_Not, input Gi_1_Not, input Pi_1_Not, output Out_NAND, output Out_NOR);

    or Gate1(Inter_1, Gi_1_Not, Pi_Not);
    nand Gate2(Out_NAND, Gi_Not, Inter_1);
    nor Gate3(Out_NOR, Pi_Not, Pi_1_Not);

endmodule

module CLA(input [3:0] A, input [3:0] B, input Cin, output [3:0] S, output Cout);

    wire [3:0] P_Not;
    wire [3:0] G_Not;
    wire [3:0] C;
    wire [3:0] Inter_Sum;

    PG_Block PG_0(A[0], B[0], P_Not[0], G_Not[0], Inter_Sum[0]);
    PG_Block PG_1(A[1], B[1], P_Not[1], G_Not[1], Inter_Sum[1]);
    PG_Block PG_2(A[2], B[2], P_Not[2], G_Not[2], Inter_Sum[2]);
    PG_Block PG_3(A[3], B[3], P_Not[3], G_Not[3], Inter_Sum[3]);

    // C0 Bit
    not Gate1(Cin_Not, Cin);
    or Gate2(C0_Inter_01, P_Not[0], Cin_Not);
    nand Gate3(C[0], G_Not[0], C0_Inter_01);

    // C1 Bit
    Helper_Block Helper_1(G_Not[1], P_Not[1], G_Not[0], P_Not[0], C1_NAND, C1_NOR);
    and Gate4(C1_Inter_01, Cin, C1_NOR);
    or Gate5(C[1], C1_NAND, C1_Inter_01);

    // C2 Bit
    Helper_Block Helper_2(G_Not[2], P_Not[2], G_Not[1], P_Not[1], C2_NAND, C2_NOR);
    and Gate6(C2_Inter_01, C[0], C2_NOR);
    or Gate7(C[2], C2_NAND, C2_Inter_01);

    // C3 Bit
    Helper_Block Helper_3(G_Not[3], P_Not[3], G_Not[2], P_Not[2], C3_NAND, C3_NOR);
    and Gate8(C3_Inter_01, C3_NOR, C1_NAND);
    nor Gate9(C3_Inter_02, C3_Inter_01, C3_NAND);
    nand Gate10(C3_Inter_03, C3_NOR, C1_NOR);
    or Gate11(C3_Inter_04, Cin_Not, C3_Inter_03);
    nand Gate12(C[3], C3_Inter_02, C3_Inter_04);

    //Sum Bits
    xor Gate13(S[0], C[0], Inter_Sum[0]);
    xor Gate14(S[1], C[1], Inter_Sum[1]);
    xor Gate15(S[2], C[2], Inter_Sum[2]);
    xor Gate16(S[3], C[3], Inter_Sum[3]);

    // Cout is C[3]
    assign Cout = C[3];

endmodule