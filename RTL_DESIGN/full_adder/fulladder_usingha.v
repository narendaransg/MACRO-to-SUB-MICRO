module half_adder(
  input in1, 
  input in2,
  output sum,
  output cout
);
  assign {cout,sum} = in1 + in2;
endmodule

module full_adder(
  input in1,
  input in2,
  input cin,
  output wire sum,
  output wire cout
);
  wire sint, cint, cint2;
  half_adder ha1(.in1(in1), .in2(in2), .sum(sint), .cout(cint));
  half_adder ha2(.in1(sint), .in2(cin), .sum(sum), .cout(cint2));
  assign cout = cint | cint2;
  
endmodule
