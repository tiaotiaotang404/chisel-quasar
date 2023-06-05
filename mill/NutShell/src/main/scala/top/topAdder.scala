package top

import mycode.Adder
import chisel3._

object topAdder extends App {
  emitVerilog(new Adder(), Array("--target-dir", "generated"))
}
