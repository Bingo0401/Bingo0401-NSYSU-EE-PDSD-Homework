//`include "no_Cout_adder.v"
//`include "eight_bit_carry_lookahead_generator.v"


module no_Cout_adder(A, B, Cin, S, P, G);
input A, B, Cin;
output S;
output P, G;

wire axb;
wire ab;
wire cin_axb;

xor #1 X1(axb, A, B);
xor #1 X2(S, axb, Cin);

and #1 A1(ab, A, B);
//and #1 A2(cin_axb, Cin, axb);
//or  #1 O1(Cout, ab, cin_axb);


//for carry lookahead
assign P = axb;
assign G = ab;

endmodule

module eight_bit_carry_lookahead_generator(Cin, P, G, C);

input Cin;
input [7:0] P;
input [7:0] G;

output [7:0] C;

wire [0:0] t0;
wire [1:0] t1;
wire [2:0] t2;
wire [3:0] t3;
wire [4:0] t4;
wire [5:0] t5;
wire [6:0] t6;
wire [7:0] t7;

// C[0] = G0 + P0*Cin
and #1 A01(t0[0], P[0], Cin);
or #1 O0(C[0], G[0], t0[0]);

// C[1] = G1 + P1*G0 + P1*P0*Cin
and #1 A11(t1[0], P[1], G[0]);
and #1 A12(t1[1], P[1], P[0], Cin);
or #1 O1(C[1], G[1], t1[0], t1[1]);

// C[2] = G2 + P2*G1 + P2*P1*G0 + P2*P1*P0*Cin
and #1 A21(t2[0], P[2], G[1]);
and #1 A22(t2[1], P[2], P[1], G[0]);
and #1 A23(t2[2], P[2], P[1], P[0], Cin);
or #1 O2(C[2], G[2], t2[0], t2[1], t2[2]);

// C[3] = G3 + P3*G2 + P3*P2*G1 + P3*P2*P1*G0 + P3*P2*P1*P0*Cin
and #1 A31(t3[0], P[3], G[2]);
and #1 A32(t3[1], P[3], P[2], G[1]);
and #1 A33(t3[2], P[3], P[2], P[1], G[0]);
and #1 A34(t3[3], P[3], P[2], P[1], P[0], Cin);
or #1 O3(C[3], G[3], t3[0], t3[1], t3[2], t3[3]);

// C[4] = G4 + P4*G3 + P4*P3*G2 + P4*P3*P2*G1 + P4*P3*P2*P1*G0 + P4*P3*P2*P1*P0*Cin
and #1 A41(t4[0], P[4], G[3]);
and #1 A42(t4[1], P[4], P[3], G[2]);
and #1 A43(t4[2], P[4], P[3], P[2], G[1]);
and #1 A44(t4[3], P[4], P[3], P[2], P[1], G[0]);
and #1 A45(t4[4], P[4], P[3], P[2], P[1], P[0], Cin);
or #1 O4(C[4], G[4], t4[0], t4[1], t4[2], t4[3], t4[4]);

// C[5] = G5 + P5*G4 + P5*P4*G3 + P5*P4*P3*G2 + P5*P4*P3*P2*G1 + P5*P4*P3*P2*P1*G0 + P5*P4*P3*P2*P1*P0*Cin
and #1 A51(t5[0], P[5], G[4]);
and #1 A52(t5[1], P[5], P[4], G[3]);
and #1 A53(t5[2], P[5], P[4], P[3], G[2]);
and #1 A54(t5[3], P[5], P[4], P[3], P[2], G[1]);
and #1 A55(t5[4], P[5], P[4], P[3], P[2], P[1], G[0]);
and #1 A56(t5[5], P[5], P[4], P[3], P[2], P[1], P[0], Cin);
or #1 O5(C[5], G[5], t5[0], t5[1], t5[2], t5[3], t5[4], t5[5]);

