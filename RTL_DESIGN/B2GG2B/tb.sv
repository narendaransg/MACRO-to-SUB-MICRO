// Code your testbench here
// or browse Examples
module TB;

  parameter WIDTH = 4;

  reg  [WIDTH-1:0] bin_in;
  wire [WIDTH-1:0] gray_out;
  wire [WIDTH-1:0] bin_back;

  integer i;

  b2g #(WIDTH) uut_b2g (
    .bin(bin_in),
    .gray(gray_out)
  );

  g2b #(WIDTH) uut_g2b (
    .gray(gray_out),
    .bin(bin_back)
  );

  initial begin
    $monitor("bin=%b --> gray=%b --> bin_back=%b",
              bin_in, gray_out, bin_back);

    for(i = 0; i < (1 << WIDTH); i = i + 1) begin
      bin_in = i;
      #5;
    end

    $finish;
  end

endmodule
