module ModuleSample(
  input        clock,
  input        reset,
  input  [3:0] io_in_a,
  output [3:0] io_out_b
);
  assign io_out_b = io_in_a; // @[myhello.scala 11:12]
endmodule
