package rv32isc

import chisel3._
import chisel3.util._

import config.Configs._

// PCReg的模块接口
class PCRegIO extends Bundle {
  val NextPC = Output(UInt(ADDR_WIDTH.W)) // 目标地址输出
  val PCAsrc = Input(Bool())
  val PCBsrc = Input(Bool())
  val Reset = Input(Bool())
  val PC = Input(UInt(ADDR_WIDTH.W)) // PC
  val rs1 = Input(UInt(ADDR_WIDTH.W)) // rs1
  val imm = Input(UInt(ADDR_WIDTH.W)) // imm
}
// PCReg模块
class PCReg extends Module {
  val io = IO(new PCRegIO()) // 输入输出接口

  val regPC =
    RegInit(UInt(ADDR_WIDTH.W), START_ADDR.U) // PC寄存器，初始化时重置为START_ADDR

  val nextPC =
    Mux(
      io.Reset,
      0.U,
      Mux(io.PCAsrc, 4.U, io.imm) + Mux(io.PCBsrc, io.rs1, io.PC)
    )

  io.NextPC := nextPC // 每个时钟周期输出当前PC寄存内的地址
}
