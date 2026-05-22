/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : S-2021.06-SP2
// Date      : Tue Apr 28 03:57:20 2026
/////////////////////////////////////////////////////////////


module no_Cout_adder_0 ( A, B, Cin, S, P, G );
  input A, B, Cin;
  output S, P, G;


  XOR2D1BWP16P90 U1 ( .A1(Cin), .A2(P), .Z(S) );
  XOR2D1BWP16P90 U2 ( .A1(A), .A2(B), .Z(P) );
  AN2D1BWP16P90 U3 ( .A1(B), .A2(A), .Z(G) );
endmodule


module eight_bit_carry_lookahead_generator ( Cin, P, G, C );
  input [7:0] P;
  input [7:0] G;
  output [7:0] C;
  input Cin;


  AO21D1BWP16P90 U1 ( .A1(P[7]), .A2(C[6]), .B(G[7]), .Z(C[7]) );
  AO21D1BWP16P90 U2 ( .A1(P[6]), .A2(C[5]), .B(G[6]), .Z(C[6]) );
  AO21D1BWP16P90 U3 ( .A1(P[5]), .A2(C[4]), .B(G[5]), .Z(C[5]) );
  AO21D1BWP16P90 U4 ( .A1(P[4]), .A2(C[3]), .B(G[4]), .Z(C[4]) );
  AO21D1BWP16P90 U5 ( .A1(P[3]), .A2(C[2]), .B(G[3]), .Z(C[3]) );
  AO21D1BWP16P90 U6 ( .A1(P[2]), .A2(C[1]), .B(G[2]), .Z(C[2]) );
  AO21D1BWP16P90 U7 ( .A1(P[1]), .A2(C[0]), .B(G[1]), .Z(C[1]) );
  AO21D1BWP16P90 U8 ( .A1(P[0]), .A2(Cin), .B(G[0]), .Z(C[0]) );
endmodule


module no_Cout_adder_1 ( A, B, Cin, S, P, G );
  input A, B, Cin;
  output S, P, G;


  XOR2D1BWP16P90 U1 ( .A1(Cin), .A2(P), .Z(S) );
  XOR2D1BWP16P90 U2 ( .A1(A), .A2(B), .Z(P) );
  AN2D1BWP16P90 U3 ( .A1(B), .A2(A), .Z(G) );
endmodule


module no_Cout_adder_2 ( A, B, Cin, S, P, G );
  input A, B, Cin;
  output S, P, G;


  XOR2D1BWP16P90 U1 ( .A1(Cin), .A2(P), .Z(S) );
  XOR2D1BWP16P90 U2 ( .A1(A), .A2(B), .Z(P) );
  AN2D1BWP16P90 U3 ( .A1(B), .A2(A), .Z(G) );
endmodule


module no_Cout_adder_3 ( A, B, Cin, S, P, G );
  input A, B, Cin;
  output S, P, G;


  XOR2D1BWP16P90 U1 ( .A1(Cin), .A2(P), .Z(S) );
  XOR2D1BWP16P90 U2 ( .A1(A), .A2(B), .Z(P) );
  AN2D1BWP16P90 U3 ( .A1(B), .A2(A), .Z(G) );
endmodule


module no_Cout_adder_4 ( A, B, Cin, S, P, G );
  input A, B, Cin;
  output S, P, G;


  XOR2D1BWP16P90 U1 ( .A1(Cin), .A2(P), .Z(S) );
  XOR2D1BWP16P90 U2 ( .A1(A), .A2(B), .Z(P) );
  AN2D1BWP16P90 U3 ( .A1(B), .A2(A), .Z(G) );
endmodule


module no_Cout_adder_5 ( A, B, Cin, S, P, G );
  input A, B, Cin;
  output S, P, G;


  XOR2D1BWP16P90 U1 ( .A1(Cin), .A2(P), .Z(S) );
  XOR2D1BWP16P90 U2 ( .A1(A), .A2(B), .Z(P) );
  AN2D1BWP16P90 U3 ( .A1(B), .A2(A), .Z(G) );