// C[6] = G6 + P6*G5 + P6*P5*G4 + P6*P5*P4*G3 + P6*P5*P4*P3*G2 + P6*P5*P4*P3*P2*G1 + P6*P5*P4*P3*P2*P1*G0 + P6*P5*P4*P3*P2*P1*P0*Cin
and #1 A61(t6[0], P[6], G[5]);
and #1 A62(t6[1], P[6], P[5], G[4]);
and #1 A63(t6[2], P[6], P[5], P[4], G[3]);
and #1 A64(t6[3], P[6], P[5], P[4], P[3], G[2]);
and #1 A65(t6[4], P[6], P[5], P[4], P[3], P[2], G[1]);
and #1 A66(t6[5], P[6], P[5], P[4], P[3], P[2], P[1], G[0]);
and #1 A67(t6[6], P[6], P[5], P[4], P[3], P[2], P[1], P[0], Cin);
or #1 O6(C[6], G[6], t6[0], t6[1], t6[2], t6[3], t6[4], t6[5], t6[6]);

// C[7] = G7 + P7*G6 + P7*P6*G5 + P7*P6*P5*G4 + P7*P6*P5*P4*G3 + P7*P6*P5*P4*P3*G2 + P7*P6*P5*P4*P3*P2*G1 + P7*P6*P5*P4*P3*P2*P1*G0 + P7*P6*P5*P4*P3*P2*P1*P0*Cin
and #1 A71(t7[0], P[7], G[6]);
and #1 A72(t7[1], P[7], P[6], G[5]);
and #1 A73(t7[2], P[7], P[6], P[5], G[4]);
and #1 A74(t7[3], P[7], P[6], P[5], P[4], G[3]);
and #1 A75(t7[4], P[7], P[6], P[5], P[4], P[3], G[2]);
and #1 A76(t7[5], P[7], P[6], P[5], P[4], P[3], P[2], G[1]);
and #1 A77(t7[6], P[7], P[6], P[5], P[4], P[3], P[2], P[1], G[0]);
and #1 A78(t7[7], P[7], P[6], P[5], P[4], P[3], P[2], P[1], P[0], Cin);
or #1 O7(C[7], G[7], t7[0], t7[1], t7[2], t7[3], t7[4], t7[5], t7[6], t7[7]);

endmodule



module top(A, B, mode, sum, c_out,overflow);


input [7:0] A;
input [7:0] B;
input mode;

output [7:0] sum;
output c_out;
output overflow;

wire [7:0] XOR;
wire [6:0] C;
wire [7:0] P;
wire [7:0] G;


// mode select
xor #1 XOR0(XOR[0], mode, B[0]);
xor #1 XOR1(XOR[1], mode, B[1]);
xor #1 XOR2(XOR[2], mode, B[2]);
xor #1 XOR3(XOR[3], mode, B[3]);
xor #1 XOR4(XOR[4], mode, B[4]);
xor #1 XOR5(XOR[5], mode, B[5]);
xor #1 XOR6(XOR[6], mode, B[6]);
xor #1 XOR7(XOR[7], mode, B[7]);


// full adders (sum path + P/G generation)
no_Cout_adder Addr0(.A(A[0]), .B(XOR[0]), .Cin(mode), .S(sum[0]), .P(P[0]), .G(G[0]));
no_Cout_adder Addr1(.A(A[1]), .B(XOR[1]), .Cin(C[0]), .S(sum[1]), .P(P[1]), .G(G[1]));
no_Cout_adder Addr2(.A(A[2]), .B(XOR[2]), .Cin(C[1]), .S(sum[2]), .P(P[2]), .G(G[2]));
no_Cout_adder Addr3(.A(A[3]), .B(XOR[3]), .Cin(C[2]), .S(sum[3]), .P(P[3]), .G(G[3]));
no_Cout_adder Addr4(.A(A[4]), .B(XOR[4]), .Cin(C[3]), .S(sum[4]), .P(P[4]), .G(G[4]));
no_Cout_adder Addr5(.A(A[5]), .B(XOR[5]), .Cin(C[4]), .S(sum[5]), .P(P[5]), .G(G[5]));
no_Cout_adder Addr6(.A(A[6]), .B(XOR[6]), .Cin(C[5]), .S(sum[6]), .P(P[6]), .G(G[6]));
no_Cout_adder Addr7(.A(A[7]), .B(XOR[7]), .Cin(C[6]), .S(sum[7]), .P(P[7]), .G(G[7]));

//carry lookahead generator
eight_bit_carry_lookahead_generator CLAG(.Cin(mode), .P(P), .G(G), .C({c_out, C}));


//overflow detection
xor #1 XORV(overflow, C[6], c_out);


endmodule



//coded by Bingo


