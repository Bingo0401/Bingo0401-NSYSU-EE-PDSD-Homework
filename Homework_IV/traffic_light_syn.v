/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : S-2021.06-SP2
// Date      : Fri May 15 04:20:21 2026
/////////////////////////////////////////////////////////////


module synchronous_counter ( clk, reset, en, clr, count );
  output [2:0] count;
  input clk, reset, en, clr;
  wire   n12, n13, n14, n1, n2, n3, n4, n5, n6, n7, n8, n9;

  DFQD2BWP16P90LVT \count_reg[0]  ( .D(n14), .CP(clk), .Q(count[0]) );
  DFQD2BWP16P90LVT \count_reg[1]  ( .D(n13), .CP(clk), .Q(count[1]) );
  DFQD2BWP16P90LVT \count_reg[2]  ( .D(n12), .CP(clk), .Q(count[2]) );
  CKMUX2D1BWP16P90 U3 ( .I0(n1), .I1(n2), .S(count[0]), .Z(n14) );
  CKMUX2D1BWP16P90 U4 ( .I0(n3), .I1(n4), .S(count[1]), .Z(n13) );
  CKND1BWP16P90 U5 ( .I(n5), .ZN(n4) );
  NR2D1BWP16P90 U6 ( .A1(n6), .A2(n7), .ZN(n3) );
  CKMUX2D1BWP16P90 U7 ( .I0(n8), .I1(n9), .S(count[2]), .Z(n12) );
  OAI21D1BWP16P90 U8 ( .A1(count[1]), .A2(n7), .B(n5), .ZN(n9) );
  AOI21D1BWP16P90 U9 ( .A1(n6), .A2(n1), .B(n2), .ZN(n5) );
  NR3D1BWP16P90 U10 ( .A1(clr), .A2(reset), .A3(n1), .ZN(n2) );
  CKND1BWP16P90 U11 ( .I(count[0]), .ZN(n6) );
  CKND1BWP16P90 U12 ( .I(n1), .ZN(n7) );
  AN3D1BWP16P90 U13 ( .A1(count[1]), .A2(count[0]), .A3(n1), .Z(n8) );
  INR3D1BWP16P90 U14 ( .A1(en), .B1(clr), .B2(reset), .ZN(n1) );
endmodule


