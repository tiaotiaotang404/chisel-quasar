package npc

import chisel3._
import chisel3.util._

class NPC extends Module {
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
    // R-TYPE
    case object add extends ALUOpType
    case object sub extends ALUOpType
    case object sll extends ALUOpType
    case object slt extends ALUOpType
    case object sltu extends ALUOpType
    case object xor extends ALUOpType
    case object srl extends ALUOpType
    case object sra extends ALUOpType
    case object or extends ALUOpType
    case object and extends ALUOpType
    // I-TYPE
    case object addi extends ALUOpType
    case object slti extends ALUOpType
    case object sltiu extends ALUOpType
    case object xori extends ALUOpType
    case object ori extends ALUOpType
    case object andi extends ALUOpType
    case object slli extends ALUOpType
    case object srli extends ALUOpType
    case object srai extends ALUOpType
    case object jalr extends ALUOpType
    case object ebreak extends ALUOpType
    // S-TYPE
    case object sb extends ALUOpType
    case object sh extends ALUOpType
    case object sw extends ALUOpType
    // B-TYPE
    case object beq extends ALUOpType
    case object bne extends ALUOpType
    case object blt extends ALUOpType
    case object bge extends ALUOpType
    case object bltu extends ALUOpType
    case object bgeu extends ALUOpType
    // U-TYPE
    case object lui extends ALUOpType
    case object auipc extends ALUOpType
    // J-TYPE
    case object jal extends ALUOpType

    // add...

    // 指令类型 -> 功能单元类型 -> 运算类型列表
    val table: Array[(BitPat, List[Any])]
  }
  object RV32IInstr extends HasInstrType { // 查找表
    def ADD = BitPat("b0000000_?????_?????_000_?????_0110011")
    def SUB = BitPat("b0100000_?????_?????_000_?????_0110011")
    def SLL = BitPat("b0000000_?????_?????_001_?????_0110011")
    def SLT = BitPat("b0000000_?????_?????_010_?????_0110011")
    def SLTU = BitPat("b0000000_?????_?????_011_?????_0110011")
    def XOR = BitPat("b0000000_?????_?????_100_?????_0110011")
    def SRL = BitPat("b0000000_?????_?????_101_?????_0110011")
    def SRA = BitPat("b0100000_?????_?????_101_?????_0110011")
    def OR = BitPat("b0000000_?????_?????_110_?????_0110011")
    def AND = BitPat("b0000000_?????_?????_111_?????_0110011")

    def ADDI = BitPat("b???????_?????_?????_000_?????_0010011")
    def SLTI = BitPat("b???????_?????_?????_010_?????_0010011")
    def SLTIU = BitPat("b???????_?????_?????_011_?????_0010011")
    def XORI = BitPat("b???????_?????_?????_100_?????_0010011")
    def ORI = BitPat("b???????_?????_?????_110_?????_0010011")
    def ANDI = BitPat("b???????_?????_?????_111_?????_0010011")
    def SLLI = BitPat("b0000000_?????_?????_001_?????_0010011")
    def SRLI = BitPat("b0000000_?????_?????_101_?????_0010011")
    def SRAI = BitPat("b0100000_?????_?????_101_?????_0010011")
    def JALR = BitPat("b???????_?????_?????_011_?????_1100111")
    def EBREAK = BitPat("b0000000_00000_00000_000_00000_1110011")

    def SB = BitPat("b???????_?????_?????_000_?????_0100011")
    def SH = BitPat("b???????_?????_?????_001_?????_0100011")
    def SW = BitPat("b???????_?????_?????_010_?????_0100011")

    def BEQ = BitPat("b???????_?????_?????_000_?????_1100011")
    def BNE = BitPat("b???????_?????_?????_001_?????_1100011")
    def BLT = BitPat("b???????_?????_?????_100_?????_1100011")
    def BGE = BitPat("b???????_?????_?????_101_?????_1100011")
    def BLTU = BitPat("b???????_?????_?????_110_?????_1100011")
    def BGEU = BitPat("b???????_?????_?????_111_?????_1100011")

    def LUI = BitPat("b???????_?????_?????_???_?????_0110111")
    def AUIPC = BitPat("b???????_?????_?????_???_?????_0110111")

    def JAL = BitPat("b???????_?????_?????_011_?????_1101111")

    // add...
    val table = Array( // 指令类型，功能单元，操作类型
      ADD -> List(InstrR, alu, add),
      SUB -> List(InstrR, alu, sub),
      SLL -> List(InstrR, alu, sll),
      SLT -> List(InstrR, alu, slt),
      SLTU -> List(InstrR, alu, sltu),
      XOR -> List(InstrR, alu, xor),
      SRL -> List(InstrR, alu, srl),
      SRA -> List(InstrR, alu, sra),
      OR -> List(InstrR, alu, or),
      AND -> List(InstrR, alu, and),
      ADDI -> List(InstrR, alu, addi),
      SLTI -> List(InstrR, alu, slti),
      SLTIU -> List(InstrR, alu, sltiu),
      XORI -> List(InstrR, alu, xori),
      ORI -> List(InstrR, alu, ori),
      ANDI -> List(InstrR, alu, andi),
      SLLI -> List(InstrR, alu, slli),
      SRLI -> List(InstrR, alu, srli),
      SRAI -> List(InstrR, alu, srai),
      JALR -> List(InstrR, alu, jalr),
      EBREAK -> List(InstrI, alu, ebreak), // 不知道ebreak指令属于哪个运算单元，先放在这里
      JAL -> List(InstrS, alu, jal) // 同ebreak，先放这了
      // add...
    )
  }

  val instrType = RV32IInstr.table(inst) // 指令匹配，存入instrType
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
          add -> (rs1val + rs2val),
          sub -> (rs1val - rs2val),
          sll -> (rs1val << rs2val),
          slt -> (rs1val.asSInt < rs2val.asSInt).asUInt(),
          sltu -> (rs1val < rs2val).asUInt(),
          xor -> (rs1val ^ rs2val),
          srl -> (rs1val >> rs2val),
          sra -> (rs1val.asSInt >> rs2val).asUInt(),
          or -> (rs1val | rs2val),
          and -> (rs1val & rs2val),
          addi -> (rs1val + imm)
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
  // 更新PC
  PC := PC + 4.U
}
