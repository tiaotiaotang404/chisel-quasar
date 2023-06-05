package rv32isc

import chisel3._
import chisel3.util._

import config.Configs._
import utils._

//Top的模块接口
class TopIO extends Bundle {
    val clk = Input(Clock())
}

class Top extends Module {
    val io = IO(new TopIO())

    val alu = Module(new Alu())
    val regFile = Module(new RegFile())
    val branchcond = Module(new BranchCond())
    val contrgen = Module(new ContrGEN())
    val datamem = Module(new DataMem())
    val immgen = Module(new ImmGen())
    val meminst = Module(new MemInst())
    val pcreg = Module(new PCReg())
    val memtoreg = Module(new MemtoReg())
    val pc = Module(new PC())
    val instrop = Module(new Instrop())

    // PC in
    pc.io.NextPC <> pcreg.io.NextPC
    pc.io.pcclk <> io.clk

    // MemInst in
    meminst.io.addr <> pcreg.io.NextPC
    meminst.io.MemInstclk <> io.clk

    // Instrop in
    instrop.io.Instr <> meminst.io.Instr

    // RegFile in
    regFile.io.Ra <> instrop.io.rs1
    regFile.io.Rb <> instrop.io.rs2
    regFile.io.Rw <> instrop.io.rd
    regFile.io.busW <> memtoreg.io.DataOut
    regFile.io.RegWr <> contrgen.io.RegWr
    regFile.io.RegFileclk <> io.clk

    // ImmGen in
    immgen.io.Instr_31_7 <> instrop.io.Instr_ImmGen
    immgen.io.ExtOp <> contrgen.io.ExtOP

    // ContrGEN in
    contrgen.io.op <> instrop.io.op
    contrgen.io.func3 <> instrop.io.func3
    contrgen.io.func7 <> instrop.io.func7

    // PCReg in
    pcreg.io.PCAsrc <> branchcond.io.PCAsrc
    pcreg.io.PCBsrc <> branchcond.io.PCBsrc
    pcreg.io.PC <> pc.io.PC
    pcreg.io.rs1 <> regFile.io.busA
    pcreg.io.imm <> immgen.io.Imm

    // Alu in
    alu.io.PC <> pc.io.PC
    alu.io.rs1 <> regFile.io.busA
    alu.io.rs2 <> regFile.io.busB
    alu.io.imm <> immgen.io.Imm
    alu.io.ALUAsrc <> contrgen.io.ALUAsrc
    alu.io.ALUBsrc <> contrgen.io.ALUBsrc
    alu.io.ALUctr <> contrgen.io.ALUctr

    // BranchCond in
    branchcond.io.Branch <> contrgen.io.Branch
    branchcond.io.Less <> alu.io.Less
    branchcond.io.Zero <> alu.io.Zero

    // DataMem in
    datamem.io.Addr <> alu.io.Result
    datamem.io.MemOp <> contrgen.io.MemOP
    datamem.io.DataIn <> regFile.io.busB
    datamem.io.MemWr <> contrgen.io.MemWr
    datamem.io.rdclk <> io.clk
    datamem.io.wrclk <> io.clk

    // MemtoReg in
    memtoreg.io.Alu_result <> alu.io.Result
    memtoreg.io.DataMem_result <> datamem.io.DataOut
    memtoreg.io.Memtoreg <> contrgen.io.MemtoReg

}

object TopOption extends App {
    emitVerilog(new Top(), Array("--target-dir", "generated"))
}
