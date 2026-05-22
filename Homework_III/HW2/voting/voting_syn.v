/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : S-2021.06-SP2
// Date      : Tue Apr 28 02:15:21 2026
/////////////////////////////////////////////////////////////


module voting ( a0, a1, a2, a3, a4, out, count );
  input [4:0] a0;
  input [4:0] a1;
  input [4:0] a2;
  input [4:0] a3;
  input [4:0] a4;
  output [4:0] out;
  output [2:0] count;
  wire   N45, n220, n221, n222, n223, n224, n225, n226, n227, n228, n229, n230,
         n231, n232, n233, n234, n235, n236, n237, n238, n239, n240, n241,
         n242, n243, n244, n245, n246, n247, n248, n249, n250, n251, n252,
         n253, n254, n255, n256, n257, n258, n259, n260, n261, n262, n263,
         n264, n265, n266, n267, n268, n269, n270, n271, n272, n273, n274,
         n275, n276, n277, n278, n279, n280, n281, n282, n283, n284, n285,
         n286, n287, n288, n289, n290, n291, n292, n293, n294, n295, n296,
         n297, n298, n299, n300, n301, n302, n303, n304, n305, n306, n307,
         n308, n309, n310, n311, n312, n313, n314, n315, n316, n317, n318,
         n319, n320, n321, n322, n323, n324, n325, n326, n327, n328, n329;
  assign out[4] = N45;

  AN2D1BWP16P90LVT U119 ( .A1(a0[1]), .A2(n298), .Z(n220) );
  CKND1BWP16P90 U120 ( .I(n221), .ZN(out[1]) );
  ND4D1BWP16P90 U121 ( .A1(n222), .A2(n223), .A3(n224), .A4(n225), .ZN(
        count[2]) );
  OAI211D1BWP16P90 U122 ( .A1(n226), .A2(n221), .B(n227), .C(n228), .ZN(
        count[1]) );
  AOI22D1BWP16P90 U123 ( .A1(N45), .A2(n229), .B1(out[0]), .B2(n230), .ZN(n228) );
  AOI22D1BWP16P90 U124 ( .A1(out[3]), .A2(n231), .B1(out[2]), .B2(n232), .ZN(
        n227) );
  OAI211D1BWP16P90 U125 ( .A1(n233), .A2(n221), .B(n234), .C(n235), .ZN(
        count[0]) );
  AOI22D1BWP16P90 U126 ( .A1(out[0]), .A2(n236), .B1(N45), .B2(n237), .ZN(n235) );
  AN2D1BWP16P90 U127 ( .A1(n238), .A2(n239), .Z(out[0]) );
  AOI22D1BWP16P90 U128 ( .A1(out[3]), .A2(n240), .B1(out[2]), .B2(n241), .ZN(
        n234) );
  AN3D1BWP16P90 U129 ( .A1(n242), .A2(n243), .A3(n244), .Z(out[2]) );
  NR2D1BWP16P90 U130 ( .A1(n242), .A2(N45), .ZN(out[3]) );
  IND2D1BWP16P90 U131 ( .A1(n238), .B1(n239), .ZN(n221) );
  INR3D1BWP16P90 U132 ( .A1(n242), .B1(N45), .B2(n244), .ZN(n239) );
  AOI221D1BWP16P90 U133 ( .A1(n245), .A2(n246), .B1(n247), .B2(n248), .C(n249), 
        .ZN(n244) );
  CKND1BWP16P90 U134 ( .I(n250), .ZN(n249) );
  OAI31D1BWP16P90 U135 ( .A1(n247), .A2(n251), .A3(n245), .B(n223), .ZN(n250)
         );
  CKND1BWP16P90 U136 ( .I(n222), .ZN(n251) );
  OAI21D1BWP16P90 U137 ( .A1(n232), .A2(n252), .B(n253), .ZN(n247) );
  OAI211D1BWP16P90 U138 ( .A1(n230), .A2(n254), .B(n236), .C(n255), .ZN(n253)
         );
  OAI21D1BWP16P90 U139 ( .A1(n232), .A2(n226), .B(n256), .ZN(n245) );
  OAI211D1BWP16P90 U140 ( .A1(n257), .A2(n254), .B(n258), .C(n255), .ZN(n256)
         );
  OAI211D1BWP16P90 U141 ( .A1(n259), .A2(n260), .B(n261), .C(n262), .ZN(n242)
         );
  AOI22D1BWP16P90 U142 ( .A1(n263), .A2(n264), .B1(n246), .B2(n265), .ZN(n262)
         );
  OAI31D1BWP16P90 U143 ( .A1(n266), .A2(n264), .A3(n265), .B(n225), .ZN(n261)
         );
  OAI21D1BWP16P90 U144 ( .A1(n231), .A2(n226), .B(n267), .ZN(n265) );
  OAI211D1BWP16P90 U145 ( .A1(n257), .A2(n268), .B(n258), .C(n269), .ZN(n267)
         );
  CKND1BWP16P90 U146 ( .I(n233), .ZN(n258) );
  OAI21D1BWP16P90 U147 ( .A1(n231), .A2(n254), .B(n270), .ZN(n264) );
  OAI211D1BWP16P90 U148 ( .A1(n232), .A2(n268), .B(n241), .C(n269), .ZN(n270)
         );
  CKND1BWP16P90 U149 ( .I(n255), .ZN(n241) );
  CKND1BWP16P90 U150 ( .I(n254), .ZN(n232) );
  ND3D1BWP16P90 U151 ( .A1(n222), .A2(n223), .A3(n259), .ZN(n266) );
  NR2D1BWP16P90 U152 ( .A1(n248), .A2(n246), .ZN(n222) );
  OA21D1BWP16P90 U153 ( .A1(n231), .A2(n252), .B(n271), .Z(n259) );
  OAI211D1BWP16P90 U154 ( .A1(n230), .A2(n268), .B(n236), .C(n269), .ZN(n271)
         );
  CKND1BWP16P90 U155 ( .I(n272), .ZN(n236) );
  CKND1BWP16P90 U156 ( .I(n268), .ZN(n231) );
  MAOI222D1BWP16P90 U157 ( .A(n246), .B(n273), .C(n260), .ZN(n238) );
  AOI22D1BWP16P90 U158 ( .A1(n274), .A2(n233), .B1(n230), .B2(n226), .ZN(n273)
         );
  CKND1BWP16P90 U159 ( .I(n252), .ZN(n230) );
  AOI21D1BWP16P90 U160 ( .A1(n257), .A2(n252), .B(n272), .ZN(n274) );
  CKND1BWP16P90 U161 ( .I(n243), .ZN(N45) );
  ND4D1BWP16P90 U162 ( .A1(n275), .A2(n276), .A3(n277), .A4(n278), .ZN(n243)
         );
  OAI22D1BWP16P90 U163 ( .A1(n248), .A2(n224), .B1(n279), .B2(n280), .ZN(n278)
         );
  OAI22D1BWP16P90 U164 ( .A1(n281), .A2(n260), .B1(n229), .B2(n252), .ZN(n280)
         );
  AOI211D1BWP16P90 U165 ( .A1(n282), .A2(n252), .B(n237), .C(n272), .ZN(n279)
         );
  XOR2D1BWP16P90 U166 ( .A1(n283), .A2(a3[0]), .Z(n272) );
  OAI21D1BWP16P90 U167 ( .A1(n284), .A2(n285), .B(n260), .ZN(n252) );
  CKND1BWP16P90 U168 ( .I(n260), .ZN(n248) );
  ND2D1BWP16P90 U169 ( .A1(n285), .A2(n284), .ZN(n260) );
  OAI22D1BWP16P90 U170 ( .A1(n286), .A2(n287), .B1(n283), .B2(n288), .ZN(n284)
         );
  CKND1BWP16P90 U171 ( .I(a3[0]), .ZN(n288) );
  XOR2D1BWP16P90 U172 ( .A1(n287), .A2(a4[0]), .Z(n283) );
  OAI21D1BWP16P90 U173 ( .A1(a0[0]), .A2(n289), .B(n290), .ZN(n287) );
  CKND1BWP16P90 U174 ( .I(a4[0]), .ZN(n286) );
  IOA21D1BWP16P90 U175 ( .A1(a2[0]), .A2(a1[0]), .B(n290), .ZN(n285) );
  ND2D1BWP16P90 U176 ( .A1(a0[0]), .A2(n289), .ZN(n290) );
  XOR2D1BWP16P90 U177 ( .A1(a1[0]), .A2(a2[0]), .Z(n289) );
  OAI22D1BWP16P90 U178 ( .A1(n246), .A2(n224), .B1(n291), .B2(n292), .ZN(n277)
         );
  AO22D1BWP16P90 U179 ( .A1(n293), .A2(n257), .B1(n224), .B2(n246), .Z(n292)
         );
  AOI211D1BWP16P90 U180 ( .A1(n226), .A2(n282), .B(n237), .C(n233), .ZN(n291)
         );
  XNR2D1BWP16P90 U181 ( .A1(n294), .A2(a3[1]), .ZN(n233) );
  CKND1BWP16P90 U182 ( .I(n257), .ZN(n226) );
  AOI21D1BWP16P90 U183 ( .A1(n295), .A2(n296), .B(n246), .ZN(n257) );
  NR2D1BWP16P90 U184 ( .A1(n295), .A2(n296), .ZN(n246) );
  AOI21D1BWP16P90 U185 ( .A1(a2[1]), .A2(a1[1]), .B(n220), .ZN(n296) );
  AOI22D1BWP16P90 U186 ( .A1(a4[1]), .A2(n297), .B1(n294), .B2(a3[1]), .ZN(
        n295) );
  XOR2D1BWP16P90 U187 ( .A1(n297), .A2(a4[1]), .Z(n294) );
  IAO21D1BWP16P90 U188 ( .A1(a0[1]), .A2(n298), .B(n220), .ZN(n297) );
  XOR2D1BWP16P90 U189 ( .A1(a1[1]), .A2(a2[1]), .Z(n298) );
  OAI22D1BWP16P90 U190 ( .A1(n263), .A2(n224), .B1(n299), .B2(n300), .ZN(n276)
         );
  OAI22D1BWP16P90 U191 ( .A1(n281), .A2(n223), .B1(n229), .B2(n254), .ZN(n300)
         );
  CKND1BWP16P90 U192 ( .I(n293), .ZN(n229) );
  CKND1BWP16P90 U193 ( .I(n224), .ZN(n281) );
  AOI211D1BWP16P90 U194 ( .A1(n254), .A2(n282), .B(n237), .C(n255), .ZN(n299)
         );
  XOR2D1BWP16P90 U195 ( .A1(n301), .A2(a3[2]), .Z(n255) );
  CKND1BWP16P90 U196 ( .I(n302), .ZN(n237) );
  OAI21D1BWP16P90 U197 ( .A1(n303), .A2(n304), .B(n223), .ZN(n254) );
  CKND1BWP16P90 U198 ( .I(n223), .ZN(n263) );
  ND2D1BWP16P90 U199 ( .A1(n304), .A2(n303), .ZN(n223) );
  OAI22D1BWP16P90 U200 ( .A1(n305), .A2(n306), .B1(n301), .B2(n307), .ZN(n303)
         );
  CKND1BWP16P90 U201 ( .I(a3[2]), .ZN(n307) );
  XOR2D1BWP16P90 U202 ( .A1(n306), .A2(a4[2]), .Z(n301) );
  OAI21D1BWP16P90 U203 ( .A1(a0[2]), .A2(n308), .B(n309), .ZN(n306) );
  CKND1BWP16P90 U204 ( .I(a4[2]), .ZN(n305) );
  IOA21D1BWP16P90 U205 ( .A1(a2[2]), .A2(a1[2]), .B(n309), .ZN(n304) );
  ND2D1BWP16P90 U206 ( .A1(a0[2]), .A2(n308), .ZN(n309) );
  XOR2D1BWP16P90 U207 ( .A1(a1[2]), .A2(a2[2]), .Z(n308) );
  OAI22D1BWP16P90 U208 ( .A1(n310), .A2(n311), .B1(n312), .B2(n224), .ZN(n275)
         );
  ND2D1BWP16P90 U209 ( .A1(n313), .A2(n314), .ZN(n224) );
  INR2D1BWP16P90 U210 ( .A1(n311), .B1(n225), .ZN(n312) );
  OAI22D1BWP16P90 U211 ( .A1(n269), .A2(n282), .B1(n315), .B2(n268), .ZN(n311)
         );
  OAI21D1BWP16P90 U212 ( .A1(n316), .A2(n317), .B(n225), .ZN(n268) );
  AOI21D1BWP16P90 U213 ( .A1(n302), .A2(n240), .B(n293), .ZN(n315) );
  CKND1BWP16P90 U214 ( .I(n269), .ZN(n240) );
  ND2D1BWP16P90 U215 ( .A1(n302), .A2(n293), .ZN(n282) );
  XNR2D1BWP16P90 U216 ( .A1(n314), .A2(n313), .ZN(n293) );
  IOA21D1BWP16P90 U217 ( .A1(a2[4]), .A2(a1[4]), .B(n318), .ZN(n313) );
  OAI22D1BWP16P90 U218 ( .A1(n319), .A2(n320), .B1(n321), .B2(n322), .ZN(n314)
         );
  CKND1BWP16P90 U219 ( .I(a3[4]), .ZN(n322) );
  CKND1BWP16P90 U220 ( .I(a4[4]), .ZN(n319) );
  XOR2D1BWP16P90 U221 ( .A1(n321), .A2(a3[4]), .Z(n302) );
  XOR2D1BWP16P90 U222 ( .A1(n320), .A2(a4[4]), .Z(n321) );
  OAI21D1BWP16P90 U223 ( .A1(a0[4]), .A2(n323), .B(n318), .ZN(n320) );
  ND2D1BWP16P90 U224 ( .A1(a0[4]), .A2(n323), .ZN(n318) );
  XOR2D1BWP16P90 U225 ( .A1(a1[4]), .A2(a2[4]), .Z(n323) );
  XOR2D1BWP16P90 U226 ( .A1(n324), .A2(a3[3]), .Z(n269) );
  CKND1BWP16P90 U227 ( .I(n225), .ZN(n310) );
  ND2D1BWP16P90 U228 ( .A1(n316), .A2(n317), .ZN(n225) );
  IOA21D1BWP16P90 U229 ( .A1(a2[3]), .A2(a1[3]), .B(n325), .ZN(n317) );
  OAI22D1BWP16P90 U230 ( .A1(n326), .A2(n327), .B1(n324), .B2(n328), .ZN(n316)
         );
  CKND1BWP16P90 U231 ( .I(a3[3]), .ZN(n328) );
  XOR2D1BWP16P90 U232 ( .A1(n327), .A2(a4[3]), .Z(n324) );
  OAI21D1BWP16P90 U233 ( .A1(a0[3]), .A2(n329), .B(n325), .ZN(n327) );
  ND2D1BWP16P90 U234 ( .A1(a0[3]), .A2(n329), .ZN(n325) );
  XOR2D1BWP16P90 U235 ( .A1(a1[3]), .A2(a2[3]), .Z(n329) );
  CKND1BWP16P90 U236 ( .I(a4[3]), .ZN(n326) );
endmodule

