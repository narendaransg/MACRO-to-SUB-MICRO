module b2g #(parameter WIDTH = 4)(
  input [WIDTH-1 :0] bin,
  output [WIDTH-1:0] gray
);
  assign gray = bin ^ (bin >>1);
endmodule

module g2b #(parameter WIDTH = 4)(
  input [WIDTH-1 :0] gray,
  output [WIDTH-1:0] bin
);
  genvar i;
  generate 
    for(i=0; i<WIDTH; i++) begin
      assign bin[i] = ^ (gray>>i);
    end
  endgenerate
endmodule
