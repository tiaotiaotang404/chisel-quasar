package npc

import chisel3._
import chisel3.util._

class npc_RV32I extends Module {
  val io = IO(new Bundle { val halt = Output(Bool()) })
  val R = Mem(32, UInt(32.W))
  val PC = RegInit("h80000000".U(32.W))
  val M = Mem(1024 / 4, UInt(32.W))
  def Rread(idx: UInt) = Mux(idx === 0.U, 0.U(32.W), R(idx))

  val Ibundle = new Bundle {
    val opcode = UInt(7.W)
    val rd = UInt(5.W)
    val funct3 = UInt(3.W)
    val rs1 = UInt(5.W)
    val imm11_0 = UInt(12.W)
  }
//立即数操作
  def immI(imm11_0: UInt) = Cat(Fill(20, imm11_0(11)), imm11_0)
  def immU(imm11_0: UInt, rs1: UInt, funct3: UInt) =
    Cat(imm11_0, rs1, funct3, 0.U(12.W))
  def immS(imm11_0: UInt, rd: UInt) =
    Cat(Fill(20, imm11_0(11)), imm11_0(11, 5), rd)
  def immJ(imm11_0: UInt, rs1: UInt, funct3: UInt) = Cat(
    Fill(11, imm11_0(11)),
    imm11_0(11),
    rs1,
    funct3,
    imm11_0(0),
    imm11_0(10, 1),
    0.U(1.W)
  )
  def immB(imm11_0: UInt) = Cat(
    Fill(19, imm11_0(11)),
    imm11_0(11),
    rd(0),
    imm11_0(10, 5),
    rd(4, 1),
    0.U(1.W)
  )
//取指
  val inst = M(PC).asTypeOf(Ibundle)
//译码
  trait HasInstrType { // 定义一个指令的特质
    // 指令类型,对立即数进行操作
    sealed trait InstrType
    case object InstrR extends InstrType
    case object InstrI extends InstrType
    case object InstrS extends InstrType
    case object InstrB extends InstrType
    case object InstrU extends InstrType
    case object InstrJ extends InstrType

    // 功能单元类型，判断指令运算的模块
    sealed trait FuType
    case object alu extends FuType

    // 运算类型，判断指令执行功能单元的具体运算
    sealed trait ALUOpType
    case object addi extends ALUOpType
    case object ebreak extends ALUOpType
    // add...
    // 指令类型 -> 功能单元类型 -> 运算类型列表
    val table: Array[(BitPat, List[Any])]
  }

  object RV32IInstr extends HasInstrType { // 查找表
    def ADDI = BitPat("b???????_?????_?????_000_?????_0010011")
    def EBREAK = BitPat("b0000000_00000_00000_000_00000_1110011")
    // add...
    val table = Array( // 指令类型，功能单元，操作类型
      ADDI -> List(InstrR, alu, addi),
      EBREAK -> List(InstrI, alu, ebreak), // 不知道ebreak指令属于哪个运算单元，先放在这里
      // add...
    )
  }

  //val instrType = RV32IInstr.table(inst) // 指令匹配，存入instrType
  val instrType = RV32IInstr.table.find(_._1 === inst).map(_._2).getOrElse(Nil)
//执行
  // ALU功能运算单元
  trait ALU extends HasInstrType {
    def aluOpFunc(
        aluOp: ALUOpType,
        rs1val: UInt,
        rs2val: UInt,
        imm: UInt
        // rdval: UInt
    ): UInt = {
      MuxLookup[ALUOpType, UInt](
        aluOp,
        0.U,
        Array(
          addi -> (rs1val + imm)
          ebreak -> 
        )
      )
    }
  }
  object ALUFUN extends ALU {
    def execute(
        aluOp: ALUOpType,
        rs1val: UInt,
        rs2val: UInt,
        imm: UInt
    ): UInt = {
      val result = aluOpFunc(aluOp, rs1val, rs2val, imm)
      result
    }
  }

  // ebreal功能单元
  // 不知道咋写，先留个空
  // 调用
  object Execute {
    val result1 = ALUFUN.execute(inst, rs1val, rs2val, imm)
    // val result2 = ebreak功能单元

  }
  io.halt := isEbreak && (rs1Val === 1.U)
  // 更新PC
  PC := PC + 4.U
}

object npcOption extends App {
  emitVerilog(new npc_RV32I(), Array("--target-dir", "generated"))
}