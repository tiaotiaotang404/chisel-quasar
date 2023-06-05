circuit Adder :
  module Adder :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip src0 : UInt<64>, flip src1 : UInt<64>, result : UInt<64>}

    node _T = add(io.src0, io.src1) @[Adder.scala 13:24]
    node _T_1 = tail(_T, 1) @[Adder.scala 13:24]
    io.result <= _T_1 @[Adder.scala 13:13]

