circuit Top :
  module Alu :
    input clock : Clock
    input reset : Reset
    output io : { Result : UInt<32>, Less : UInt<1>, Zero : UInt<1>, flip PC : UInt<32>, flip rs1 : UInt<32>, flip rs2 : UInt<32>, flip imm : UInt<32>, flip ALUAsrc : UInt<1>, flip ALUBsrc : UInt<2>, flip ALUctr : UInt<4>}

    node Alu_a = mux(io.ALUAsrc, io.PC, io.rs1) @[Alu.scala 29:20]
    node _Alu_b_T = eq(UInt<1>("h0"), io.ALUBsrc) @[Mux.scala 81:61]
    node _Alu_b_T_1 = mux(_Alu_b_T, io.rs2, UInt<1>("h0")) @[Mux.scala 81:58]
    node _Alu_b_T_2 = eq(UInt<1>("h1"), io.ALUBsrc) @[Mux.scala 81:61]
    node _Alu_b_T_3 = mux(_Alu_b_T_2, io.imm, _Alu_b_T_1) @[Mux.scala 81:58]
    node _Alu_b_T_4 = eq(UInt<2>("h2"), io.ALUBsrc) @[Mux.scala 81:61]
    node Alu_b = mux(_Alu_b_T_4, UInt<3>("h4"), _Alu_b_T_3) @[Mux.scala 81:58]
    wire Result_v : UInt<32>
    Result_v <= UInt<32>("h0")
    wire Less_v : UInt<1>
    Less_v <= UInt<1>("h0")
    wire Zero_v : UInt<1>
    Zero_v <= UInt<1>("h0")
    node _T = eq(UInt<1>("h0"), io.ALUctr) @[Alu.scala 43:23]
    when _T : @[Alu.scala 43:23]
      node _Result_v_T = add(Alu_a, Alu_b) @[Alu.scala 45:31]
      Result_v <= _Result_v_T @[Alu.scala 45:22]
    else :
      node _T_1 = eq(UInt<4>("h8"), io.ALUctr) @[Alu.scala 43:23]
      when _T_1 : @[Alu.scala 43:23]
        node _Result_v_T_1 = sub(Alu_a, Alu_b) @[Alu.scala 48:31]
        node _Result_v_T_2 = asUInt(_Result_v_T_1) @[Alu.scala 48:31]
        Result_v <= _Result_v_T_2 @[Alu.scala 48:22]
      else :
        node _T_2 = eq(UInt<2>("h3"), io.ALUctr) @[Alu.scala 43:23]
        when _T_2 : @[Alu.scala 43:23]
          Result_v <= Alu_b @[Alu.scala 51:22]
        else :
          node _T_3 = eq(UInt<3>("h7"), io.ALUctr) @[Alu.scala 43:23]
          when _T_3 : @[Alu.scala 43:23]
            node _Result_v_T_3 = and(Alu_a, Alu_b) @[Alu.scala 54:31]
            Result_v <= _Result_v_T_3 @[Alu.scala 54:22]
          else :
            node _T_4 = eq(UInt<3>("h6"), io.ALUctr) @[Alu.scala 43:23]
            when _T_4 : @[Alu.scala 43:23]
              node _Result_v_T_4 = or(Alu_a, Alu_b) @[Alu.scala 57:31]
              Result_v <= _Result_v_T_4 @[Alu.scala 57:22]
            else :
              node _T_5 = eq(UInt<3>("h4"), io.ALUctr) @[Alu.scala 43:23]
              when _T_5 : @[Alu.scala 43:23]
                node _Result_v_T_5 = xor(Alu_a, Alu_b) @[Alu.scala 60:31]
                Result_v <= _Result_v_T_5 @[Alu.scala 60:22]
              else :
                node _T_6 = eq(UInt<1>("h1"), io.ALUctr) @[Alu.scala 43:23]
                when _T_6 : @[Alu.scala 43:23]
                  node _Result_v_T_6 = bits(Alu_b, 4, 0) @[Alu.scala 63:39]
                  node _Result_v_T_7 = dshl(Alu_a, _Result_v_T_6) @[Alu.scala 63:31]
                  Result_v <= _Result_v_T_7 @[Alu.scala 63:22]
                else :
                  node _T_7 = eq(UInt<3>("h5"), io.ALUctr) @[Alu.scala 43:23]
                  when _T_7 : @[Alu.scala 43:23]
                    node _Result_v_T_8 = bits(Alu_b, 4, 0) @[Alu.scala 66:39]
                    node _Result_v_T_9 = dshr(Alu_a, _Result_v_T_8) @[Alu.scala 66:31]
                    Result_v <= _Result_v_T_9 @[Alu.scala 66:22]
                  else :
                    node _T_8 = eq(UInt<4>("hd"), io.ALUctr) @[Alu.scala 43:23]
                    when _T_8 : @[Alu.scala 43:23]
                      node _Result_v_T_10 = asSInt(Alu_a) @[Alu.scala 69:32]
                      node _Result_v_T_11 = bits(Alu_b, 4, 0) @[Alu.scala 69:47]
                      node _Result_v_T_12 = dshr(_Result_v_T_10, _Result_v_T_11) @[Alu.scala 69:39]
                      node _Result_v_T_13 = asUInt(_Result_v_T_12) @[Alu.scala 69:55]
                      Result_v <= _Result_v_T_13 @[Alu.scala 69:22]
                    else :
                      node _T_9 = eq(UInt<2>("h2"), io.ALUctr) @[Alu.scala 43:23]
                      when _T_9 : @[Alu.scala 43:23]
                        node _diff_s_T = asSInt(Alu_a) @[Alu.scala 72:32]
                        node _diff_s_T_1 = asSInt(Alu_b) @[Alu.scala 72:47]
                        node _diff_s_T_2 = sub(_diff_s_T, _diff_s_T_1) @[Alu.scala 72:39]
                        node _diff_s_T_3 = tail(_diff_s_T_2, 1) @[Alu.scala 72:39]
                        node diff_s = asSInt(_diff_s_T_3) @[Alu.scala 72:39]
                        node _Result_v_T_14 = lt(diff_s, asSInt(UInt<1>("h0"))) @[Alu.scala 73:36]
                        node _Result_v_T_15 = mux(_Result_v_T_14, UInt<1>("h1"), UInt<1>("h0")) @[Alu.scala 73:28]
                        Result_v <= _Result_v_T_15 @[Alu.scala 73:22]
                        node _Less_v_T = lt(diff_s, asSInt(UInt<1>("h0"))) @[Alu.scala 74:34]
                        node _Less_v_T_1 = mux(_Less_v_T, UInt<1>("h1"), UInt<1>("h0")) @[Alu.scala 74:26]
                        Less_v <= _Less_v_T_1 @[Alu.scala 74:20]
                      else :
                        node _T_10 = eq(UInt<4>("ha"), io.ALUctr) @[Alu.scala 43:23]
                        when _T_10 : @[Alu.scala 43:23]
                          node _diff_u_T = sub(Alu_a, Alu_b) @[Alu.scala 77:39]
                          node diff_u = tail(_diff_u_T, 1) @[Alu.scala 77:39]
                          node _Result_v_T_16 = lt(diff_u, UInt<1>("h0")) @[Alu.scala 78:36]
                          node _Result_v_T_17 = mux(_Result_v_T_16, UInt<1>("h1"), UInt<1>("h0")) @[Alu.scala 78:28]
                          Result_v <= _Result_v_T_17 @[Alu.scala 78:22]
                          node _Less_v_T_2 = lt(diff_u, UInt<1>("h0")) @[Alu.scala 79:34]
                          node _Less_v_T_3 = mux(_Less_v_T_2, UInt<1>("h1"), UInt<1>("h0")) @[Alu.scala 79:26]
                          Less_v <= _Less_v_T_3 @[Alu.scala 79:20]
    node _Zero_v_T = eq(Result_v, UInt<1>("h0")) @[Alu.scala 82:28]
    node _Zero_v_T_1 = mux(_Zero_v_T, UInt<1>("h1"), UInt<1>("h0")) @[Alu.scala 82:18]
    Zero_v <= _Zero_v_T_1 @[Alu.scala 82:12]
    io.Result <= Result_v @[Alu.scala 84:15]
    io.Less <= Less_v @[Alu.scala 85:13]
    io.Zero <= Zero_v @[Alu.scala 86:13]

  module RegFile :
    input clock : Clock
    input reset : Reset
    output io : { busA : UInt<32>, busB : UInt<32>, flip Ra : UInt<5>, flip Rb : UInt<5>, flip Rw : UInt<5>, flip busW : UInt<32>, flip RegWr : UInt<1>, flip RegFileclk : Clock}

    reg regs : UInt<32>[32], clock with :
      reset => (UInt<1>("h0"), regs) @[RegFile.scala 25:19]
    node _T = asUInt(io.RegFileclk) @[RegFile.scala 26:31]
    node _T_1 = bits(_T, 0, 0) @[RegFile.scala 26:38]
    node _T_2 = not(_T_1) @[RegFile.scala 26:16]
    node _T_3 = asClock(_T_2) @[RegFile.scala 26:46]
    node _T_4 = eq(io.Ra, UInt<1>("h0")) @[RegFile.scala 28:20]
    when _T_4 : @[RegFile.scala 28:29]
      io.busA <= UInt<1>("h0") @[RegFile.scala 29:21]
    node _T_5 = eq(io.Rb, UInt<1>("h0")) @[RegFile.scala 31:20]
    when _T_5 : @[RegFile.scala 31:29]
      io.busB <= UInt<1>("h0") @[RegFile.scala 32:21]
    io.busA <= regs[io.Ra] @[RegFile.scala 35:17]
    io.busB <= regs[io.Rb] @[RegFile.scala 36:17]
    node _T_6 = neq(io.Rw, UInt<1>("h0")) @[RegFile.scala 38:32]
    node _T_7 = and(io.RegWr, _T_6) @[RegFile.scala 38:23]
    when _T_7 : @[RegFile.scala 38:41]
      regs[io.Rw] <= io.busW @[RegFile.scala 39:25]

  module BranchCond :
    input clock : Clock
    input reset : Reset
    output io : { PCAsrc : UInt<1>, PCBsrc : UInt<1>, flip Branch : UInt<3>, flip Less : UInt<1>, flip Zero : UInt<1>}

    node PCAsrc_v_hi = cat(io.Branch, io.Less) @[Cat.scala 31:58]
    node _PCAsrc_v_T = cat(PCAsrc_v_hi, io.Zero) @[Cat.scala 31:58]
    node _PCAsrc_v_T_1 = eq(UInt<1>("h0"), _PCAsrc_v_T) @[Mux.scala 81:61]
    node _PCAsrc_v_T_2 = mux(_PCAsrc_v_T_1, UInt<1>("h0"), UInt<1>("h0")) @[Mux.scala 81:58]
    node _PCAsrc_v_T_3 = eq(UInt<1>("h1"), _PCAsrc_v_T) @[Mux.scala 81:61]
    node _PCAsrc_v_T_4 = mux(_PCAsrc_v_T_3, UInt<1>("h0"), _PCAsrc_v_T_2) @[Mux.scala 81:58]
    node _PCAsrc_v_T_5 = eq(UInt<4>("ha"), _PCAsrc_v_T) @[Mux.scala 81:61]
    node _PCAsrc_v_T_6 = mux(_PCAsrc_v_T_5, UInt<1>("h0"), _PCAsrc_v_T_4) @[Mux.scala 81:58]
    node _PCAsrc_v_T_7 = eq(UInt<4>("hb"), _PCAsrc_v_T) @[Mux.scala 81:61]
    node _PCAsrc_v_T_8 = mux(_PCAsrc_v_T_7, UInt<1>("h0"), _PCAsrc_v_T_6) @[Mux.scala 81:58]
    node _PCAsrc_v_T_9 = eq(UInt<7>("h64"), _PCAsrc_v_T) @[Mux.scala 81:61]
    node _PCAsrc_v_T_10 = mux(_PCAsrc_v_T_9, UInt<1>("h1"), _PCAsrc_v_T_8) @[Mux.scala 81:58]
    node _PCAsrc_v_T_11 = eq(UInt<7>("h65"), _PCAsrc_v_T) @[Mux.scala 81:61]
    node _PCAsrc_v_T_12 = mux(_PCAsrc_v_T_11, UInt<1>("h1"), _PCAsrc_v_T_10) @[Mux.scala 81:58]
    node _PCAsrc_v_T_13 = eq(UInt<7>("h6e"), _PCAsrc_v_T) @[Mux.scala 81:61]
    node _PCAsrc_v_T_14 = mux(_PCAsrc_v_T_13, UInt<1>("h1"), _PCAsrc_v_T_12) @[Mux.scala 81:58]
    node _PCAsrc_v_T_15 = eq(UInt<7>("h6f"), _PCAsrc_v_T) @[Mux.scala 81:61]
    node _PCAsrc_v_T_16 = mux(_PCAsrc_v_T_15, UInt<1>("h1"), _PCAsrc_v_T_14) @[Mux.scala 81:58]
    node _PCAsrc_v_T_17 = eq(UInt<10>("h3e8"), _PCAsrc_v_T) @[Mux.scala 81:61]
    node _PCAsrc_v_T_18 = mux(_PCAsrc_v_T_17, UInt<1>("h1"), _PCAsrc_v_T_16) @[Mux.scala 81:58]
    node _PCAsrc_v_T_19 = eq(UInt<10>("h3e9"), _PCAsrc_v_T) @[Mux.scala 81:61]
    node _PCAsrc_v_T_20 = mux(_PCAsrc_v_T_19, UInt<1>("h1"), _PCAsrc_v_T_18) @[Mux.scala 81:58]
    node _PCAsrc_v_T_21 = eq(UInt<10>("h3f2"), _PCAsrc_v_T) @[Mux.scala 81:61]
    node _PCAsrc_v_T_22 = mux(_PCAsrc_v_T_21, UInt<1>("h1"), _PCAsrc_v_T_20) @[Mux.scala 81:58]
    node _PCAsrc_v_T_23 = eq(UInt<10>("h3f3"), _PCAsrc_v_T) @[Mux.scala 81:61]
    node _PCAsrc_v_T_24 = mux(_PCAsrc_v_T_23, UInt<1>("h1"), _PCAsrc_v_T_22) @[Mux.scala 81:58]
    node _PCAsrc_v_T_25 = eq(UInt<14>("h2710"), _PCAsrc_v_T) @[Mux.scala 81:61]
    node _PCAsrc_v_T_26 = mux(_PCAsrc_v_T_25, UInt<1>("h0"), _PCAsrc_v_T_24) @[Mux.scala 81:58]
    node _PCAsrc_v_T_27 = eq(UInt<14>("h2711"), _PCAsrc_v_T) @[Mux.scala 81:61]
    node _PCAsrc_v_T_28 = mux(_PCAsrc_v_T_27, UInt<1>("h0"), _PCAsrc_v_T_26) @[Mux.scala 81:58]
    node _PCAsrc_v_T_29 = eq(UInt<14>("h271a"), _PCAsrc_v_T) @[Mux.scala 81:61]
    node _PCAsrc_v_T_30 = mux(_PCAsrc_v_T_29, UInt<1>("h1"), _PCAsrc_v_T_28) @[Mux.scala 81:58]
    node _PCAsrc_v_T_31 = eq(UInt<14>("h271b"), _PCAsrc_v_T) @[Mux.scala 81:61]
    node _PCAsrc_v_T_32 = mux(_PCAsrc_v_T_31, UInt<1>("h1"), _PCAsrc_v_T_30) @[Mux.scala 81:58]
    node _PCAsrc_v_T_33 = eq(UInt<14>("h2774"), _PCAsrc_v_T) @[Mux.scala 81:61]
    node _PCAsrc_v_T_34 = mux(_PCAsrc_v_T_33, UInt<1>("h1"), _PCAsrc_v_T_32) @[Mux.scala 81:58]
    node _PCAsrc_v_T_35 = eq(UInt<14>("h2775"), _PCAsrc_v_T) @[Mux.scala 81:61]
    node _PCAsrc_v_T_36 = mux(_PCAsrc_v_T_35, UInt<1>("h1"), _PCAsrc_v_T_34) @[Mux.scala 81:58]
    node _PCAsrc_v_T_37 = eq(UInt<14>("h277e"), _PCAsrc_v_T) @[Mux.scala 81:61]
    node _PCAsrc_v_T_38 = mux(_PCAsrc_v_T_37, UInt<1>("h0"), _PCAsrc_v_T_36) @[Mux.scala 81:58]
    node _PCAsrc_v_T_39 = eq(UInt<14>("h277f"), _PCAsrc_v_T) @[Mux.scala 81:61]
    node _PCAsrc_v_T_40 = mux(_PCAsrc_v_T_39, UInt<1>("h0"), _PCAsrc_v_T_38) @[Mux.scala 81:58]
    node _PCAsrc_v_T_41 = eq(UInt<14>("h2af8"), _PCAsrc_v_T) @[Mux.scala 81:61]
    node _PCAsrc_v_T_42 = mux(_PCAsrc_v_T_41, UInt<1>("h0"), _PCAsrc_v_T_40) @[Mux.scala 81:58]
    node _PCAsrc_v_T_43 = eq(UInt<14>("h2b02"), _PCAsrc_v_T) @[Mux.scala 81:61]
    node _PCAsrc_v_T_44 = mux(_PCAsrc_v_T_43, UInt<1>("h0"), _PCAsrc_v_T_42) @[Mux.scala 81:58]
    node _PCAsrc_v_T_45 = eq(UInt<14>("h2af9"), _PCAsrc_v_T) @[Mux.scala 81:61]
    node _PCAsrc_v_T_46 = mux(_PCAsrc_v_T_45, UInt<1>("h1"), _PCAsrc_v_T_44) @[Mux.scala 81:58]
    node _PCAsrc_v_T_47 = eq(UInt<14>("h2b03"), _PCAsrc_v_T) @[Mux.scala 81:61]
    node _PCAsrc_v_T_48 = mux(_PCAsrc_v_T_47, UInt<1>("h1"), _PCAsrc_v_T_46) @[Mux.scala 81:58]
    node _PCAsrc_v_T_49 = eq(UInt<14>("h2b5c"), _PCAsrc_v_T) @[Mux.scala 81:61]
    node _PCAsrc_v_T_50 = mux(_PCAsrc_v_T_49, UInt<1>("h1"), _PCAsrc_v_T_48) @[Mux.scala 81:58]
    node _PCAsrc_v_T_51 = eq(UInt<14>("h2b66"), _PCAsrc_v_T) @[Mux.scala 81:61]
    node _PCAsrc_v_T_52 = mux(_PCAsrc_v_T_51, UInt<1>("h1"), _PCAsrc_v_T_50) @[Mux.scala 81:58]
    node _PCAsrc_v_T_53 = eq(UInt<14>("h2b5d"), _PCAsrc_v_T) @[Mux.scala 81:61]
    node _PCAsrc_v_T_54 = mux(_PCAsrc_v_T_53, UInt<1>("h0"), _PCAsrc_v_T_52) @[Mux.scala 81:58]
    node _PCAsrc_v_T_55 = eq(UInt<14>("h2b67"), _PCAsrc_v_T) @[Mux.scala 81:61]
    node PCAsrc_v = mux(_PCAsrc_v_T_55, UInt<1>("h0"), _PCAsrc_v_T_54) @[Mux.scala 81:58]
    node PCBsrc_v_hi = cat(io.Branch, io.Less) @[Cat.scala 31:58]
    node _PCBsrc_v_T = cat(PCBsrc_v_hi, io.Zero) @[Cat.scala 31:58]
    node _PCBsrc_v_T_1 = eq(UInt<1>("h0"), _PCBsrc_v_T) @[Mux.scala 81:61]
    node _PCBsrc_v_T_2 = mux(_PCBsrc_v_T_1, UInt<1>("h0"), UInt<1>("h0")) @[Mux.scala 81:58]
    node _PCBsrc_v_T_3 = eq(UInt<1>("h1"), _PCBsrc_v_T) @[Mux.scala 81:61]
    node _PCBsrc_v_T_4 = mux(_PCBsrc_v_T_3, UInt<1>("h0"), _PCBsrc_v_T_2) @[Mux.scala 81:58]
    node _PCBsrc_v_T_5 = eq(UInt<4>("ha"), _PCBsrc_v_T) @[Mux.scala 81:61]
    node _PCBsrc_v_T_6 = mux(_PCBsrc_v_T_5, UInt<1>("h0"), _PCBsrc_v_T_4) @[Mux.scala 81:58]
    node _PCBsrc_v_T_7 = eq(UInt<4>("hb"), _PCBsrc_v_T) @[Mux.scala 81:61]
    node _PCBsrc_v_T_8 = mux(_PCBsrc_v_T_7, UInt<1>("h0"), _PCBsrc_v_T_6) @[Mux.scala 81:58]
    node _PCBsrc_v_T_9 = eq(UInt<7>("h64"), _PCBsrc_v_T) @[Mux.scala 81:61]
    node _PCBsrc_v_T_10 = mux(_PCBsrc_v_T_9, UInt<1>("h0"), _PCBsrc_v_T_8) @[Mux.scala 81:58]
    node _PCBsrc_v_T_11 = eq(UInt<7>("h65"), _PCBsrc_v_T) @[Mux.scala 81:61]
    node _PCBsrc_v_T_12 = mux(_PCBsrc_v_T_11, UInt<1>("h0"), _PCBsrc_v_T_10) @[Mux.scala 81:58]
    node _PCBsrc_v_T_13 = eq(UInt<7>("h6e"), _PCBsrc_v_T) @[Mux.scala 81:61]
    node _PCBsrc_v_T_14 = mux(_PCBsrc_v_T_13, UInt<1>("h0"), _PCBsrc_v_T_12) @[Mux.scala 81:58]
    node _PCBsrc_v_T_15 = eq(UInt<7>("h6f"), _PCBsrc_v_T) @[Mux.scala 81:61]
    node _PCBsrc_v_T_16 = mux(_PCBsrc_v_T_15, UInt<1>("h0"), _PCBsrc_v_T_14) @[Mux.scala 81:58]
    node _PCBsrc_v_T_17 = eq(UInt<10>("h3e8"), _PCBsrc_v_T) @[Mux.scala 81:61]
    node _PCBsrc_v_T_18 = mux(_PCBsrc_v_T_17, UInt<1>("h1"), _PCBsrc_v_T_16) @[Mux.scala 81:58]
    node _PCBsrc_v_T_19 = eq(UInt<10>("h3e9"), _PCBsrc_v_T) @[Mux.scala 81:61]
    node _PCBsrc_v_T_20 = mux(_PCBsrc_v_T_19, UInt<1>("h1"), _PCBsrc_v_T_18) @[Mux.scala 81:58]
    node _PCBsrc_v_T_21 = eq(UInt<10>("h3f2"), _PCBsrc_v_T) @[Mux.scala 81:61]
    node _PCBsrc_v_T_22 = mux(_PCBsrc_v_T_21, UInt<1>("h1"), _PCBsrc_v_T_20) @[Mux.scala 81:58]
    node _PCBsrc_v_T_23 = eq(UInt<10>("h3f3"), _PCBsrc_v_T) @[Mux.scala 81:61]
    node _PCBsrc_v_T_24 = mux(_PCBsrc_v_T_23, UInt<1>("h1"), _PCBsrc_v_T_22) @[Mux.scala 81:58]
    node _PCBsrc_v_T_25 = eq(UInt<14>("h2710"), _PCBsrc_v_T) @[Mux.scala 81:61]
    node _PCBsrc_v_T_26 = mux(_PCBsrc_v_T_25, UInt<1>("h0"), _PCBsrc_v_T_24) @[Mux.scala 81:58]
    node _PCBsrc_v_T_27 = eq(UInt<14>("h2711"), _PCBsrc_v_T) @[Mux.scala 81:61]
    node _PCBsrc_v_T_28 = mux(_PCBsrc_v_T_27, UInt<1>("h0"), _PCBsrc_v_T_26) @[Mux.scala 81:58]
    node _PCBsrc_v_T_29 = eq(UInt<14>("h271a"), _PCBsrc_v_T) @[Mux.scala 81:61]
    node _PCBsrc_v_T_30 = mux(_PCBsrc_v_T_29, UInt<1>("h0"), _PCBsrc_v_T_28) @[Mux.scala 81:58]
    node _PCBsrc_v_T_31 = eq(UInt<14>("h271b"), _PCBsrc_v_T) @[Mux.scala 81:61]
    node _PCBsrc_v_T_32 = mux(_PCBsrc_v_T_31, UInt<1>("h0"), _PCBsrc_v_T_30) @[Mux.scala 81:58]
    node _PCBsrc_v_T_33 = eq(UInt<14>("h2774"), _PCBsrc_v_T) @[Mux.scala 81:61]
    node _PCBsrc_v_T_34 = mux(_PCBsrc_v_T_33, UInt<1>("h0"), _PCBsrc_v_T_32) @[Mux.scala 81:58]
    node _PCBsrc_v_T_35 = eq(UInt<14>("h2775"), _PCBsrc_v_T) @[Mux.scala 81:61]
    node _PCBsrc_v_T_36 = mux(_PCBsrc_v_T_35, UInt<1>("h0"), _PCBsrc_v_T_34) @[Mux.scala 81:58]
    node _PCBsrc_v_T_37 = eq(UInt<14>("h277e"), _PCBsrc_v_T) @[Mux.scala 81:61]
    node _PCBsrc_v_T_38 = mux(_PCBsrc_v_T_37, UInt<1>("h0"), _PCBsrc_v_T_36) @[Mux.scala 81:58]
    node _PCBsrc_v_T_39 = eq(UInt<14>("h277f"), _PCBsrc_v_T) @[Mux.scala 81:61]
    node _PCBsrc_v_T_40 = mux(_PCBsrc_v_T_39, UInt<1>("h0"), _PCBsrc_v_T_38) @[Mux.scala 81:58]
    node _PCBsrc_v_T_41 = eq(UInt<14>("h2af8"), _PCBsrc_v_T) @[Mux.scala 81:61]
    node _PCBsrc_v_T_42 = mux(_PCBsrc_v_T_41, UInt<1>("h0"), _PCBsrc_v_T_40) @[Mux.scala 81:58]
    node _PCBsrc_v_T_43 = eq(UInt<14>("h2b02"), _PCBsrc_v_T) @[Mux.scala 81:61]
    node _PCBsrc_v_T_44 = mux(_PCBsrc_v_T_43, UInt<1>("h0"), _PCBsrc_v_T_42) @[Mux.scala 81:58]
    node _PCBsrc_v_T_45 = eq(UInt<14>("h2af9"), _PCBsrc_v_T) @[Mux.scala 81:61]
    node _PCBsrc_v_T_46 = mux(_PCBsrc_v_T_45, UInt<1>("h0"), _PCBsrc_v_T_44) @[Mux.scala 81:58]
    node _PCBsrc_v_T_47 = eq(UInt<14>("h2b03"), _PCBsrc_v_T) @[Mux.scala 81:61]
    node _PCBsrc_v_T_48 = mux(_PCBsrc_v_T_47, UInt<1>("h0"), _PCBsrc_v_T_46) @[Mux.scala 81:58]
    node _PCBsrc_v_T_49 = eq(UInt<14>("h2b5c"), _PCBsrc_v_T) @[Mux.scala 81:61]
    node _PCBsrc_v_T_50 = mux(_PCBsrc_v_T_49, UInt<1>("h0"), _PCBsrc_v_T_48) @[Mux.scala 81:58]
    node _PCBsrc_v_T_51 = eq(UInt<14>("h2b66"), _PCBsrc_v_T) @[Mux.scala 81:61]
    node _PCBsrc_v_T_52 = mux(_PCBsrc_v_T_51, UInt<1>("h0"), _PCBsrc_v_T_50) @[Mux.scala 81:58]
    node _PCBsrc_v_T_53 = eq(UInt<14>("h2b5d"), _PCBsrc_v_T) @[Mux.scala 81:61]
    node _PCBsrc_v_T_54 = mux(_PCBsrc_v_T_53, UInt<1>("h0"), _PCBsrc_v_T_52) @[Mux.scala 81:58]
    node _PCBsrc_v_T_55 = eq(UInt<14>("h2b67"), _PCBsrc_v_T) @[Mux.scala 81:61]
    node PCBsrc_v = mux(_PCBsrc_v_T_55, UInt<1>("h0"), _PCBsrc_v_T_54) @[Mux.scala 81:58]
    io.PCAsrc <= PCAsrc_v @[BranchCond.scala 92:15]
    io.PCBsrc <= PCBsrc_v @[BranchCond.scala 93:15]

  module ContrGEN :
    input clock : Clock
    input reset : Reset
    output io : { ExtOP : UInt<3>, RegWr : UInt<1>, ALUAsrc : UInt<1>, ALUBsrc : UInt<2>, ALUctr : UInt<4>, Branch : UInt<3>, MemtoReg : UInt<1>, MemWr : UInt<1>, MemOP : UInt<3>, flip op : UInt<7>, flip func3 : UInt<3>, flip func7 : UInt<7>}

    wire ExtOP_v : UInt<3>
    ExtOP_v <= UInt<3>("h0")
    wire RegWr_v : UInt<1>
    RegWr_v <= UInt<1>("h0")
    wire ALUAsrc_v : UInt<1>
    ALUAsrc_v <= UInt<1>("h0")
    wire ALUBsrc_v : UInt<2>
    ALUBsrc_v <= UInt<2>("h0")
    wire ALUctr_v : UInt<4>
    ALUctr_v <= UInt<4>("h0")
    wire Branch_v : UInt<3>
    Branch_v <= UInt<3>("h0")
    wire MemtoReg_v : UInt<1>
    MemtoReg_v <= UInt<1>("h0")
    wire MemWr_v : UInt<1>
    MemWr_v <= UInt<1>("h0")
    wire MemOP_v : UInt<3>
    MemOP_v <= UInt<3>("h0")
    node _T = bits(io.op, 6, 2) @[ContrGEN.scala 47:17]
    node _T_1 = eq(UInt<4>("hd"), _T) @[ContrGEN.scala 47:25]
    when _T_1 : @[ContrGEN.scala 47:25]
      ExtOP_v <= UInt<1>("h1") @[ContrGEN.scala 50:21]
      RegWr_v <= UInt<1>("h1") @[ContrGEN.scala 51:21]
      ALUBsrc_v <= UInt<1>("h1") @[ContrGEN.scala 52:23]
      ALUctr_v <= UInt<2>("h3") @[ContrGEN.scala 53:22]
      MemtoReg_v <= UInt<1>("h0") @[ContrGEN.scala 54:24]
    else :
      node _T_2 = eq(UInt<3>("h5"), _T) @[ContrGEN.scala 47:25]
      when _T_2 : @[ContrGEN.scala 47:25]
        ExtOP_v <= UInt<1>("h1") @[ContrGEN.scala 58:21]
        RegWr_v <= UInt<1>("h1") @[ContrGEN.scala 59:21]
        ALUAsrc_v <= UInt<1>("h1") @[ContrGEN.scala 60:23]
        ALUBsrc_v <= UInt<1>("h1") @[ContrGEN.scala 61:23]
        ALUctr_v <= UInt<1>("h0") @[ContrGEN.scala 62:22]
        MemtoReg_v <= UInt<1>("h0") @[ContrGEN.scala 63:24]
      else :
        node _T_3 = eq(UInt<5>("h1b"), _T) @[ContrGEN.scala 47:25]
        when _T_3 : @[ContrGEN.scala 47:25]
          ExtOP_v <= UInt<3>("h4") @[ContrGEN.scala 67:21]
          RegWr_v <= UInt<1>("h1") @[ContrGEN.scala 68:21]
          ALUAsrc_v <= UInt<1>("h1") @[ContrGEN.scala 69:23]
          ALUBsrc_v <= UInt<1>("h1") @[ContrGEN.scala 70:23]
          ALUctr_v <= UInt<1>("h0") @[ContrGEN.scala 71:22]
          Branch_v <= UInt<1>("h1") @[ContrGEN.scala 72:22]
          MemtoReg_v <= UInt<1>("h0") @[ContrGEN.scala 73:24]
        else :
          node _T_4 = eq(UInt<5>("h19"), _T) @[ContrGEN.scala 47:25]
          node _T_5 = eq(UInt<1>("h0"), _T) @[ContrGEN.scala 47:25]
          node _T_6 = eq(UInt<3>("h4"), _T) @[ContrGEN.scala 47:25]
          node _T_7 = or(_T_4, _T_5) @[ContrGEN.scala 47:25]
          node _T_8 = or(_T_7, _T_6) @[ContrGEN.scala 47:25]
          when _T_8 : @[ContrGEN.scala 47:25]
            ExtOP_v <= UInt<1>("h0") @[ContrGEN.scala 79:21]
            node _T_9 = bits(io.op, 6, 2) @[ContrGEN.scala 81:23]
            node _T_10 = eq(_T_9, UInt<5>("h19")) @[ContrGEN.scala 81:30]
            when _T_10 : @[ContrGEN.scala 81:46]
              RegWr_v <= UInt<1>("h1") @[ContrGEN.scala 82:25]
              ALUAsrc_v <= UInt<1>("h1") @[ContrGEN.scala 83:27]
              ALUBsrc_v <= UInt<2>("h2") @[ContrGEN.scala 84:27]
              ALUctr_v <= UInt<1>("h0") @[ContrGEN.scala 85:26]
              Branch_v <= UInt<2>("h2") @[ContrGEN.scala 86:26]
              MemtoReg_v <= UInt<1>("h0") @[ContrGEN.scala 87:28]
            else :
              node _T_11 = bits(io.op, 6, 2) @[ContrGEN.scala 90:32]
              node _T_12 = eq(_T_11, UInt<1>("h0")) @[ContrGEN.scala 90:39]
              when _T_12 : @[ContrGEN.scala 90:55]
                RegWr_v <= UInt<1>("h1") @[ContrGEN.scala 91:29]
                ALUAsrc_v <= UInt<1>("h0") @[ContrGEN.scala 92:31]
                ALUBsrc_v <= UInt<1>("h1") @[ContrGEN.scala 93:31]
                ALUctr_v <= UInt<1>("h0") @[ContrGEN.scala 94:30]
                Branch_v <= UInt<1>("h0") @[ContrGEN.scala 95:30]
                MemtoReg_v <= UInt<1>("h1") @[ContrGEN.scala 96:32]
                MemWr_v <= UInt<1>("h0") @[ContrGEN.scala 97:29]
                node _T_13 = eq(io.func3, UInt<1>("h0")) @[ContrGEN.scala 98:35]
                when _T_13 : @[ContrGEN.scala 98:49]
                  MemOP_v <= UInt<1>("h0") @[ContrGEN.scala 99:33]
                node _T_14 = eq(io.func3, UInt<1>("h1")) @[ContrGEN.scala 101:35]
                when _T_14 : @[ContrGEN.scala 101:49]
                  MemOP_v <= UInt<1>("h1") @[ContrGEN.scala 102:33]
                node _T_15 = eq(io.func3, UInt<2>("h2")) @[ContrGEN.scala 104:35]
                when _T_15 : @[ContrGEN.scala 104:49]
                  MemOP_v <= UInt<2>("h2") @[ContrGEN.scala 105:33]
                node _T_16 = eq(io.func3, UInt<3>("h4")) @[ContrGEN.scala 107:35]
                when _T_16 : @[ContrGEN.scala 107:49]
                  MemOP_v <= UInt<3>("h4") @[ContrGEN.scala 108:33]
                node _T_17 = eq(io.func3, UInt<3>("h5")) @[ContrGEN.scala 110:35]
                when _T_17 : @[ContrGEN.scala 110:49]
                  MemOP_v <= UInt<3>("h5") @[ContrGEN.scala 111:33]
              else :
                node _T_18 = bits(io.op, 6, 2) @[ContrGEN.scala 116:26]
                node _T_19 = eq(_T_18, UInt<3>("h4")) @[ContrGEN.scala 119:23]
                node _T_20 = eq(io.func3, UInt<1>("h1")) @[ContrGEN.scala 119:51]
                node _T_21 = eq(io.func3, UInt<3>("h5")) @[ContrGEN.scala 119:76]
                node _T_22 = or(_T_20, _T_21) @[ContrGEN.scala 119:64]
                node _T_23 = and(_T_19, _T_22) @[ContrGEN.scala 119:38]
                when _T_23 : @[ContrGEN.scala 120:19]
                  RegWr_v <= UInt<1>("h1") @[ContrGEN.scala 121:29]
                  ALUAsrc_v <= UInt<1>("h0") @[ContrGEN.scala 122:31]
                  ALUBsrc_v <= UInt<1>("h0") @[ContrGEN.scala 123:31]
                  Branch_v <= UInt<1>("h0") @[ContrGEN.scala 124:30]
                  MemtoReg_v <= UInt<1>("h0") @[ContrGEN.scala 125:32]
                  node _T_24 = bits(io.func7, 6, 6) @[ContrGEN.scala 126:40]
                  node _T_25 = cat(_T_24, io.func3) @[Cat.scala 31:58]
                  node _T_26 = eq(UInt<1>("h1"), _T_25) @[ContrGEN.scala 126:56]
                  when _T_26 : @[ContrGEN.scala 126:56]
                    ALUctr_v <= UInt<1>("h1") @[ContrGEN.scala 129:38]
                  else :
                    node _T_27 = eq(UInt<3>("h5"), _T_25) @[ContrGEN.scala 126:56]
                    when _T_27 : @[ContrGEN.scala 126:56]
                      ALUctr_v <= UInt<3>("h5") @[ContrGEN.scala 133:38]
                    else :
                      node _T_28 = eq(UInt<4>("hd"), _T_25) @[ContrGEN.scala 126:56]
                      when _T_28 : @[ContrGEN.scala 126:56]
                        ALUctr_v <= UInt<4>("hd") @[ContrGEN.scala 137:38]
                else :
                  RegWr_v <= UInt<1>("h1") @[ContrGEN.scala 142:29]
                  ALUAsrc_v <= UInt<1>("h0") @[ContrGEN.scala 143:31]
                  ALUBsrc_v <= UInt<1>("h1") @[ContrGEN.scala 144:31]
                  Branch_v <= UInt<1>("h0") @[ContrGEN.scala 145:30]
                  MemtoReg_v <= UInt<1>("h0") @[ContrGEN.scala 146:32]
                  node _T_29 = eq(UInt<1>("h0"), io.func3) @[ContrGEN.scala 147:38]
                  when _T_29 : @[ContrGEN.scala 147:38]
                    ALUctr_v <= UInt<1>("h0") @[ContrGEN.scala 150:38]
                  else :
                    node _T_30 = eq(UInt<2>("h2"), io.func3) @[ContrGEN.scala 147:38]
                    when _T_30 : @[ContrGEN.scala 147:38]
                      ALUctr_v <= UInt<2>("h2") @[ContrGEN.scala 154:38]
                    else :
                      node _T_31 = eq(UInt<2>("h3"), io.func3) @[ContrGEN.scala 147:38]
                      when _T_31 : @[ContrGEN.scala 147:38]
                        ALUctr_v <= UInt<4>("ha") @[ContrGEN.scala 158:38]
                      else :
                        node _T_32 = eq(UInt<3>("h4"), io.func3) @[ContrGEN.scala 147:38]
                        when _T_32 : @[ContrGEN.scala 147:38]
                          ALUctr_v <= UInt<3>("h4") @[ContrGEN.scala 162:38]
                        else :
                          node _T_33 = eq(UInt<3>("h6"), io.func3) @[ContrGEN.scala 147:38]
                          when _T_33 : @[ContrGEN.scala 147:38]
                            ALUctr_v <= UInt<3>("h6") @[ContrGEN.scala 166:38]
                          else :
                            node _T_34 = eq(UInt<3>("h7"), io.func3) @[ContrGEN.scala 147:38]
                            when _T_34 : @[ContrGEN.scala 147:38]
                              ALUctr_v <= UInt<3>("h7") @[ContrGEN.scala 170:38]
          else :
            node _T_35 = eq(UInt<5>("h18"), _T) @[ContrGEN.scala 47:25]
            when _T_35 : @[ContrGEN.scala 47:25]
              ExtOP_v <= UInt<2>("h3") @[ContrGEN.scala 177:21]
              RegWr_v <= UInt<1>("h0") @[ContrGEN.scala 178:21]
              ALUAsrc_v <= UInt<1>("h0") @[ContrGEN.scala 179:23]
              ALUBsrc_v <= UInt<1>("h0") @[ContrGEN.scala 180:23]
              MemtoReg_v <= UInt<1>("h0") @[ContrGEN.scala 181:24]
              node _T_36 = eq(UInt<1>("h0"), io.func3) @[ContrGEN.scala 182:30]
              when _T_36 : @[ContrGEN.scala 182:30]
                ALUctr_v <= UInt<2>("h2") @[ContrGEN.scala 185:30]
                Branch_v <= UInt<3>("h4") @[ContrGEN.scala 186:30]
              else :
                node _T_37 = eq(UInt<1>("h1"), io.func3) @[ContrGEN.scala 182:30]
                when _T_37 : @[ContrGEN.scala 182:30]
                  ALUctr_v <= UInt<2>("h2") @[ContrGEN.scala 190:30]
                  Branch_v <= UInt<3>("h5") @[ContrGEN.scala 191:30]
                else :
                  node _T_38 = eq(UInt<3>("h4"), io.func3) @[ContrGEN.scala 182:30]
                  when _T_38 : @[ContrGEN.scala 182:30]
                    ALUctr_v <= UInt<2>("h2") @[ContrGEN.scala 195:30]
                    Branch_v <= UInt<3>("h6") @[ContrGEN.scala 196:30]
                  else :
                    node _T_39 = eq(UInt<3>("h5"), io.func3) @[ContrGEN.scala 182:30]
                    when _T_39 : @[ContrGEN.scala 182:30]
                      ALUctr_v <= UInt<2>("h2") @[ContrGEN.scala 200:30]
                      Branch_v <= UInt<3>("h7") @[ContrGEN.scala 201:30]
                    else :
                      node _T_40 = eq(UInt<3>("h6"), io.func3) @[ContrGEN.scala 182:30]
                      when _T_40 : @[ContrGEN.scala 182:30]
                        ALUctr_v <= UInt<4>("ha") @[ContrGEN.scala 205:30]
                        Branch_v <= UInt<3>("h6") @[ContrGEN.scala 206:30]
                      else :
                        node _T_41 = eq(UInt<3>("h7"), io.func3) @[ContrGEN.scala 182:30]
                        when _T_41 : @[ContrGEN.scala 182:30]
                          ALUctr_v <= UInt<4>("ha") @[ContrGEN.scala 210:30]
                          Branch_v <= UInt<3>("h7") @[ContrGEN.scala 211:30]
            else :
              node _T_42 = eq(UInt<4>("h8"), _T) @[ContrGEN.scala 47:25]
              when _T_42 : @[ContrGEN.scala 47:25]
                ExtOP_v <= UInt<2>("h2") @[ContrGEN.scala 217:21]
                RegWr_v <= UInt<1>("h0") @[ContrGEN.scala 218:21]
                ALUAsrc_v <= UInt<1>("h0") @[ContrGEN.scala 219:23]
                ALUBsrc_v <= UInt<1>("h1") @[ContrGEN.scala 220:23]
                ALUctr_v <= UInt<1>("h0") @[ContrGEN.scala 221:22]
                Branch_v <= UInt<1>("h0") @[ContrGEN.scala 222:22]
                MemWr_v <= UInt<1>("h1") @[ContrGEN.scala 223:21]
                node _T_43 = eq(io.func3, UInt<1>("h0")) @[ContrGEN.scala 225:27]
                when _T_43 : @[ContrGEN.scala 225:41]
                  MemOP_v <= UInt<3>("h4") @[ContrGEN.scala 226:25]
                node _T_44 = eq(io.func3, UInt<1>("h1")) @[ContrGEN.scala 228:27]
                when _T_44 : @[ContrGEN.scala 228:41]
                  MemOP_v <= UInt<3>("h5") @[ContrGEN.scala 229:25]
                node _T_45 = eq(io.func3, UInt<2>("h2")) @[ContrGEN.scala 231:27]
                when _T_45 : @[ContrGEN.scala 231:41]
                  MemOP_v <= UInt<2>("h2") @[ContrGEN.scala 232:25]
              else :
                node _T_46 = eq(UInt<4>("hc"), _T) @[ContrGEN.scala 47:25]
                when _T_46 : @[ContrGEN.scala 47:25]
                  ExtOP_v <= UInt<1>("h0") @[ContrGEN.scala 237:21]
                  RegWr_v <= UInt<1>("h1") @[ContrGEN.scala 238:21]
                  ALUAsrc_v <= UInt<1>("h0") @[ContrGEN.scala 239:23]
                  ALUBsrc_v <= UInt<1>("h0") @[ContrGEN.scala 240:23]
                  Branch_v <= UInt<1>("h0") @[ContrGEN.scala 241:22]
                  MemtoReg_v <= UInt<1>("h0") @[ContrGEN.scala 242:24]
                  node _T_47 = eq(UInt<1>("h0"), io.func3) @[ContrGEN.scala 243:30]
                  when _T_47 : @[ContrGEN.scala 243:30]
                    node _T_48 = bits(io.func7, 6, 6) @[ContrGEN.scala 246:34]
                    when _T_48 : @[ContrGEN.scala 246:39]
                      ALUctr_v <= UInt<4>("h8") @[ContrGEN.scala 247:34]
                    else :
                      ALUctr_v <= UInt<1>("h0") @[ContrGEN.scala 249:34]
                  else :
                    node _T_49 = eq(UInt<1>("h1"), io.func3) @[ContrGEN.scala 243:30]
                    when _T_49 : @[ContrGEN.scala 243:30]
                      ALUctr_v <= UInt<1>("h1") @[ContrGEN.scala 254:30]
                    else :
                      node _T_50 = eq(UInt<2>("h2"), io.func3) @[ContrGEN.scala 243:30]
                      when _T_50 : @[ContrGEN.scala 243:30]
                        ALUctr_v <= UInt<2>("h2") @[ContrGEN.scala 258:30]
                      else :
                        node _T_51 = eq(UInt<2>("h3"), io.func3) @[ContrGEN.scala 243:30]
                        when _T_51 : @[ContrGEN.scala 243:30]
                          ALUctr_v <= UInt<4>("ha") @[ContrGEN.scala 262:30]
                        else :
                          node _T_52 = eq(UInt<3>("h4"), io.func3) @[ContrGEN.scala 243:30]
                          when _T_52 : @[ContrGEN.scala 243:30]
                            ALUctr_v <= UInt<3>("h4") @[ContrGEN.scala 266:30]
                          else :
                            node _T_53 = eq(UInt<3>("h5"), io.func3) @[ContrGEN.scala 243:30]
                            when _T_53 : @[ContrGEN.scala 243:30]
                              node _T_54 = bits(io.func7, 6, 6) @[ContrGEN.scala 270:34]
                              when _T_54 : @[ContrGEN.scala 270:39]
                                ALUctr_v <= UInt<4>("hd") @[ContrGEN.scala 271:34]
                              else :
                                ALUctr_v <= UInt<3>("h5") @[ContrGEN.scala 273:34]
                            else :
                              node _T_55 = eq(UInt<3>("h6"), io.func3) @[ContrGEN.scala 243:30]
                              when _T_55 : @[ContrGEN.scala 243:30]
                                ALUctr_v <= UInt<3>("h6") @[ContrGEN.scala 278:30]
                              else :
                                node _T_56 = eq(UInt<3>("h7"), io.func3) @[ContrGEN.scala 243:30]
                                when _T_56 : @[ContrGEN.scala 243:30]
                                  ALUctr_v <= UInt<3>("h7") @[ContrGEN.scala 282:30]
    io.ExtOP <= ExtOP_v @[ContrGEN.scala 288:14]
    io.RegWr <= RegWr_v @[ContrGEN.scala 289:14]
    io.ALUAsrc <= ALUAsrc_v @[ContrGEN.scala 290:16]
    io.ALUBsrc <= ALUBsrc_v @[ContrGEN.scala 291:16]
    io.ALUctr <= ALUctr_v @[ContrGEN.scala 292:15]
    io.Branch <= Branch_v @[ContrGEN.scala 293:15]
    io.MemtoReg <= MemtoReg_v @[ContrGEN.scala 294:17]
    io.MemWr <= MemWr_v @[ContrGEN.scala 295:14]
    io.MemOP <= MemOP_v @[ContrGEN.scala 296:14]

  module DataMem :
    input clock : Clock
    input reset : Reset
    output io : { DataOut : UInt<32>, flip Addr : UInt<32>, flip MemOp : UInt<3>, flip DataIn : UInt<32>, flip MemWr : UInt<1>, flip rdclk : Clock, flip wrclk : Clock}

    cmem mem : UInt<32> [32768] @[DataMem.scala 27:18]
    wire dataLoad : UInt<32>
    dataLoad <= UInt<32>("h0")
    node _dataLoad_T = dshr(io.Addr, UInt<2>("h2")) @[DataMem.scala 31:34]
    node _dataLoad_T_1 = bits(_dataLoad_T, 14, 0) @[DataMem.scala 31:25]
    read mport dataLoad_MPORT = mem[_dataLoad_T_1], clock @[DataMem.scala 31:25]
    dataLoad <= dataLoad_MPORT @[DataMem.scala 31:14]
    wire DataOut_v : UInt<32>
    DataOut_v <= UInt<32>("h0")
    when io.MemWr : @[DataMem.scala 36:20]
      node _T = asUInt(io.wrclk) @[DataMem.scala 37:30]
      node _T_1 = bits(_T, 0, 0) @[DataMem.scala 37:37]
      node _T_2 = not(_T_1) @[DataMem.scala 37:20]
      node _T_3 = asClock(_T_2) @[DataMem.scala 37:45]
      node _T_4 = eq(io.MemOp, UInt<2>("h2")) @[DataMem.scala 38:27]
      when _T_4 : @[DataMem.scala 38:44]
        node _T_5 = dshr(io.Addr, UInt<2>("h2")) @[DataMem.scala 39:35]
        node _T_6 = bits(_T_5, 14, 0)
        write mport MPORT = mem[_T_6], _T_3
        MPORT <= io.DataIn
      else :
        node _T_7 = eq(io.MemOp, UInt<3>("h5")) @[DataMem.scala 40:33]
        when _T_7 : @[DataMem.scala 40:50]
          node _T_8 = dshr(io.Addr, UInt<2>("h2")) @[DataMem.scala 42:29]
          node _T_9 = bits(dataLoad, 31, 16) @[DataMem.scala 43:33]
          node _T_10 = bits(io.DataIn, 15, 0) @[DataMem.scala 43:52]
          node _T_11 = cat(_T_9, _T_10) @[Cat.scala 31:58]
          node _T_12 = bits(_T_8, 14, 0)
          write mport MPORT_1 = mem[_T_12], _T_3
          MPORT_1 <= _T_11
        else :
          node _T_13 = eq(io.MemOp, UInt<3>("h4")) @[DataMem.scala 45:33]
          when _T_13 : @[DataMem.scala 45:50]
            node _T_14 = dshr(io.Addr, UInt<2>("h2")) @[DataMem.scala 47:29]
            node _T_15 = bits(dataLoad, 31, 8) @[DataMem.scala 48:33]
            node _T_16 = bits(io.DataIn, 7, 0) @[DataMem.scala 48:51]
            node _T_17 = cat(_T_15, _T_16) @[Cat.scala 31:58]
            node _T_18 = bits(_T_14, 14, 0)
            write mport MPORT_2 = mem[_T_18], _T_3
            MPORT_2 <= _T_17
          else :
            node _T_19 = eq(io.MemOp, UInt<1>("h1")) @[DataMem.scala 50:33]
            when _T_19 : @[DataMem.scala 50:53]
              node _DataIn_2by_s_T = bits(io.DataIn, 15, 15) @[DataMem.scala 52:39]
              node _DataIn_2by_s_T_1 = bits(_DataIn_2by_s_T, 0, 0) @[Bitwise.scala 74:15]
              node _DataIn_2by_s_T_2 = mux(_DataIn_2by_s_T_1, UInt<16>("hffff"), UInt<16>("h0")) @[Bitwise.scala 74:12]
              node _DataIn_2by_s_T_3 = bits(io.DataIn, 15, 0) @[DataMem.scala 53:30]
              node DataIn_2by_s = cat(_DataIn_2by_s_T_2, _DataIn_2by_s_T_3) @[Cat.scala 31:58]
              node _T_20 = dshr(io.Addr, UInt<2>("h2")) @[DataMem.scala 56:29]
              node _T_21 = bits(_T_20, 14, 0)
              write mport MPORT_3 = mem[_T_21], _T_3
              MPORT_3 <= DataIn_2by_s
            else :
              node _DataIn_1by_s_T = bits(io.DataIn, 7, 7) @[DataMem.scala 61:39]
              node _DataIn_1by_s_T_1 = bits(_DataIn_1by_s_T, 0, 0) @[Bitwise.scala 74:15]
              node _DataIn_1by_s_T_2 = mux(_DataIn_1by_s_T_1, UInt<24>("hffffff"), UInt<24>("h0")) @[Bitwise.scala 74:12]
              node _DataIn_1by_s_T_3 = bits(io.DataIn, 7, 0) @[DataMem.scala 62:30]
              node DataIn_1by_s = cat(_DataIn_1by_s_T_2, _DataIn_1by_s_T_3) @[Cat.scala 31:58]
              node _T_22 = dshr(io.Addr, UInt<2>("h2")) @[DataMem.scala 65:29]
              node _T_23 = bits(_T_22, 14, 0)
              write mport MPORT_4 = mem[_T_23], _T_3
              MPORT_4 <= DataIn_1by_s
    else :
      node _T_24 = eq(io.MemOp, UInt<2>("h2")) @[DataMem.scala 74:31]
      when _T_24 : @[DataMem.scala 74:48]
        DataOut_v <= dataLoad @[DataMem.scala 75:31]
      else :
        node _T_25 = eq(io.MemOp, UInt<3>("h5")) @[DataMem.scala 76:37]
        when _T_25 : @[DataMem.scala 76:54]
          node _DataOut_v_T = mux(UInt<1>("h0"), UInt<16>("hffff"), UInt<16>("h0")) @[Bitwise.scala 74:12]
          node _DataOut_v_T_1 = bits(dataLoad, 15, 0) @[DataMem.scala 77:61]
          node _DataOut_v_T_2 = cat(_DataOut_v_T, _DataOut_v_T_1) @[Cat.scala 31:58]
          DataOut_v <= _DataOut_v_T_2 @[DataMem.scala 77:31]
        else :
          node _T_26 = eq(io.MemOp, UInt<3>("h4")) @[DataMem.scala 78:37]
          when _T_26 : @[DataMem.scala 78:54]
            node _DataOut_v_T_3 = mux(UInt<1>("h0"), UInt<24>("hffffff"), UInt<24>("h0")) @[Bitwise.scala 74:12]
            node _DataOut_v_T_4 = bits(dataLoad, 7, 0) @[DataMem.scala 79:61]
            node _DataOut_v_T_5 = cat(_DataOut_v_T_3, _DataOut_v_T_4) @[Cat.scala 31:58]
            DataOut_v <= _DataOut_v_T_5 @[DataMem.scala 79:31]
          else :
            node _T_27 = eq(io.MemOp, UInt<1>("h1")) @[DataMem.scala 80:37]
            when _T_27 : @[DataMem.scala 80:57]
              node _DataOut_v_T_6 = bits(dataLoad, 15, 15) @[DataMem.scala 81:55]
              node _DataOut_v_T_7 = bits(_DataOut_v_T_6, 0, 0) @[Bitwise.scala 74:15]
              node _DataOut_v_T_8 = mux(_DataOut_v_T_7, UInt<16>("hffff"), UInt<16>("h0")) @[Bitwise.scala 74:12]
              node _DataOut_v_T_9 = bits(dataLoad, 15, 0) @[DataMem.scala 81:70]
              node _DataOut_v_T_10 = cat(_DataOut_v_T_8, _DataOut_v_T_9) @[Cat.scala 31:58]
              DataOut_v <= _DataOut_v_T_10 @[DataMem.scala 81:31]
            else :
              node _DataOut_v_T_11 = bits(dataLoad, 7, 7) @[DataMem.scala 83:55]
              node _DataOut_v_T_12 = bits(_DataOut_v_T_11, 0, 0) @[Bitwise.scala 74:15]
              node _DataOut_v_T_13 = mux(_DataOut_v_T_12, UInt<24>("hffffff"), UInt<24>("h0")) @[Bitwise.scala 74:12]
              node _DataOut_v_T_14 = bits(dataLoad, 7, 0) @[DataMem.scala 83:69]
              node _DataOut_v_T_15 = cat(_DataOut_v_T_13, _DataOut_v_T_14) @[Cat.scala 31:58]
              DataOut_v <= _DataOut_v_T_15 @[DataMem.scala 83:31]
    io.DataOut <= DataOut_v @[DataMem.scala 87:16]

  module ImmGen :
    input clock : Clock
    input reset : Reset
    output io : { Imm : UInt<32>, flip ExtOp : UInt<3>, flip Instr_31_7 : UInt<25>}

    node _imm_i_T = bits(io.Instr_31_7, 24, 24) @[ImmGen.scala 22:43]
    node _imm_i_T_1 = bits(_imm_i_T, 0, 0) @[Bitwise.scala 74:15]
    node _imm_i_T_2 = mux(_imm_i_T_1, UInt<20>("hfffff"), UInt<20>("h0")) @[Bitwise.scala 74:12]
    node _imm_i_T_3 = bits(io.Instr_31_7, 24, 13) @[ImmGen.scala 22:63]
    node imm_i = cat(_imm_i_T_2, _imm_i_T_3) @[Cat.scala 31:58]
    node _imm_s_T = bits(io.Instr_31_7, 24, 24) @[ImmGen.scala 24:31]
    node _imm_s_T_1 = bits(_imm_s_T, 0, 0) @[Bitwise.scala 74:15]
    node _imm_s_T_2 = mux(_imm_s_T_1, UInt<20>("hfffff"), UInt<20>("h0")) @[Bitwise.scala 74:12]
    node _imm_s_T_3 = bits(io.Instr_31_7, 24, 18) @[ImmGen.scala 25:22]
    node _imm_s_T_4 = bits(io.Instr_31_7, 4, 0) @[ImmGen.scala 26:22]
    node imm_s_hi = cat(_imm_s_T_2, _imm_s_T_3) @[Cat.scala 31:58]
    node imm_s = cat(imm_s_hi, _imm_s_T_4) @[Cat.scala 31:58]
    node _imm_b_T = bits(io.Instr_31_7, 24, 24) @[ImmGen.scala 29:31]
    node _imm_b_T_1 = bits(_imm_b_T, 0, 0) @[Bitwise.scala 74:15]
    node _imm_b_T_2 = mux(_imm_b_T_1, UInt<20>("hfffff"), UInt<20>("h0")) @[Bitwise.scala 74:12]
    node _imm_b_T_3 = bits(io.Instr_31_7, 0, 0) @[ImmGen.scala 30:22]
    node _imm_b_T_4 = bits(io.Instr_31_7, 23, 18) @[ImmGen.scala 31:22]
    node _imm_b_T_5 = bits(io.Instr_31_7, 4, 1) @[ImmGen.scala 32:22]
    node imm_b_lo = cat(_imm_b_T_5, UInt<1>("h0")) @[Cat.scala 31:58]
    node imm_b_hi_hi = cat(_imm_b_T_2, _imm_b_T_3) @[Cat.scala 31:58]
    node imm_b_hi = cat(imm_b_hi_hi, _imm_b_T_4) @[Cat.scala 31:58]
    node imm_b = cat(imm_b_hi, imm_b_lo) @[Cat.scala 31:58]
    node _imm_u_T = bits(io.Instr_31_7, 24, 5) @[ImmGen.scala 35:34]
    node _imm_u_T_1 = mux(UInt<1>("h0"), UInt<12>("hfff"), UInt<12>("h0")) @[Bitwise.scala 74:12]
    node imm_u = cat(_imm_u_T, _imm_u_T_1) @[Cat.scala 31:58]
    node _imm_j_T = bits(io.Instr_31_7, 24, 24) @[ImmGen.scala 37:31]
    node _imm_j_T_1 = bits(_imm_j_T, 0, 0) @[Bitwise.scala 74:15]
    node _imm_j_T_2 = mux(_imm_j_T_1, UInt<12>("hfff"), UInt<12>("h0")) @[Bitwise.scala 74:12]
    node _imm_j_T_3 = bits(io.Instr_31_7, 24, 24) @[ImmGen.scala 38:22]
    node _imm_j_T_4 = bits(io.Instr_31_7, 12, 5) @[ImmGen.scala 39:22]
    node _imm_j_T_5 = bits(io.Instr_31_7, 13, 13) @[ImmGen.scala 40:22]
    node _imm_j_T_6 = bits(io.Instr_31_7, 23, 14) @[ImmGen.scala 41:22]
    node imm_j_lo_hi = cat(_imm_j_T_5, _imm_j_T_6) @[Cat.scala 31:58]
    node imm_j_lo = cat(imm_j_lo_hi, UInt<1>("h0")) @[Cat.scala 31:58]
    node imm_j_hi_hi = cat(_imm_j_T_2, _imm_j_T_3) @[Cat.scala 31:58]
    node imm_j_hi = cat(imm_j_hi_hi, _imm_j_T_4) @[Cat.scala 31:58]
    node imm_j = cat(imm_j_hi, imm_j_lo) @[Cat.scala 31:58]
    node _imm_T = eq(UInt<1>("h0"), io.ExtOp) @[Mux.scala 81:61]
    node _imm_T_1 = mux(_imm_T, imm_i, UInt<1>("h0")) @[Mux.scala 81:58]
    node _imm_T_2 = eq(UInt<1>("h1"), io.ExtOp) @[Mux.scala 81:61]
    node _imm_T_3 = mux(_imm_T_2, imm_u, _imm_T_1) @[Mux.scala 81:58]
    node _imm_T_4 = eq(UInt<4>("ha"), io.ExtOp) @[Mux.scala 81:61]
    node _imm_T_5 = mux(_imm_T_4, imm_s, _imm_T_3) @[Mux.scala 81:58]
    node _imm_T_6 = eq(UInt<4>("hb"), io.ExtOp) @[Mux.scala 81:61]
    node _imm_T_7 = mux(_imm_T_6, imm_b, _imm_T_5) @[Mux.scala 81:58]
    node _imm_T_8 = eq(UInt<7>("h64"), io.ExtOp) @[Mux.scala 81:61]
    node imm = mux(_imm_T_8, imm_j, _imm_T_7) @[Mux.scala 81:58]
    io.Imm <= imm @[ImmGen.scala 57:12]

  module MemInst :
    input clock : Clock
    input reset : Reset
    output io : { flip addr : UInt<32>, Instr : UInt<32>, flip MemInstclk : Clock}

    cmem mem : UInt<32> [1024] @[MemInst.scala 20:18]
    node _T = asUInt(io.MemInstclk) @[MemInst.scala 35:31]
    node _T_1 = bits(_T, 0, 0) @[MemInst.scala 35:38]
    node _T_2 = not(_T_1) @[MemInst.scala 35:16]
    node _T_3 = asClock(_T_2) @[MemInst.scala 35:46]
    node _io_Instr_T = dshr(io.addr, UInt<2>("h2")) @[MemInst.scala 37:21]
    node _io_Instr_T_1 = bits(_io_Instr_T, 9, 0) @[MemInst.scala 36:29]
    read mport io_Instr_MPORT = mem[_io_Instr_T_1], _T_3 @[MemInst.scala 36:29]
    io.Instr <= io_Instr_MPORT @[MemInst.scala 36:18]

  module PCReg :
    input clock : Clock
    input reset : Reset
    output io : { NextPC : UInt<32>, flip PCAsrc : UInt<1>, flip PCBsrc : UInt<1>, flip PC : UInt<32>, flip rs1 : UInt<32>, flip imm : UInt<32>}

    reg regPC : UInt<32>, clock with :
      reset => (reset, UInt<8>("h84")) @[PCReg.scala 25:16]
    node _nextPC_T = mux(io.PCAsrc, io.imm, UInt<3>("h4")) @[PCReg.scala 31:12]
    node _nextPC_T_1 = mux(io.PCBsrc, io.rs1, io.PC) @[PCReg.scala 31:42]
    node _nextPC_T_2 = add(_nextPC_T, _nextPC_T_1) @[PCReg.scala 31:37]
    node nextPC = tail(_nextPC_T_2, 1) @[PCReg.scala 31:37]
    io.NextPC <= nextPC @[PCReg.scala 34:15]

  module MemtoReg :
    input clock : Clock
    input reset : Reset
    output io : { DataOut : UInt<32>, flip Alu_result : UInt<32>, flip DataMem_result : UInt<32>, flip Memtoreg : UInt<1>}

    wire DataOut_v : UInt<32>
    DataOut_v <= UInt<32>("h0")
    node _DataOut_v_T = mux(io.Memtoreg, io.DataMem_result, io.Alu_result) @[MemtoReg.scala 24:21]
    DataOut_v <= _DataOut_v_T @[MemtoReg.scala 24:15]
    io.DataOut <= DataOut_v @[MemtoReg.scala 26:16]

  module PC :
    input clock : Clock
    input reset : Reset
    output io : { PC : UInt<32>, flip NextPC : UInt<32>, flip pcclk : Clock}

    reg reg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[PC.scala 22:22]
    node _T = asUInt(io.pcclk) @[PC.scala 23:26]
    node _T_1 = bits(_T, 0, 0) @[PC.scala 23:33]
    node _T_2 = not(_T_1) @[PC.scala 23:16]
    node _T_3 = asClock(_T_2) @[PC.scala 23:41]
    reg <= io.NextPC @[PC.scala 24:13]
    io.PC <= reg @[PC.scala 25:15]

  module Instrop :
    input clock : Clock
    input reset : Reset
    output io : { rs1 : UInt<5>, rs2 : UInt<5>, rd : UInt<5>, Instr_ImmGen : UInt<24>, op : UInt<7>, func3 : UInt<3>, func7 : UInt<7>, flip Instr : UInt<32>}

    wire Instr_v : UInt<32>
    Instr_v <= UInt<32>("h0")
    node _io_rs1_T = bits(Instr_v, 19, 15) @[Instrop.scala 25:22]
    io.rs1 <= _io_rs1_T @[Instrop.scala 25:12]
    node _io_rs2_T = bits(Instr_v, 24, 20) @[Instrop.scala 26:22]
    io.rs2 <= _io_rs2_T @[Instrop.scala 26:12]
    node _io_rd_T = bits(Instr_v, 11, 7) @[Instrop.scala 27:21]
    io.rd <= _io_rd_T @[Instrop.scala 27:11]
    node _io_Instr_ImmGen_T = bits(Instr_v, 31, 7) @[Instrop.scala 28:31]
    io.Instr_ImmGen <= _io_Instr_ImmGen_T @[Instrop.scala 28:21]
    node _io_op_T = bits(Instr_v, 6, 0) @[Instrop.scala 29:21]
    io.op <= _io_op_T @[Instrop.scala 29:11]
    node _io_func3_T = bits(Instr_v, 14, 12) @[Instrop.scala 30:24]
    io.func3 <= _io_func3_T @[Instrop.scala 30:14]
    node _io_func7_T = bits(Instr_v, 31, 25) @[Instrop.scala 31:24]
    io.func7 <= _io_func7_T @[Instrop.scala 31:14]

  module Top :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip clk : Clock}

    inst alu of Alu @[Top.scala 17:21]
    alu.clock <= clock
    alu.reset <= reset
    inst regFile of RegFile @[Top.scala 18:25]
    regFile.clock <= clock
    regFile.reset <= reset
    inst branchcond of BranchCond @[Top.scala 19:28]
    branchcond.clock <= clock
    branchcond.reset <= reset
    inst contrgen of ContrGEN @[Top.scala 20:26]
    contrgen.clock <= clock
    contrgen.reset <= reset
    inst datamem of DataMem @[Top.scala 21:25]
    datamem.clock <= clock
    datamem.reset <= reset
    inst immgen of ImmGen @[Top.scala 22:24]
    immgen.clock <= clock
    immgen.reset <= reset
    inst meminst of MemInst @[Top.scala 23:25]
    meminst.clock <= clock
    meminst.reset <= reset
    inst pcreg of PCReg @[Top.scala 24:23]
    pcreg.clock <= clock
    pcreg.reset <= reset
    inst memtoreg of MemtoReg @[Top.scala 25:26]
    memtoreg.clock <= clock
    memtoreg.reset <= reset
    inst pc of PC @[Top.scala 26:20]
    pc.clock <= clock
    pc.reset <= reset
    inst instrop of Instrop @[Top.scala 27:25]
    instrop.clock <= clock
    instrop.reset <= reset
    pc.io.NextPC <= pcreg.io.NextPC @[Top.scala 30:18]
    pc.io.pcclk <= io.clk @[Top.scala 31:17]
    meminst.io.addr <= pcreg.io.NextPC @[Top.scala 34:21]
    meminst.io.MemInstclk <= io.clk @[Top.scala 35:27]
    instrop.io.Instr <= meminst.io.Instr @[Top.scala 38:22]
    regFile.io.Ra <= instrop.io.rs1 @[Top.scala 41:19]
    regFile.io.Rb <= instrop.io.rs2 @[Top.scala 42:19]
    regFile.io.Rw <= instrop.io.rd @[Top.scala 43:19]
    regFile.io.busW <= memtoreg.io.DataOut @[Top.scala 44:21]
    regFile.io.RegWr <= contrgen.io.RegWr @[Top.scala 45:22]
    regFile.io.RegFileclk <= io.clk @[Top.scala 46:27]
    immgen.io.Instr_31_7 <= instrop.io.Instr_ImmGen @[Top.scala 49:26]
    immgen.io.ExtOp <= contrgen.io.ExtOP @[Top.scala 50:21]
    contrgen.io.op <= instrop.io.op @[Top.scala 53:20]
    contrgen.io.func3 <= instrop.io.func3 @[Top.scala 54:23]
    contrgen.io.func7 <= instrop.io.func7 @[Top.scala 55:23]
    pcreg.io.PCAsrc <= branchcond.io.PCAsrc @[Top.scala 58:21]
    pcreg.io.PCBsrc <= branchcond.io.PCBsrc @[Top.scala 59:21]
    pcreg.io.PC <= pc.io.PC @[Top.scala 60:17]
    pcreg.io.rs1 <= regFile.io.busA @[Top.scala 61:18]
    pcreg.io.imm <= immgen.io.Imm @[Top.scala 62:18]
    alu.io.PC <= pc.io.PC @[Top.scala 65:15]
    alu.io.rs1 <= regFile.io.busA @[Top.scala 66:16]
    alu.io.rs2 <= regFile.io.busB @[Top.scala 67:16]
    alu.io.imm <= immgen.io.Imm @[Top.scala 68:16]
    alu.io.ALUAsrc <= contrgen.io.ALUAsrc @[Top.scala 69:20]
    alu.io.ALUBsrc <= contrgen.io.ALUBsrc @[Top.scala 70:20]
    alu.io.ALUctr <= contrgen.io.ALUctr @[Top.scala 71:19]
    branchcond.io.Branch <= contrgen.io.Branch @[Top.scala 74:26]
    branchcond.io.Less <= alu.io.Less @[Top.scala 75:24]
    branchcond.io.Zero <= alu.io.Zero @[Top.scala 76:24]
    datamem.io.Addr <= alu.io.Result @[Top.scala 79:21]
    datamem.io.MemOp <= contrgen.io.MemOP @[Top.scala 80:22]
    datamem.io.DataIn <= regFile.io.busB @[Top.scala 81:23]
    datamem.io.MemWr <= contrgen.io.MemWr @[Top.scala 82:22]
    datamem.io.rdclk <= io.clk @[Top.scala 83:22]
    datamem.io.wrclk <= io.clk @[Top.scala 84:22]
    memtoreg.io.Alu_result <= alu.io.Result @[Top.scala 87:28]
    memtoreg.io.DataMem_result <= datamem.io.DataOut @[Top.scala 88:32]
    memtoreg.io.Memtoreg <= contrgen.io.MemtoReg @[Top.scala 89:26]

