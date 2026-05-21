module RC_Adder_Sub #(parameter WIDTH = 4)(
  input [WIDTH-1:0] a,
  input [WIDTH-1:0] b,
  input ctrl,
  output [WIDTH-1:0] sum,
  output cout
);

  assign {cout,sum} = a + (b^{WIDTH{ctrl}}) + ctrl;
endmodule
