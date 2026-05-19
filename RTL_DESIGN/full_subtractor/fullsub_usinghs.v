module half_subtractor(
  input in1,
  input in2,
  output wire dif,
  output wire bor
);
  assign dif = in1 ^ in2;
  assign bor = ~in1 & in2;
endmodule

module full_subtractor(
  input in1,
  input in2,
  input bin,
  output wire diff,
  output wire bor
);
  wire dint, bint, bint2;
  half_subtractor hs1(.in1(in1), .in2(in2), .dif(dint), .bor(bint));
  half_subtractor hs2(.in1(dint), .in2(bin), .dif(diff), .bor(bint2));
  assign bor = bint | bint2;
endmodule
