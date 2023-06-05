package rv32isc

import chisel3._
import chisel3.util._

import config.Configs._
import utils.Branch_TYPES._
import utils._

// BranchCond的模块接口
class BranchCondIO extends Bundle {
    val PCAsrc = Output(Bool())
    val PCBsrc = Output(Bool())

    val Branch = Input(UInt(Branch_TYPE_WIDTH.W))
    val Less = Input(Bool())
    val Zero = Input(Bool())
}
//BranchCond模块
class BranchCond extends Module {
    val io = IO(new BranchCondIO()) // 输入输出接口

    val PCAsrc_v = MuxLookup(
        Cat(io.Branch, io.Less, io.Zero),
        false.B,
        Array(
            00000.U -> false.B,
            00001.U -> false.B,
            00010.U -> false.B,
            00011.U -> false.B,
            00100.U -> true.B,
            00101.U -> true.B,
            00110.U -> true.B,
            00111.U -> true.B,
            01000.U -> true.B,
            01001.U -> true.B,
            01010.U -> true.B,
            01011.U -> true.B,
            10000.U -> false.B,
            10001.U -> false.B,
            10010.U -> true.B,
            10011.U -> true.B,
            10100.U -> true.B,
            10101.U -> true.B,
            10110.U -> false.B,
            10111.U -> false.B,
            11000.U -> false.B,
            11010.U -> false.B,
            11001.U -> true.B,
            11011.U -> true.B,
            11100.U -> true.B,
            11110.U -> true.B,
            11101.U -> false.B,
            11111.U -> false.B
        )
    )
    val PCBsrc_v = MuxLookup(
        Cat(io.Branch, io.Less, io.Zero),
        false.B,
        Array(
            00000.U -> false.B,
            00001.U -> false.B,
            00010.U -> false.B,
            00011.U -> false.B,
            00100.U -> false.B,
            00101.U -> false.B,
            00110.U -> false.B,
            00111.U -> false.B,
            01000.U -> true.B,
            01001.U -> true.B,
            01010.U -> true.B,
            01011.U -> true.B,
            10000.U -> false.B,
            10001.U -> false.B,
            10010.U -> false.B,
            10011.U -> false.B,
            10100.U -> false.B,
            10101.U -> false.B,
            10110.U -> false.B,
            10111.U -> false.B,
            11000.U -> false.B,
            11010.U -> false.B,
            11001.U -> false.B,
            11011.U -> false.B,
            11100.U -> false.B,
            11110.U -> false.B,
            11101.U -> false.B,
            11111.U -> false.B
        )
    )

    io.PCAsrc := PCAsrc_v
    io.PCBsrc := PCBsrc_v
}

object BranchCondOption extends App {
    emitVerilog(new BranchCond(), Array("--target-dir", "generated"))
}
