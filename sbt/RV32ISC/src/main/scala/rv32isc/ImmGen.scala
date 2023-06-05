package rv32isc

import chisel3._
import chisel3.util._

import config.Configs._
import utils.ExtOP_TYPES._
import utils._

// ImmGen的模块接口
class ImmGenIO extends Bundle {
    val Imm = Output(UInt(ADDR_WIDTH.W))

    val ExtOp = Input(UInt(ExtOP_TYPE_WIDTH.W))
    val Instr_31_7 = Input(UInt(25.W))
}
//ImmGen模块
class ImmGen extends Module {
    val io = IO(new ImmGenIO()) // 输入输出接口

    // 五种立即数
    val imm_i = Cat(Fill(20, io.Instr_31_7(24)), io.Instr_31_7(24, 13))
    val imm_s = Cat(
        Fill(20, io.Instr_31_7(24)),
        io.Instr_31_7(24, 18),
        io.Instr_31_7(4, 0)
    )
    val imm_b = Cat(
        Fill(20, io.Instr_31_7(24)),
        io.Instr_31_7(0),
        io.Instr_31_7(23, 18),
        io.Instr_31_7(4, 1),
        0.U(1.W)
    )
    val imm_u = Cat(io.Instr_31_7(24, 5), Fill(12, 0.U))
    val imm_j = Cat(
        Fill(12, io.Instr_31_7(24)),
        io.Instr_31_7(24),
        io.Instr_31_7(12, 5),
        io.Instr_31_7(13),
        io.Instr_31_7(23, 14),
        Fill(1, 0.U)
    )

    val imm = MuxLookup(
        io.ExtOp,
        0.U,
        Array(
            000.U -> imm_i,
            001.U -> imm_u,
            010.U -> imm_s,
            011.U -> imm_b,
            100.U -> imm_j
        )
    )

    io.Imm := imm
}

object ImmGenOption extends App {
    emitVerilog(new ImmGen(), Array("--target-dir", "generated"))
}
