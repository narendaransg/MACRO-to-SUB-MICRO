module CLA4_Add_Sub #(parameter WIDTH = 4)(
  input  [WIDTH-1:0] a,
  input  [WIDTH-1:0] b,
  input              ctrl,
  output [WIDTH-1:0] sum,
  output             cout
);

  wire [WIDTH-1:0] bctrl;
  wire [WIDTH-1:0] g;
  wire [WIDTH-1:0] p;
  wire [WIDTH:0]   c;

  assign bctrl = b ^ {WIDTH{ctrl}};

  assign g = a & bctrl;
  assign p = a ^ bctrl;

  assign c[0] = ctrl;

  assign c[1] = g[0] | (p[0] & c[0]);
  assign c[2] = g[1] | (p[1] & c[1]);
  assign c[3] = g[2] | (p[2] & c[2]);
  assign c[4] = g[3] | (p[3] & c[3]);

  assign sum  = p ^ c[WIDTH-1:0];
  assign cout = c[WIDTH];

endmodule
