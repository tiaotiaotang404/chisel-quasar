import chisel3._
import chisel3.util._

class NEMU extends Module {
  val io = IO(new Bundle { val halt = Output(Bool()) })
  val R = Mem(32, UInt(64.W))
  val PC = RegInit(0.U(64.W))
  val M = Mem(1024 / 4, UInt(32.W))
  def Rread(idx: UInt) = Mux(idx === 0.U, 0.U(64.W), R(idx))

  val Ibundle = new Bundle {
    val imm11_0 = UInt(12.W)
    val rs1 = UInt(5.W)
    val funct3 = UInt(3.W)
    val rd = UInt(5.W)
    val opcode = UInt(7.W)
  }
//立即数操作
  def SignEXT(imm11_0: UInt) = Cat(Fill(52, imm11_0(11)), imm11_0)

//取指
  val inst = M(PC(63, 2)).asTypeOf(Ibundle)

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
    case object lsu extends FuType
    case object mul extends FuType
    case object div extends FuType
    case object csr extends FuType

    // 运算类型，判断指令执行功能单元的具体运算
    sealed trait ALUOpType
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
    case object addw extends ALUOpType
    case object subw extends ALUOpType
    case object sllw extends ALUOpType
    case object srlw extends ALUOpType
    case object sraw extends ALUOpType

    sealed trait LSUOpType
    case object lb extends LSUOpType
    case object lh extends LSUOpType
    case object lw extends LSUOpType
    case object ld extends LSUOpType
    case object lbu extends LSUOpType
    case object lhu extends LSUOpType
    case object lwu extends LSUOpType
    case object sb extends LSUOpType
    case object sh extends LSUOpType
    case object sw extends LSUOpType
    case object sd extends LSUOpType

    // 指令类型 -> 功能单元类型 -> 运算类型列表
    val table: Array[(BitPat, List[Any])]
  }
  object RV64IInstr extends HasInstrType { // 查找表
    def ADDIW = BitPat("b???????_?????_?????_000_?????_0011011")
    def SLLIW = BitPat("b0000000_?????_?????_001_?????_0011011")
    def SRLIW = BitPat("b0000000_?????_?????_101_?????_0011011")
    def SRAIW = BitPat("b0100000_?????_?????_101_?????_0011011")
    def SLLW = BitPat("b0000000_?????_?????_001_?????_0111011")
    def SRLW = BitPat("b0000000_?????_?????_101_?????_0111011")
    def SRAW = BitPat("b0100000_?????_?????_101_?????_0111011")
    def ADDW = BitPat("b0000000_?????_?????_000_?????_0111011")
    def SUBW = BitPat("b0100000_?????_?????_000_?????_0111011")
    def LWU = BitPat("b???????_?????_?????_110_?????_0000011")
    def LD = BitPat("b???????_?????_?????_011_?????_0000011")
    def SD = BitPat("b???????_?????_?????_011_?????_0100011")
    // ...
    val table = Array( // 指令类型，功能单元，操作类型
      ADDIW -> List(InstrI, alu, addw),
      SLLIW -> List(InstrI, alu, sllw),
      SRLIW -> List(InstrI, alu, srlw),
      SRAIW -> List(InstrI, alu, sraw),
      SLLW -> List(InstrR, alu, sllw),
      SRLW -> List(InstrR, alu, srlw),
      SRAW -> List(InstrR, alu, sraw),
      ADDW -> List(InstrR, alu, addw),
      SUBW -> List(InstrR, alu, subw),
      LWU -> List(InstrI, lsu, lwu),
      LD -> List(InstrI, lsu, ld),
      SD -> List(InstrS, lsu, sd)
      // ...
    )
  }
  /* inst = Cat(
    Ibundle.imm11_0,
    Ibundle.rs1,
    Ibundle.funct3,
    Ibundle.rd,
    Ibundle.opcode
  ) // 拼接，转换inst的类型，因为table的类型为intbloop类型
   */
  // val instr = instru.asUInt.toInt
  val instrType = RV64IInstr.table(inst) // 指令匹配，存入instrType

  // val isAddi = (inst.opcode === "b0010011".U) && (inst.funct3 === "b000".U)
  // val isEbreak = inst.asUInt === "x00100073".U
  // assert(isAddi || isEbreak, "Invalid instruction 0x%x", inst.asUInt)

//执行
  trait ALU extends HasInstrType {
    def aluOpFunc(aluOp: ALUOpType, src1: UInt, src2: UInt): UInt = {
      MuxLookup[ALUOpType, UInt](
        aluOp,
        0.U,
        Array(
          add -> (src1 + src2),
          sub -> (src1 - src2),
          sll -> (src1 << src2),
          slt -> (src1.asSInt < src2.asSInt).asUInt(),
          sltu -> (src1 < src2).asUInt(),
          xor -> (src1 ^ src2),
          srl -> (src1 >> src2),
          sra -> (src1.asSInt >> src2).asUInt(),
          or -> (src1 | src2),
          and -> (src1 & src2),
          addw -> (src1.asSInt + src2.asSInt).asUInt(),
          subw -> (src1.asSInt - src2.asSInt).asUInt(),
          sllw -> (src1.asSInt << src2).asUInt(),
          srlw -> (src1.asSInt >> src2).asUInt(),
          sraw -> (src1.asSInt >> src2).asUInt()
        )
      )
    }
  }

  /*
  val result = MuxLookup(
    inst.opcode,
    0.U,
    Array(
      // ADDI -> (R(inst.rd) := rs1Val + SignEXT(inst.imm11_0)),
      ADDIW -> ()
    )
  )
   */
// 将结果存入目标寄存器
  when(inst.rd =/= 0.U) {
    inst.rd := result
  }
  // val rs1Val = Rread(Mux(isEbreak, 10.U(5.W), inst.rs1))
  // val rs2Val = Rread(Mux(isEbreak, 11.U(5.W), 0.U(5.W)))
  // when(isAddi) { R(inst.rd) := rs1Val + SignEXT(inst.imm11_0) }
  // when(isEbreak && (rs1Val === 0.U)) { printf("%c", rs2Val(7, 0)) }
  // io.halt := isEbreak && (rs1Val === 1.U)

//更新PC
  PC := PC + 4.U
}
