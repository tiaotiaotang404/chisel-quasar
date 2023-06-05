module Adder(
  input         clock,
  input         reset,
  input  [63:0] io_src0,
  input  [63:0] io_src1,
  output [63:0] io_result
);
  assign io_result = io_src0 + io_src1; // @[Adder.scala 13:24]
endmodule
