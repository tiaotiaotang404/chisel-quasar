package utils

import chisel3._

object ExtOP_TYPES {
    val ExtOP_TYPE_WIDTH = 3
    val ExtOP_I = "b000".U
    val ExtOP_U = "b001".U
    val ExtOP_S = "b010".U
    val ExtOP_B = "b011".U
    val ExtOP_J = "b100".U
}

object ALUBsrc_TYPES {
    val ALUBsrc_TYPE_WIDTH = 2
    val ALUBsrc_rs2 = "b00".U
    val ALUBsrc_imm = "b01".U
    val ALUBsrc_4 = "b10".U
}

object ALUctr_TYPES {
    val ALUctr_TYPE_WIDTH = 4
    val ALUctr_ADD = "b0000".U // 选择加法器输出，做加法
    val ALUctr_SUB = "b1000".U // 选择加法器输出，做减法
    val ALUctr_SLL = "b_001".U // 选择移位器输出，左移
    val ALUctr_SLT = "b0010".U // 做减法，选择带符号小于置位结果输出, Less按带符号结果设置
    val ALUctr_SLTU = "b1010".U // 做减法，选择无符号小于置位结果输出, Less按无符号结果设置
    val ALUctr_B = "b_011".U // 选择ALU输入B的结果直接输出
    val ALUctr_XOR = "b_100".U // 选择异或输出
    val ALUctr_SRL = "b0101".U // 选择移位器输出，逻辑右移
    val ALUctr_SRA = "b1101".U // 选择移位器输出，算术右移
    val ALUctr_OR = "b_110".U // 选择逻辑或输出
    val ALUctr_AND = "b_111".U // 选择逻辑与输出
}

object Branch_TYPES {
    val Branch_TYPE_WIDTH = 3
    val Branch_N = "b000".U // 非跳转指令
    val Branch_JAL = "b001".U // 无条件跳转PC目标
    val Branch_JALR = "b010".U // 无条件跳转寄存器目标
    val Branch_BEQ = "b100".U // 条件分支，等于
    val Branch_BNE = "b101".U // 条件分支，不等于
    val Branch_BLT = "b110".U // 条件分支，小于
    val Branch_BGE = "b111".U // 条件分支，大于等于
}

object MemOP_TYPES {
    val MemOP_TYPE_WIDTH = 3
    val MemOP_4byte = "b010".U // 4字节读写
    val MemOP_2byte_se = "b001".U // 2字节读写带符号扩展
    val MemOP_1byte_se = "b000".U // 1字节读写带符号扩展
    val MemOP_2byte = "b101".U // 2字节读写无符号扩展
    val MemOP_1byte = "b100".U // 1字节读写无符号扩展
}
