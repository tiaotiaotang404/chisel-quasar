package rv32isc

import chisel3._
import chisel3.util._

import config.Configs._
import utils._

// PC的模块接口
class PCIO extends Bundle {
    val PC = Output(UInt(ADDR_WIDTH.W))

    val NextPC = Input(UInt(ADDR_WIDTH.W))
    val pcclk = Input(Clock())
}

// PC模块

class PC extends Module {
    val io = IO(new PCIO()) // 输入输出接口

    val reg = RegInit(0.U(32.W))
    withClock((~io.pcclk.asUInt.asBool).asClock) {
        reg := io.NextPC
        io.PC := reg
    }
}

object PCOption extends App {
    emitVerilog(new PC(), Array("--target-dir", "generated"))
}