module traffic_light ( clk, reset, midnight, A_G, A_Y, A_R, B_G, B_Y, B_R );
  input clk, reset, midnight;
  output A_G, A_Y, A_R, B_G, B_Y, B_R;
  wire   counter_en, counter_clr, n1, n30, n31, n32, n33, n34, n35, n36, n37,
         n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51,
         n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63;
  wire   [2:0] timer_count;
  wire   [2:0] state;
  wire   [2:0] next_state;

  synchronous_counter u_timer ( .clk(clk), .reset(reset), .en(counter_en), 
        .clr(counter_clr), .count(timer_count) );
  DFCNQD1BWP16P90LVT \state_reg[0]  ( .D(next_state[0]), .CP(clk), .CDN(n1), 
        .Q(state[0]) );
  DFCNQD1BWP16P90LVT \state_reg[1]  ( .D(next_state[1]), .CP(clk), .CDN(n1), 
        .Q(state[1]) );
  DFCNQD1BWP16P90LVT \state_reg[2]  ( .D(next_state[2]), .CP(clk), .CDN(n1), 
        .Q(state[2]) );
  OAI21D1BWP16P90 U43 ( .A1(n30), .A2(n31), .B(n32), .ZN(next_state[2]) );
  AOI33D1BWP16P90 U44 ( .A1(n33), .A2(n34), .A3(n35), .B1(n36), .B2(n37), .B3(
        B_G), .ZN(n32) );
  CKND1BWP16P90 U45 ( .I(n38), .ZN(n35) );
  CKND1BWP16P90 U46 ( .I(state[1]), .ZN(n34) );
  OAI211D1BWP16P90 U47 ( .A1(n30), .A2(n31), .B(n39), .C(n40), .ZN(
        next_state[1]) );
  ND3D1BWP16P90 U48 ( .A1(state[0]), .A2(n41), .A3(n42), .ZN(n40) );
  OAI31D1BWP16P90 U49 ( .A1(n43), .A2(n44), .A3(n45), .B(n46), .ZN(n39) );
  CKND1BWP16P90 U50 ( .I(midnight), .ZN(n31) );
  NR2D1BWP16P90 U51 ( .A1(midnight), .A2(n47), .ZN(next_state[0]) );
  AOI22D1BWP16P90 U52 ( .A1(n48), .A2(n41), .B1(n42), .B2(n46), .ZN(n47) );
  CKND1BWP16P90 U53 ( .I(n33), .ZN(n42) );
  ND2D1BWP16P90 U54 ( .A1(n37), .A2(n43), .ZN(n33) );
  CKMUX2D1BWP16P90 U55 ( .I0(state[0]), .I1(n49), .S(n37), .Z(n48) );
  CKND1BWP16P90 U56 ( .I(n50), .ZN(n37) );
  NR2D1BWP16P90 U57 ( .A1(state[1]), .A2(n43), .ZN(n49) );
  CKND1BWP16P90 U58 ( .I(reset), .ZN(n1) );
  ND2D1BWP16P90 U59 ( .A1(n30), .A2(state[1]), .ZN(counter_en) );
  CKND1BWP16P90 U60 ( .I(n51), .ZN(n30) );
  OAI211D1BWP16P90 U61 ( .A1(n52), .A2(n50), .B(n51), .C(n53), .ZN(counter_clr) );
  XOR2D1BWP16P90 U62 ( .A1(n54), .A2(midnight), .Z(n53) );
  ND2D1BWP16P90 U63 ( .A1(state[1]), .A2(state[2]), .ZN(n54) );
  ND2D1BWP16P90 U64 ( .A1(state[0]), .A2(state[2]), .ZN(n51) );
  ND2D1BWP16P90 U65 ( .A1(n55), .A2(timer_count[0]), .ZN(n50) );
  XNR2D1BWP16P90 U66 ( .A1(timer_count[1]), .A2(timer_count[2]), .ZN(n55) );
  AOI21D1BWP16P90 U67 ( .A1(A_G), .A2(n36), .B(n56), .ZN(n52) );
  CKMUX2D1BWP16P90 U68 ( .I0(n57), .I1(n58), .S(state[1]), .Z(n56) );
  CKMUX2D1BWP16P90 U69 ( .I0(n59), .I1(state[0]), .S(n36), .Z(n58) );
  NR2D1BWP16P90 U70 ( .A1(n36), .A2(n59), .ZN(n57) );
  CKND1BWP16P90 U71 ( .I(n60), .ZN(n59) );
  CKND1BWP16P90 U72 ( .I(n43), .ZN(n36) );
  ND2D1BWP16P90 U73 ( .A1(timer_count[2]), .A2(timer_count[1]), .ZN(n43) );
  INR2D1BWP16P90 U74 ( .A1(n61), .B1(n38), .ZN(B_Y) );
  OAI21D1BWP16P90 U75 ( .A1(n46), .A2(n45), .B(n60), .ZN(B_R) );
  CKND1BWP16P90 U76 ( .I(n62), .ZN(n46) );
  NR2D1BWP16P90 U77 ( .A1(n45), .A2(n62), .ZN(B_G) );
  OAI32D1BWP16P90 U78 ( .A1(n45), .A2(state[2]), .A3(state[1]), .B1(n38), .B2(
        n61), .ZN(A_Y) );
  ND2D1BWP16P90 U79 ( .A1(state[1]), .A2(n44), .ZN(n61) );
  CKND1BWP16P90 U80 ( .I(timer_count[0]), .ZN(n44) );
  ND2D1BWP16P90 U81 ( .A1(state[2]), .A2(n45), .ZN(n38) );
  ND2D1BWP16P90 U82 ( .A1(n63), .A2(n62), .ZN(A_R) );
  ND2D1BWP16P90 U83 ( .A1(state[1]), .A2(n41), .ZN(n62) );
  CKMUX2D1BWP16P90 U84 ( .I0(n41), .I1(n45), .S(state[1]), .Z(n63) );
  NR2D1BWP16P90 U85 ( .A1(n60), .A2(state[1]), .ZN(A_G) );
  ND2D1BWP16P90 U86 ( .A1(n41), .A2(n45), .ZN(n60) );
  CKND1BWP16P90 U87 ( .I(state[0]), .ZN(n45) );
  CKND1BWP16P90 U88 ( .I(state[2]), .ZN(n41) );
endmodule

