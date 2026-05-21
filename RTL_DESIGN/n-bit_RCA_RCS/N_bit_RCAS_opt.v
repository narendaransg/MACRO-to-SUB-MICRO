`include "full_adder.v"
//optimising the code with algotithms and techniques
/*
1. Bit masking						 Best for `B ^ CTRL` logic              
2. Arrays							 Use vectors instead of separate wires 
3. Recursion / Generate blocks		 Scalable WIDTH-based design  
*/

module RC_Adder_Sub #(parameter WIDTH = 4)(
  input [WIDTH-1:0] a,
  input [WIDTH-1:0] b,
  input ctrl,
  output [WIDTH-1:0] sum,
  output cout
);
  wire [WIDTH-1:0] bctrl;
  wire [WIDTH:0] carry;

  
  assign bctrl = b ^ {WIDTH{ctrl}}; //bitmasking
  assign carry[0] = ctrl; //using vector instead of seperate wire
  
  genvar i;
  generate 
    for(i = 0; i < WIDTH; i = i+1) begin :FA_stage
      full_adder fa1(
        .in1(a[i]), 
        .in2(bctrl[i]), 
        .cin(carry[i]), 
        .sum(sum[i]), 
        .cout(carry[i+1]));
    end
  endgenerate
   assign cout = carry[WIDTH];
endmodule
