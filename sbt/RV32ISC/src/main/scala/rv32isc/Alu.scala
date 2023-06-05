package rv32isc

import chisel3._
import chisel3.util._

import config.Configs._
import utils.ALUctr_TYPES._
import utils.ALUBsrc_TYPES._
import utils._

// Alu的模块接口
class AluIO extends Bundle {
    val Result = Output(UInt(DATA_WIDTH.W))
    val Less = Output(Bool())
    val Zero = Output(Bool())

    val PC = Input(UInt(ADDR_WIDTH.W))
    val rs1 = Input(UInt(DATA_WIDTH.W))
    val rs2 = Input(UInt(DATA_WIDTH.W))
    val imm = Input(UInt(DATA_WIDTH.W))
    val ALUAsrc = Input(Bool())
    val ALUBsrc = Input(UInt(ALUBsrc_TYPE_WIDTH.W))
    val ALUctr = Input(UInt(ALUctr_TYPE_WIDTH.W))
}
// Alu模块
class Alu extends Module {
    val io = IO(new AluIO()) // 输入输出接口

    val Alu_a = Mux(io.ALUAsrc, io.PC, io.rs1)
    val Alu_b = MuxLookup(
        io.ALUBsrc,
        0.U,
        Array(
            "b00".U -> io.rs2,
            "b01".U -> io.imm,
            "b10".U -> 4.U
        )
    )

    val Result_v = WireDefault(0.U(DATA_WIDTH.W))
    val Less_v = WireDefault(false.B)
    val Zero_v = WireDefault(false.B)
    switch(io.ALUctr) {
        is(ALUctr_ADD) {
            Result_v := Alu_a +& Alu_b
        }
        is(ALUctr_SUB) {
            Result_v := Alu_a -& Alu_b
        }
        is(ALUctr_B) {
            Result_v := Alu_b
        }
        is(ALUctr_AND) {
            Result_v := Alu_a & Alu_b
        }
        is(ALUctr_OR) {
            Result_v := Alu_a | Alu_b
        }
        is(ALUctr_XOR) {
            Result_v := Alu_a ^ Alu_b
        }
        is(ALUctr_SLL) {
            Result_v := Alu_a << Alu_b(4, 0)
        }
        is(ALUctr_SRL) {
            Result_v := Alu_a >> Alu_b(4, 0)
        }
        is(ALUctr_SRA) { // 需要注意算术右移的写法
            Result_v := (Alu_a.asSInt >> Alu_b(4, 0)).asUInt
        }
        is(ALUctr_SLT) { // 做减法，选择带符号小于置位结果输出, Less按带符号结果设置
            val diff_s = Alu_a.asSInt - Alu_b.asSInt
            Result_v := Mux(diff_s < 0.S, 1.U, 0.U)
            Less_v := Mux(diff_s < 0.S, true.B, false.B)
        }
        is(ALUctr_SLTU) { // 做减法，选择无符号小于置位结果输出, Less按无符号结果设置
            val diff_u = Alu_a.asUInt - Alu_b.asUInt
            Result_v := Mux(diff_u < 0.U, 1.U, 0.U)
            Less_v := Mux(diff_u < 0.U, true.B, false.B)
        }
    }
    Zero_v := Mux(Result_v === 0.U, 1.U, 0.U)

    io.Result := Result_v
    io.Less := Less_v
    io.Zero := Zero_v
}
object AluOption extends App {
    emitVerilog(new Alu(), Array("--target-dir", "generated"))
}
