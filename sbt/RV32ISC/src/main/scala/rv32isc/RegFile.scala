package rv32isc

import chisel3._
import chisel3.util._

import config.Configs._

// RegFile的模块接口
class RegFileIO extends Bundle {
    val busA = Output(UInt(DATA_WIDTH.W))
    val busB = Output(UInt(DATA_WIDTH.W))

    val Ra = Input(UInt(5.W))
    val Rb = Input(UInt(5.W))
    val Rw = Input(UInt(5.W))
    val busW = Input(UInt(DATA_WIDTH.W))
    val RegWr = Input(Bool())
    val RegFileclk = Input(Clock())
}
// RegFile模块
class RegFile extends Module {
    val io = IO(new RegFileIO()) // 输入输出接口

    // 寄存器组，REG_NUMS个，位宽DATA_WIDTH
    val regs = Reg(Vec(REG_NUMS, UInt(DATA_WIDTH.W)))
    withClock((~io.RegFileclk.asUInt.asBool).asClock) {
        // 寄存器号为0时读到0
        when(io.Ra === 0.U) {
            io.busA := 0.U
        }
        when(io.Rb === 0.U) {
            io.busB := 0.U
        }
        // 否则给出数据
        io.busA := regs(io.Ra)
        io.busB := regs(io.Rb)
        // 给出写信号，且rd不为0时写寄存器
        when(io.RegWr && io.Rw =/= 0.U) {
            regs(io.Rw) := io.busW
        }
    }
}

object RegFileOption extends App {
    emitVerilog(new RegFile(), Array("--target-dir", "generated"))
}
