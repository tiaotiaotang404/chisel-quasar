//可以优化的地方：如果想使用行为建模可以将when语句进行修改；各个指令之间有相同的控制信号可以写一起简化代码。
package rv32isc

import chisel3._
import chisel3.util._

import config.Configs._
import utils.ExtOP_TYPES._
import utils.ALUBsrc_TYPES._
import utils.ALUctr_TYPES._
import utils.Branch_TYPES._
import utils.MemOP_TYPES._
import utils._

// ContrGEN的模块接口
class ContrGenIO extends Bundle {
    val ExtOP = Output(UInt(ExtOP_TYPE_WIDTH.W))
    val RegWr = Output(Bool())
    val ALUAsrc = Output(Bool())
    val ALUBsrc = Output(UInt(ALUBsrc_TYPE_WIDTH.W))
    val ALUctr = Output(UInt(ALUctr_TYPE_WIDTH.W))
    val Branch = Output(UInt(Branch_TYPE_WIDTH.W))
    val MemtoReg = Output(Bool())
    val MemWr = Output(Bool())
    val MemOP = Output(UInt(MemOP_TYPE_WIDTH.W))

    val op = Input(UInt(7.W)) // 操作码
    val func3 = Input(UInt(3.W))
    val func7 = Input(UInt(7.W))
}

class ContrGEN extends Module {
    val io = IO(new ContrGenIO()) // 输入输出接口

    // 用于控制信号
    val ExtOP_v = WireDefault(0.U(ExtOP_TYPE_WIDTH.W))
    val RegWr_v = WireDefault(false.B)
    val ALUAsrc_v = WireDefault(false.B)
    val ALUBsrc_v = WireDefault(0.U(ALUBsrc_TYPE_WIDTH.W))
    val ALUctr_v = WireDefault(0.U(ALUctr_TYPE_WIDTH.W))
    val Branch_v = WireDefault(0.U(Branch_TYPE_WIDTH.W))
    val MemtoReg_v = WireDefault(false.B)
    val MemWr_v = WireDefault(false.B)
    val MemOP_v = WireDefault(0.U(MemOP_TYPE_WIDTH.W))

