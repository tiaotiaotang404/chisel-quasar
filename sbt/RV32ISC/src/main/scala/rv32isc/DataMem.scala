package rv32isc

import chisel3._
import chisel3.util._

import config.Configs._
import utils.MemOP_TYPES._
import utils._

// DataMem的模块接口
class DataMemIO() extends Bundle {
    val DataOut = Output(UInt(DATA_WIDTH.W))

    val Addr = Input(UInt(ADDR_WIDTH.W))
    val MemOp = Input(UInt(MemOP_TYPE_WIDTH.W))
    val DataIn = Input(UInt(DATA_WIDTH.W))
    val MemWr = Input(Bool())
    val rdclk = Input(Clock())
    val wrclk = Input(Clock())
}
// DataMem模块
class DataMem extends Module {
    // val io = IO(new DataMemIO(io.rdclk, io.wrclk)) // 输入输出接口
    val io = IO(new DataMemIO())

    // 数据内存
    val mem = Mem(MEM_DATA_SIZE, UInt(DATA_WIDTH.W))
    // 从内存中读取的数
    val dataLoad = WireDefault(0.U(DATA_WIDTH.W))
    // 不论是读还是写，都需要用到这个读数
    dataLoad := mem.read(io.Addr >> DATA_BYTE_WIDTH_LOG.U)

    val DataOut_v = WireDefault(0.U(DATA_WIDTH.W))

    // 写数据
    when(io.MemWr) {
        withClock((~io.wrclk.asUInt.asBool).asClock) {
            when(io.MemOp === MemOP_4byte) { // 修改全部4字节
                mem.write(io.Addr >> DATA_BYTE_WIDTH_LOG.U, io.DataIn)
            }.elsewhen(io.MemOp === MemOP_2byte) { // 修改低2字节，无符号扩展
                mem.write(
                    io.Addr >> DATA_BYTE_WIDTH_LOG.U,
                    Cat(dataLoad(31, 16), io.DataIn(15, 0))
                )
            }.elsewhen(io.MemOp === MemOP_1byte) { // 修改低1字节，无符号扩展
                mem.write(
                    io.Addr >> DATA_BYTE_WIDTH_LOG.U,
                    Cat(dataLoad(31, 8), io.DataIn(7, 0))
                )
            }.elsewhen(io.MemOp === MemOP_2byte_se) { // 修改低2字节，带符号扩展
                val DataIn_2by_s = Cat(
                    Fill(16, io.DataIn(15)),
                    io.DataIn(15, 0)
                ) // 将接收到的低16位进行符号扩展为32位
                mem.write(
                    io.Addr >> DATA_BYTE_WIDTH_LOG.U,
                    DataIn_2by_s
                )
            }.otherwise { /// 修改低1字节，带符号扩展
                val DataIn_1by_s = Cat(
                    Fill(24, io.DataIn(7)),
                    io.DataIn(7, 0)
                ) // 将接收到的低8位进行符号扩展为32位
                mem.write(
                    io.Addr >> DATA_BYTE_WIDTH_LOG.U,
                    DataIn_1by_s
                )
            }
        }
    }
        // 读数据
        .otherwise {
            withClock(io.rdclk) {
                when(io.MemOp === MemOP_4byte) { // 修改全部4字节
                    DataOut_v := dataLoad
                }.elsewhen(io.MemOp === MemOP_2byte) { // 修改低2字节，无符号扩展
                    DataOut_v := Cat(Fill(16, 0.U), dataLoad(15, 0))
                }.elsewhen(io.MemOp === MemOP_1byte) { // 修改低1字节，无符号扩展
                    DataOut_v := Cat(Fill(24, 0.U), dataLoad(7, 0))
                }.elsewhen(io.MemOp === MemOP_2byte_se) { // 修改低2字节，带符号扩展
                    DataOut_v := Cat(Fill(16, dataLoad(15)), dataLoad(15, 0))
                }.otherwise { /// 修改低1字节，带符号扩展
                    DataOut_v := Cat(Fill(24, dataLoad(7)), dataLoad(7, 0))
                }
            }
        }
    io.DataOut := DataOut_v
}
object DataMemOption extends App {
    emitVerilog(new DataMem(), Array("--target-dir", "generated"))
}
