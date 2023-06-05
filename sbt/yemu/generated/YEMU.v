module YEMU(
  input   clock,
  input   reset,
  output  io_halt
);
`ifdef RANDOMIZE_MEM_INIT
  reg [63:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [63:0] R [0:31]; // @[yemu.scala 6:14]
  wire  R_rs1Val_MPORT_en; // @[yemu.scala 6:14]
  wire [4:0] R_rs1Val_MPORT_addr; // @[yemu.scala 6:14]
  wire [63:0] R_rs1Val_MPORT_data; // @[yemu.scala 6:14]
  wire  R_rs2Val_MPORT_en; // @[yemu.scala 6:14]
  wire [4:0] R_rs2Val_MPORT_addr; // @[yemu.scala 6:14]
  wire [63:0] R_rs2Val_MPORT_data; // @[yemu.scala 6:14]
  wire [63:0] R_MPORT_data; // @[yemu.scala 6:14]
  wire [4:0] R_MPORT_addr; // @[yemu.scala 6:14]
  wire  R_MPORT_mask; // @[yemu.scala 6:14]
  wire  R_MPORT_en; // @[yemu.scala 6:14]
  reg [31:0] M [0:255]; // @[yemu.scala 8:14]
  wire  M_inst_MPORT_en; // @[yemu.scala 8:14]
  wire [7:0] M_inst_MPORT_addr; // @[yemu.scala 8:14]
  wire [31:0] M_inst_MPORT_data; // @[yemu.scala 8:14]
  reg [63:0] PC; // @[yemu.scala 7:19]
  wire [31:0] _inst_WIRE = M_inst_MPORT_data;
  wire [6:0] inst_opcode = _inst_WIRE[6:0]; // @[yemu.scala 20:35]
  wire [4:0] inst_rd = _inst_WIRE[11:7]; // @[yemu.scala 20:35]
  wire [2:0] inst_funct3 = _inst_WIRE[14:12]; // @[yemu.scala 20:35]
  wire [4:0] inst_rs1 = _inst_WIRE[19:15]; // @[yemu.scala 20:35]
  wire [11:0] inst_imm11_0 = _inst_WIRE[31:20]; // @[yemu.scala 20:35]
  wire  _isAddi_T = inst_opcode == 7'h13; // @[yemu.scala 21:29]
  wire  _isAddi_T_1 = inst_funct3 == 3'h0; // @[yemu.scala 21:63]
  wire  isAddi = inst_opcode == 7'h13 & inst_funct3 == 3'h0; // @[yemu.scala 21:47]
  wire [31:0] _isEbreak_T = {inst_imm11_0,inst_rs1,inst_funct3,inst_rd,inst_opcode}; // @[yemu.scala 22:23]
  wire  isEbreak = _isEbreak_T == 32'h100073; // @[yemu.scala 22:30]
  wire  _T_3 = ~reset; // @[yemu.scala 23:9]
  wire [4:0] _rs1Val_T = isEbreak ? 5'ha : inst_rs1; // @[yemu.scala 25:25]
  wire [63:0] rs1Val = _rs1Val_T == 5'h0 ? 64'h0 : R_rs1Val_MPORT_data; // @[yemu.scala 9:29]
  wire [4:0] _rs2Val_T = isEbreak ? 5'hb : 5'h0; // @[yemu.scala 26:25]
  wire [63:0] rs2Val = _rs2Val_T == 5'h0 ? 64'h0 : R_rs2Val_MPORT_data; // @[yemu.scala 9:29]
  wire [51:0] _T_7 = inst_imm11_0[11] ? 52'hfffffffffffff : 52'h0; // @[Bitwise.scala 77:12]
  wire [63:0] _T_8 = {_T_7,inst_imm11_0}; // @[Cat.scala 33:92]
  wire [63:0] _PC_T_1 = PC + 64'h4; // @[yemu.scala 30:12]
  assign R_rs1Val_MPORT_en = 1'h1;
  assign R_rs1Val_MPORT_addr = isEbreak ? 5'ha : inst_rs1;
  assign R_rs1Val_MPORT_data = R[R_rs1Val_MPORT_addr]; // @[yemu.scala 6:14]
  assign R_rs2Val_MPORT_en = 1'h1;
  assign R_rs2Val_MPORT_addr = isEbreak ? 5'hb : 5'h0;
  assign R_rs2Val_MPORT_data = R[R_rs2Val_MPORT_addr]; // @[yemu.scala 6:14]
  assign R_MPORT_data = rs1Val + _T_8;
  assign R_MPORT_addr = _inst_WIRE[11:7];
  assign R_MPORT_mask = 1'h1;
  assign R_MPORT_en = _isAddi_T & _isAddi_T_1;
  assign M_inst_MPORT_en = 1'h1;
  assign M_inst_MPORT_addr = PC[9:2];
  assign M_inst_MPORT_data = M[M_inst_MPORT_addr]; // @[yemu.scala 8:14]
  assign io_halt = isEbreak & rs1Val == 64'h1; // @[yemu.scala 29:23]
  always @(posedge clock) begin
    if (R_MPORT_en & R_MPORT_mask) begin
      R[R_MPORT_addr] <= R_MPORT_data; // @[yemu.scala 6:14]
    end
    if (reset) begin // @[yemu.scala 7:19]
      PC <= 64'h0; // @[yemu.scala 7:19]
    end else begin
      PC <= _PC_T_1; // @[yemu.scala 30:6]
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~reset & ~(isAddi | isEbreak)) begin
          $fwrite(32'h80000002,
            "Assertion failed: Invalid instruction 0x%x\n    at yemu.scala:23 assert(isAddi || isEbreak, \"Invalid instruction 0x%%x\", inst.asUInt)\n"
            ,_isEbreak_T); // @[yemu.scala 23:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~reset & ~(isAddi | isEbreak)) begin
          $fatal; // @[yemu.scala 23:9]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (isEbreak & rs1Val == 64'h0 & _T_3) begin
          $fwrite(32'h80000002,"%c",rs2Val[7:0]); // @[yemu.scala 28:46]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {2{`RANDOM}};
  for (initvar = 0; initvar < 32; initvar = initvar+1)
    R[initvar] = _RAND_0[63:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 256; initvar = initvar+1)
    M[initvar] = _RAND_1[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {2{`RANDOM}};
  PC = _RAND_2[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
