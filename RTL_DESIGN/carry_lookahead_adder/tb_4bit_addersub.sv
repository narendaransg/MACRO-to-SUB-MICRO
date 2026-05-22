module TB;

  reg  [3:0] A, B;
  reg        ctrl;
  wire [3:0] S;
  wire       Cout;

  CLA4_Add_Sub dut(
    .a(A),
    .b(B),
    .ctrl(ctrl),
    .sum(S),
    .cout(Cout)
  );

  initial begin
    $monitor("ctrl=%b: A=%b, B=%b --> S=%b, Cout=%b", 
              ctrl, A, B, S, Cout);

    // Addition: ctrl = 0
    ctrl = 0;
    A = 4'b0001; B = 4'b0000; #3;  // 1 + 0 = 1
    A = 4'b0010; B = 4'b0100; #3;  // 2 + 4 = 6
    A = 4'b1011; B = 4'b0110; #3;  // 11 + 6 = 17

    // Subtraction: ctrl = 1
    ctrl = 1;
    A = 4'b0001; B = 4'b0000; #3;  // 1 - 0 = 1
    A = 4'b0010; B = 4'b0100; #3;  // 2 - 4 = -2
    A = 4'b1011; B = 4'b0110; #3;  // 11 - 6 = 5
    A = 4'b0101; B = 4'b0011; #3;  // 5 - 3 = 2

    $finish;
  end

  initial begin
    $dumpfile("waves.vcd");
    $dumpvars;
  end

endmodule
