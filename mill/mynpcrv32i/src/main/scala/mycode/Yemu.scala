import chisel3._
import chisel3.util._

class NPC extends Module {
  val io = IO(new Bundle { val halt = Output(Bool()) })
  val R = Mem(32, UInt(32.W))
  val PC = RegInit(0.U(32.W))
  val M = Mem(1024 / 4, UInt(32.W))
  def Rread(idx: UInt) = Mux(idx === 0.U, 0.U(32.W), R(idx))

  val Ibundle = new Bundle {
    val imm11_0 = UInt(12.W)
    val rs1 = UInt(5.W)
    val funct3 = UInt(3.W)
    val rd = UInt(5.W)
    val opcode = UInt(7.W)
  }
  // def SignEXT(imm11_0: UInt) = Cat(Fill(52, imm11_0(11)), imm11_0)
  // 立即数操作
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
  def immB(imm11_0: UInt, rd: UInt) = Cat(
    Fill(19, imm11_0(11)),
    imm11_0(11),
    rd(0),
    imm11_0(10, 5),
    rd(4, 1),
    0.U(1.W)
  )

  val inst = M(PC).asTypeOf(Ibundle)
  val isAddi = (inst.opcode === "b0010011".U) && (inst.funct3 === "b000".U)
  val isEbreak = inst.asUInt === "x00100073".U
  val isJal = inst.opcode === "b1101111".U
  // assert(isAddi || isEbreak || isJal, "Invalid instruction 0x%x", inst.asUInt)

  val rs1Val = Rread(Mux(isEbreak, 10.U(5.W), inst.rs1))
  val rs2Val = Rread(Mux(isEbreak, 11.U(5.W), 0.U(5.W)))
  when(isAddi) { R(inst.rd) := rs1Val + immI(inst.imm11_0) }
  when(isEbreak && (rs1Val === 0.U)) { printf("%c", rs2Val(7, 0)) }
  when(isJal) { R(inst.rd) := PC + 4.U; PC := PC + immI(inst.imm11_0) }
  io.halt := isEbreak && (rs1Val === 1.U)
  PC := PC + 4.U
}

object NPCOption extends App {
  emitVerilog(new NPC(), Array("--target-dir", "generated"))
}
