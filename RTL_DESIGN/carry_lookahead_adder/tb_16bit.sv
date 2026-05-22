module TB;

  reg  [15:0] A, B; 
  reg         Cin;
  wire [15:0] S;
  wire        Cout;
  wire [16:0] add;
  
  CLA_16bit cla(
    .a(A),
    .b(B),
    .cin(Cin),
    .sum(S),
    .cout(Cout)
  );
  
  assign add = {Cout, S};

  initial begin
    $monitor("A=%h, B=%h, Cin=%b --> S=%h, Cout=%b, Addition=%0d",
              A, B, Cin, S, Cout, add);

    A = 16'd1;     B = 16'd0;     Cin = 0; #3;
    A = 16'd2;     B = 16'd4;     Cin = 1; #3;
    A = 16'h00AB;  B = 16'h0006;  Cin = 0; #3;
    A = 16'd5;     B = 16'd3;     Cin = 1; #3;
    A = 16'hFFFF;  B = 16'd1;     Cin = 0; #3;
    A = 16'hAAAA;  B = 16'h5555;  Cin = 1; #3;

    $finish;
  end

endmodule