endmodule


module no_Cout_adder_6 ( A, B, Cin, S, P, G );
  input A, B, Cin;
  output S, P, G;


  XOR2D1BWP16P90 U1 ( .A1(Cin), .A2(P), .Z(S) );
  XOR2D1BWP16P90 U2 ( .A1(A), .A2(B), .Z(P) );
  AN2D1BWP16P90 U3 ( .A1(B), .A2(A), .Z(G) );
endmodule


module no_Cout_adder_7 ( A, B, Cin, S, P, G );
  input A, B, Cin;
  output S, P, G;


  XOR2D1BWP16P90 U1 ( .A1(Cin), .A2(P), .Z(S) );
  XOR2D1BWP16P90 U2 ( .A1(A), .A2(B), .Z(P) );
  AN2D1BWP16P90 U3 ( .A1(B), .A2(A), .Z(G) );
endmodule


module adder ( A, B, mode, sum, c_out );
  input [7:0] A;
  input [7:0] B;
  output [7:0] sum;
  input mode;
  output c_out;
  wire   n1;
  wire   [7:0] XOR;
  wire   [7:0] P;
  wire   [7:0] G;
  wire   [6:0] C;

  no_Cout_adder_0 Addr0 ( .A(A[0]), .B(XOR[0]), .Cin(n1), .S(sum[0]), .P(P[0]), 
        .G(G[0]) );
  no_Cout_adder_7 Addr1 ( .A(A[1]), .B(XOR[1]), .Cin(C[0]), .S(sum[1]), .P(
        P[1]), .G(G[1]) );
  no_Cout_adder_6 Addr2 ( .A(A[2]), .B(XOR[2]), .Cin(C[1]), .S(sum[2]), .P(
        P[2]), .G(G[2]) );
  no_Cout_adder_5 Addr3 ( .A(A[3]), .B(XOR[3]), .Cin(C[2]), .S(sum[3]), .P(
        P[3]), .G(G[3]) );
  no_Cout_adder_4 Addr4 ( .A(A[4]), .B(XOR[4]), .Cin(C[3]), .S(sum[4]), .P(
        P[4]), .G(G[4]) );
  no_Cout_adder_3 Addr5 ( .A(A[5]), .B(XOR[5]), .Cin(C[4]), .S(sum[5]), .P(
        P[5]), .G(G[5]) );
  no_Cout_adder_2 Addr6 ( .A(A[6]), .B(XOR[6]), .Cin(C[5]), .S(sum[6]), .P(
        P[6]), .G(G[6]) );
  no_Cout_adder_1 Addr7 ( .A(A[7]), .B(XOR[7]), .Cin(C[6]), .S(sum[7]), .P(
        P[7]), .G(G[7]) );
  eight_bit_carry_lookahead_generator CLAG ( .Cin(n1), .P(P), .G(G), .C({c_out, 
        C}) );
  XOR2D1BWP16P90 U10 ( .A1(n1), .A2(B[7]), .Z(XOR[7]) );
  XOR2D1BWP16P90 U11 ( .A1(n1), .A2(B[6]), .Z(XOR[6]) );
  XOR2D1BWP16P90 U12 ( .A1(n1), .A2(B[5]), .Z(XOR[5]) );
  XOR2D1BWP16P90 U13 ( .A1(n1), .A2(B[4]), .Z(XOR[4]) );
  XOR2D1BWP16P90 U14 ( .A1(n1), .A2(B[3]), .Z(XOR[3]) );
  XOR2D1BWP16P90 U15 ( .A1(n1), .A2(B[2]), .Z(XOR[2]) );
  XOR2D1BWP16P90 U16 ( .A1(n1), .A2(B[1]), .Z(XOR[1]) );
  XOR2D1BWP16P90 U17 ( .A1(n1), .A2(B[0]), .Z(XOR[0]) );
  CKND1BWP16P90 U18 ( .I(mode), .ZN(n1) );
endmodule

