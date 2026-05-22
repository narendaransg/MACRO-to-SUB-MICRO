// Code your design here
module CarryLookAheadAdder#(parameter WIDTH = 4)(
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
