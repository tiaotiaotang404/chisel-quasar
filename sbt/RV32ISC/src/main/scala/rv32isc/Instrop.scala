package rv32isc

import chisel3._
import chisel3.util._

import config.Configs._

// RegFile的模块接口
class InstropIO extends Bundle {
    val rs1 = Output(UInt(5.W))
    val rs2 = Output(UInt(5.W))
    val rd = Output(UInt(5.W))
    val Instr_ImmGen = Output(UInt(24.W))
    val op = Output(UInt(7.W))
    val func3 = Output(UInt(3.W))
    val func7 = Output(UInt(7.W))

    val Instr = Input(UInt(INST_WIDTH.W))
}
// RegFile模块
class Instrop extends Module {
    val io = IO(new InstropIO()) // 输入输出接口
    val Instr_v = WireDefault(0.U(INST_WIDTH.W))

    io.rs1 := Instr_v(19, 15)
    io.rs2 := Instr_v(24, 20)
    io.rd := Instr_v(11, 7)
    io.Instr_ImmGen := Instr_v(31, 7)
    io.op := Instr_v(6, 0)
    io.func3 := Instr_v(14, 12)
    io.func7 := Instr_v(31, 25)

}
object InstropOption extends App {
    emitVerilog(new Instrop(), Array("--target-dir", "generated"))
}
