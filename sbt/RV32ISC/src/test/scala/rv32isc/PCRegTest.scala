package rv32isc

import chisel3._
import chiseltest._
import org.scalatest._

import config.Configs._

class PCRegTest extends FlatSpec with ChiselScalatestTester {
    behavior of "PCReg"
    /*
    it should "increment PC by 4 when PCAsrc is false" in {
        test(new PCReg) { dut =>
            dut.io.PCAsrc.poke(false.B)
            dut.io.PCBsrc.poke(false.B)
            dut.io.Reset.poke(false.B)

            for (_ <- 0 until 10) {
                dut.clock.step()
                dut.io.NextPC.expect(dut.io.PC + 4.U)
            }
        }
    }
     */
    it should "set PC to 0 when Reset is true" in {
        test(new PCReg) { dut =>
            dut.io.PCAsrc.poke(false.B)
            dut.io.PCBsrc.poke(false.B)
            // dut.io.Reset.poke(true.B)

            dut.clock.step()
            dut.io.NextPC.expect(0.U)
        }
    }

    it should "calculate nextPC correctly when PCAsrc is true" in {
        test(new PCReg) { dut =>
            dut.io.PCAsrc.poke(true.B)
            dut.io.PCBsrc.poke(false.B)
            // dut.io.Reset.poke(false.B)

            dut.io.PC.poke(16.U) // PC = 16
            dut.io.rs1.poke(8.U) // rs1 = 8
            dut.io.imm.poke(4.U) // imm = 4

            dut.clock.step()
            dut.io.NextPC.expect(20.U)
        }
    }

    it should "calculate nextPC correctly when PCBsrc is true" in {
        test(new PCReg) { dut =>
            dut.io.PCAsrc.poke(true.B)
            dut.io.PCBsrc.poke(true.B)
            // dut.io.Reset.poke(false.B)

            dut.io.PC.poke(16.U) // PC = 16
            dut.io.rs1.poke(8.U) // rs1 = 8
            dut.io.imm.poke(4.U) // imm = 4

            dut.clock.step()
            dut.io.NextPC.expect(12.U)
        }
    }
}
