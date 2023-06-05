package rv32isc

import chisel3._
import chisel3.util._

import config.Configs._

import utils._

// MemtoReg的模块接口
class MemtoRegIO extends Bundle {
    val DataOut = Output(UInt(DATA_WIDTH.W))

    val Alu_result = Input(UInt(DATA_WIDTH.W))
    val DataMem_result = Input(UInt(DATA_WIDTH.W))
    val Memtoreg = Input(Bool())
}

// MemtoReg模块
class MemtoReg extends Module {
    val io = IO(new MemtoRegIO()) // 输入输出接口

    val DataOut_v = WireDefault(0.U(DATA_WIDTH.W))
    DataOut_v := Mux(io.Memtoreg, io.DataMem_result, io.Alu_result)

    io.DataOut := DataOut_v

}
object MemtoRegOption extends App {
    emitVerilog(new MemtoReg(), Array("--target-dir", "generated"))
}
