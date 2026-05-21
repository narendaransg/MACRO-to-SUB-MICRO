module full_adder(
  input in1,
  input in2,
  input cin,
  output wire sum,
  output wire cout
);
  assign {cout, sum} = in1 + in2 + cin;
endmodule