    // 根据opcode对控制信号赋值
    switch(io.op(6, 2)) {
        // U: LUI
        is("b01101".U) {
            ExtOP_v := ExtOP_U
            RegWr_v := true.B // 写回目标寄存器rd
            ALUBsrc_v := ALUBsrc_imm
            ALUctr_v := ALUctr_B
            MemtoReg_v := false.B
        }
        // U:AUIPC
        is("b00101".U) {
            ExtOP_v := ExtOP_U
            RegWr_v := true.B // 写回目标寄存器rd
            ALUAsrc_v := true.B // PC
            ALUBsrc_v := ALUBsrc_imm
            ALUctr_v := ALUctr_ADD
            MemtoReg_v := false.B // 将ALU结果传入rd
        }
        // J: JAL
        is("b11011".U) {
            ExtOP_v := ExtOP_J
            RegWr_v := true.B
            ALUAsrc_v := true.B // PC
            ALUBsrc_v := ALUBsrc_imm
            ALUctr_v := ALUctr_ADD
            Branch_v := Branch_JAL
            MemtoReg_v := false.B
        }
        // I: JALR,
        // I: LB, LH, LW, LBU, LHU
        // I: ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI
        is("b11001".U, "b00000".U, "b00100".U) {
            ExtOP_v := ExtOP_I
            // JALR
            when(io.op(6, 2) === "b11001".U) {
                RegWr_v := true.B // 写回目标寄存器rd
                ALUAsrc_v := true.B // PC
                ALUBsrc_v := ALUBsrc_4
                ALUctr_v := ALUctr_ADD
                Branch_v := Branch_JALR
                MemtoReg_v := false.B
            }
                // LOAD
                .elsewhen(io.op(6, 2) === "b00000".U) {
                    RegWr_v := true.B // 写回目标寄存器rd
                    ALUAsrc_v := false.B // rs1
                    ALUBsrc_v := ALUBsrc_imm
                    ALUctr_v := ALUctr_ADD
                    Branch_v := Branch_N
                    MemtoReg_v := true.B // 将内存数据传入rd
                    MemWr_v := false.B // 只读存储器
                    when(io.func3 === "b000".U) {
                        MemOP_v := MemOP_1byte_se
                    }
                    when(io.func3 === "b001".U) {
                        MemOP_v := MemOP_2byte_se
                    }
                    when(io.func3 === "b010".U) {
                        MemOP_v := MemOP_4byte
                    }
                    when(io.func3 === "b100".U) {
                        MemOP_v := MemOP_1byte
                    }
                    when(io.func3 === "b101".U) {
                        MemOP_v := MemOP_2byte
                    }
                }
                // AL
                .elsewhen(
                    io.op(
                        6,
                        2
                    ) === "b00100".U && (io.func3 === "b001".U || io.func3 === "b101".U)
                ) { // SLLI, SRLI, SRAI 这三条的立即数处理不同于Imm_I
                    RegWr_v := true.B // 写回目标寄存器rd
                    ALUAsrc_v := false.B // rs1
                    ALUBsrc_v := ALUBsrc_rs2
                    Branch_v := Branch_N
                    MemtoReg_v := false.B // 将内存数据传入rd
                    switch(Cat(io.func7(6), io.func3)) {
                        // SLLI
                        is("b0001".U) {
                            ALUctr_v := ALUctr_SLL
                        }
                        // SRLI
                        is("b0101".U) {
                            ALUctr_v := ALUctr_SRL
                        }
                        // SRAI
                        is("b1101".U) {
                            ALUctr_v := ALUctr_SRA
                        }
                    }
                }
                .otherwise {
                    RegWr_v := true.B // 写回目标寄存器rd
                    ALUAsrc_v := false.B // rs1
                    ALUBsrc_v := ALUBsrc_imm
                    Branch_v := Branch_N
                    MemtoReg_v := false.B // 将内存数据传入rd
                    switch(io.func3) {
                        // ADDI
                        is("b000".U) {
                            ALUctr_v := ALUctr_ADD
                        }
                        // SLTI
                        is("b010".U) {
                            ALUctr_v := ALUctr_SLT
                        }
                        // SLTIU
                        is("b011".U) {
                            ALUctr_v := ALUctr_SLTU
                        }
                        // XORI
                        is("b100".U) {
                            ALUctr_v := ALUctr_XOR
                        }
                        // ORI
                        is("b110".U) {
                            ALUctr_v := ALUctr_OR
                        }
                        // ANDI
                        is("b111".U) {
                            ALUctr_v := ALUctr_AND
                        }
                    }
                }
        }
        // B: BEQ, BNE, BLT, BGE, BLTU, BGEU
        is("b11000".U) {
            ExtOP_v := ExtOP_B
            RegWr_v := false.B // 不写回目标寄存器rd
            ALUAsrc_v := false.B // rs1
            ALUBsrc_v := ALUBsrc_rs2
            MemtoReg_v := false.B
            switch(io.func3) {
                // BEQ
                is("b000".U) {
                    ALUctr_v := ALUctr_SLT
                    Branch_v := Branch_BEQ
                }
                // BNE
                is("b001".U) {
                    ALUctr_v := ALUctr_SLT
                    Branch_v := Branch_BNE
                }
                // BLT
                is("b100".U) {
                    ALUctr_v := ALUctr_SLT
                    Branch_v := Branch_BLT
                }
                // BGE
                is("b101".U) {
                    ALUctr_v := ALUctr_SLT
                    Branch_v := Branch_BGE
                }
                // BLTU
                is("b110".U) {
                    ALUctr_v := ALUctr_SLTU
                    Branch_v := Branch_BLT
                }
                // BGEU
                is("b111".U) {
                    ALUctr_v := ALUctr_SLTU
                    Branch_v := Branch_BGE
                }
            }
        }
        // S: SB, SH, SW
        is("b01000".U) {
            ExtOP_v := ExtOP_S
            RegWr_v := false.B // 不写回目标寄存器rd
            ALUAsrc_v := false.B // rs1
            ALUBsrc_v := ALUBsrc_imm
            ALUctr_v := ALUctr_ADD
            Branch_v := Branch_N
            MemWr_v := true.B // 写入存储器

            when(io.func3 === "b000".U) {
                MemOP_v := MemOP_1byte
            }
            when(io.func3 === "b001".U) {
                MemOP_v := MemOP_2byte
            }
            when(io.func3 === "b010".U) {
                MemOP_v := MemOP_4byte
            }
        }
        // R: ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND
        is("b01100".U) {
            ExtOP_v := 0.U
            RegWr_v := true.B // 写回目标寄存器rd
            ALUAsrc_v := false.B // rs1
            ALUBsrc_v := ALUBsrc_rs2
            Branch_v := Branch_N
            MemtoReg_v := false.B // 将内存数据传入rd
            switch(io.func3) {
                // ADD, SUB
                is("b000".U) {
                    when(io.func7(6)) {
                        ALUctr_v := ALUctr_SUB
                    }.otherwise {
                        ALUctr_v := ALUctr_ADD
                    }
                }
                // SLL
                is("b001".U) {
                    ALUctr_v := ALUctr_SLL
                }
                // SLT
                is("b010".U) {
                    ALUctr_v := ALUctr_SLT
                }
                // SLTU
                is("b011".U) {
                    ALUctr_v := ALUctr_SLTU
                }
                // XOR
                is("b100".U) {
                    ALUctr_v := ALUctr_XOR
                }
                // SRL, SRA
                is("b101".U) {
                    when(io.func7(6)) {
                        ALUctr_v := ALUctr_SRA
                    }.otherwise {
                        ALUctr_v := ALUctr_SRL
                    }
                }
                // OR
                is("b110".U) {
                    ALUctr_v := ALUctr_OR
                }
                // AND
                is("b111".U) {
                    ALUctr_v := ALUctr_AND
                }
            }
        }
    }
// 连接控制信号和立即数
    io.ExtOP := ExtOP_v
    io.RegWr := RegWr_v
    io.ALUAsrc := ALUAsrc_v
    io.ALUBsrc := ALUBsrc_v
    io.ALUctr := ALUctr_v
    io.Branch := Branch_v
    io.MemtoReg := MemtoReg_v
    io.MemWr := MemWr_v
    io.MemOP := MemOP_v
}

object ContrGENOption extends App {
    emitVerilog(new ContrGEN(), Array("--target-dir", "generated"))
}
