module  CLA_16bit #(parameter WIDTH = 16)(
  input [WIDTH -1:0] a,
  input [WIDTH -1:0] b,
  input cin,
  output wire [WIDTH -1:0] sum,
  output wire cout
);
  wire c4,c8,c12;
  
  CLA4_bit cla1(.a(a[3:0]), .b(b[3:0]), .cin(cin), .sum(sum[3:0]), .cout(c4));
  CLA4_bit cla2(.a(a[7:4]), .b(b[7:4]), .cin(c4), .sum(sum[7:4]), .cout(c8));
  CLA4_bit cla3(.a(a[11:8]), .b(b[11:8]), .cin(c8), .sum(sum[11:8]), .cout(c12));
  CLA4_bit cla4(.a(a[15:12]), .b(b[15:12]), .cin(c12), .sum(sum[15:12]), .cout(cout));
  
  
endmodule

module CLA4_bit #(parameter WIDTH = 4)(
  input [WIDTH -1:0] a,
  input [WIDTH -1:0] b,
  input cin,
  output wire [WIDTH -1:0] sum,
  output wire cout
);
  wire [WIDTH -1:0] g;
  wire [WIDTH -1:0] p;
  wire [WIDTH :0] c;//5 bit to store the final carry and internal carries
  
  assign g = a & b; //carry generate
  assign p = a ^ b; //carry propagate
  
  assign c[0] = cin;
  assign c[1] = g[0] + (p[0]& c[0]);
  assign c[2] = g[1] + (p[1]& c[1]);
  assign c[3] = g[2] + (p[2]& c[2]);
  assign c[4] = g[3] + (p[3]& c[3]);
  
  assign sum =  p ^ c[WIDTH -1:0]; // xoring internal carry to each propagate
  assign cout = c[WIDTH]; //assigning MSB (final carry) to cout
endmodule
