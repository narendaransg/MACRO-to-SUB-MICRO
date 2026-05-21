`include "full_adder.v"

module RC_Adder_Sub #(parameter WIDTH = 4)(
  input [WIDTH-1:0] a,
  input [WIDTH-1:0] b,
  input ctrl,
  output [WIDTH-1:0] sum,
  output [WIDTH-1:0] cout
);
  wire [WIDTH-1:0] bctrl;
  genvar i;

  assign bctrl[0] = b[0] ^ ctrl;

  full_adder fa1(.in1(a[0]), .in2(bctrl[0]), .cin(ctrl), .sum(sum[0]), .cout(cout[0]));

  generate
    for(i = 1; i < WIDTH; i++) begin
      assign bctrl[i] = b[i] ^ ctrl;
      full_adder fa1(.in1(a[i]), .in2(bctrl[i]), .cin(cout[i-1]), .sum(sum[i]), .cout(cout[i]));
    end
  endgenerate
endmodule
