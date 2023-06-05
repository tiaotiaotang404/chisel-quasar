// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "VNPC__Syms.h"


VL_ATTR_COLD void VNPC___024root__trace_init_sub__TOP__0(VNPC___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    VNPC__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VNPC___024root__trace_init_sub__TOP__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBit(c+52,"clock", false,-1);
    tracep->declBit(c+53,"reset", false,-1);
    tracep->declBit(c+54,"io_halt", false,-1);
    tracep->pushNamePrefix("NPC ");
    tracep->declBit(c+52,"clock", false,-1);
    tracep->declBit(c+53,"reset", false,-1);
    tracep->declBit(c+54,"io_halt", false,-1);
    for (int i = 0; i < 32; ++i) {
        tracep->declBus(c+1+i*1,"R", true,(i+0), 31,0);
    }
    tracep->declBit(c+55,"R_MPORT_1_en", false,-1);
    tracep->declBus(c+33,"R_MPORT_1_addr", false,-1, 4,0);
    tracep->declBus(c+34,"R_MPORT_1_data", false,-1, 31,0);
    tracep->declBit(c+55,"R_MPORT_2_en", false,-1);
    tracep->declBus(c+35,"R_MPORT_2_addr", false,-1, 4,0);
    tracep->declBus(c+36,"R_MPORT_2_data", false,-1, 31,0);
    tracep->declBus(c+37,"R_MPORT_3_data", false,-1, 31,0);
    tracep->declBus(c+38,"R_MPORT_3_addr", false,-1, 4,0);
    tracep->declBit(c+55,"R_MPORT_3_mask", false,-1);
    tracep->declBit(c+39,"R_MPORT_3_en", false,-1);
    tracep->declBus(c+40,"R_MPORT_4_data", false,-1, 31,0);
    tracep->declBus(c+38,"R_MPORT_4_addr", false,-1, 4,0);
    tracep->declBit(c+55,"R_MPORT_4_mask", false,-1);
    tracep->declBit(c+41,"R_MPORT_4_en", false,-1);
    tracep->declBit(c+55,"M_MPORT_en", false,-1);
    tracep->declBus(c+42,"M_MPORT_addr", false,-1, 7,0);
    tracep->declBus(c+43,"M_MPORT_data", false,-1, 31,0);
    tracep->declBus(c+44,"PC", false,-1, 31,0);
    tracep->declBus(c+45,"inst_opcode", false,-1, 6,0);
    tracep->declBus(c+38,"inst_rd", false,-1, 4,0);
    tracep->declBus(c+46,"inst_funct3", false,-1, 2,0);
    tracep->declBus(c+47,"inst_rs1", false,-1, 4,0);
    tracep->declBus(c+48,"inst_imm11_0", false,-1, 11,0);
    tracep->declBit(c+49,"isEbreak", false,-1);
    tracep->declBus(c+50,"rs1Val", false,-1, 31,0);
    tracep->declBus(c+51,"rs2Val", false,-1, 31,0);
    tracep->popNamePrefix(1);
}

VL_ATTR_COLD void VNPC___024root__trace_init_top(VNPC___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    VNPC__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VNPC___024root__trace_init_top\n"); );
    // Body
    VNPC___024root__trace_init_sub__TOP__0(vlSelf, tracep);
}

VL_ATTR_COLD void VNPC___024root__trace_full_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void VNPC___024root__trace_chg_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void VNPC___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/);

VL_ATTR_COLD void VNPC___024root__trace_register(VNPC___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    VNPC__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VNPC___024root__trace_register\n"); );
    // Body
    tracep->addFullCb(&VNPC___024root__trace_full_top_0, vlSelf);
    tracep->addChgCb(&VNPC___024root__trace_chg_top_0, vlSelf);
    tracep->addCleanupCb(&VNPC___024root__trace_cleanup, vlSelf);
}

VL_ATTR_COLD void VNPC___024root__trace_full_sub_0(VNPC___024root* vlSelf, VerilatedVcd::Buffer* bufp);

VL_ATTR_COLD void VNPC___024root__trace_full_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VNPC___024root__trace_full_top_0\n"); );
    // Init
    VNPC___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<VNPC___024root*>(voidSelf);
    VNPC__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    VNPC___024root__trace_full_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void VNPC___024root__trace_full_sub_0(VNPC___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    VNPC__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VNPC___024root__trace_full_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    // Body
    bufp->fullIData(oldp+1,(vlSelf->NPC__DOT__R[0]),32);
    bufp->fullIData(oldp+2,(vlSelf->NPC__DOT__R[1]),32);
    bufp->fullIData(oldp+3,(vlSelf->NPC__DOT__R[2]),32);
    bufp->fullIData(oldp+4,(vlSelf->NPC__DOT__R[3]),32);
    bufp->fullIData(oldp+5,(vlSelf->NPC__DOT__R[4]),32);
    bufp->fullIData(oldp+6,(vlSelf->NPC__DOT__R[5]),32);
    bufp->fullIData(oldp+7,(vlSelf->NPC__DOT__R[6]),32);
    bufp->fullIData(oldp+8,(vlSelf->NPC__DOT__R[7]),32);
    bufp->fullIData(oldp+9,(vlSelf->NPC__DOT__R[8]),32);
    bufp->fullIData(oldp+10,(vlSelf->NPC__DOT__R[9]),32);
    bufp->fullIData(oldp+11,(vlSelf->NPC__DOT__R[10]),32);
    bufp->fullIData(oldp+12,(vlSelf->NPC__DOT__R[11]),32);
    bufp->fullIData(oldp+13,(vlSelf->NPC__DOT__R[12]),32);
    bufp->fullIData(oldp+14,(vlSelf->NPC__DOT__R[13]),32);
    bufp->fullIData(oldp+15,(vlSelf->NPC__DOT__R[14]),32);
    bufp->fullIData(oldp+16,(vlSelf->NPC__DOT__R[15]),32);
    bufp->fullIData(oldp+17,(vlSelf->NPC__DOT__R[16]),32);
    bufp->fullIData(oldp+18,(vlSelf->NPC__DOT__R[17]),32);
    bufp->fullIData(oldp+19,(vlSelf->NPC__DOT__R[18]),32);
    bufp->fullIData(oldp+20,(vlSelf->NPC__DOT__R[19]),32);
    bufp->fullIData(oldp+21,(vlSelf->NPC__DOT__R[20]),32);
    bufp->fullIData(oldp+22,(vlSelf->NPC__DOT__R[21]),32);
    bufp->fullIData(oldp+23,(vlSelf->NPC__DOT__R[22]),32);
    bufp->fullIData(oldp+24,(vlSelf->NPC__DOT__R[23]),32);
    bufp->fullIData(oldp+25,(vlSelf->NPC__DOT__R[24]),32);
    bufp->fullIData(oldp+26,(vlSelf->NPC__DOT__R[25]),32);
    bufp->fullIData(oldp+27,(vlSelf->NPC__DOT__R[26]),32);
    bufp->fullIData(oldp+28,(vlSelf->NPC__DOT__R[27]),32);
    bufp->fullIData(oldp+29,(vlSelf->NPC__DOT__R[28]),32);
    bufp->fullIData(oldp+30,(vlSelf->NPC__DOT__R[29]),32);
    bufp->fullIData(oldp+31,(vlSelf->NPC__DOT__R[30]),32);
    bufp->fullIData(oldp+32,(vlSelf->NPC__DOT__R[31]),32);
    bufp->fullCData(oldp+33,(vlSelf->NPC__DOT__R_MPORT_1_addr),5);
    bufp->fullIData(oldp+34,(vlSelf->NPC__DOT__R[vlSelf->NPC__DOT__R_MPORT_1_addr]),32);
    bufp->fullCData(oldp+35,(((0x100073U == vlSelf->NPC__DOT__M_MPORT_data)
                               ? 0xbU : 0U)),5);
    bufp->fullIData(oldp+36,(vlSelf->NPC__DOT__R[((0x100073U 
                                                   == vlSelf->NPC__DOT__M_MPORT_data)
                                                   ? 0xbU
                                                   : 0U)]),32);
    bufp->fullIData(oldp+37,((vlSelf->NPC__DOT__rs1Val 
                              + ((((vlSelf->NPC__DOT__M_MPORT_data 
                                    >> 0x1fU) ? 0xfffffU
                                    : 0U) << 0xcU) 
                                 | (vlSelf->NPC__DOT__M_MPORT_data 
                                    >> 0x14U)))),32);
    bufp->fullCData(oldp+38,((0x1fU & (vlSelf->NPC__DOT__M_MPORT_data 
                                       >> 7U))),5);
    bufp->fullBit(oldp+39,((IData)((0x13U == (0x707fU 
                                              & vlSelf->NPC__DOT__M_MPORT_data)))));
    bufp->fullIData(oldp+40,(((IData)(4U) + vlSelf->NPC__DOT__PC)),32);
    bufp->fullBit(oldp+41,((0x6fU == (0x7fU & vlSelf->NPC__DOT__M_MPORT_data))));
    bufp->fullCData(oldp+42,((0xffU & vlSelf->NPC__DOT__PC)),8);
    bufp->fullIData(oldp+43,(vlSelf->NPC__DOT__M_MPORT_data),32);
    bufp->fullIData(oldp+44,(vlSelf->NPC__DOT__PC),32);
    bufp->fullCData(oldp+45,((0x7fU & vlSelf->NPC__DOT__M_MPORT_data)),7);
    bufp->fullCData(oldp+46,((7U & (vlSelf->NPC__DOT__M_MPORT_data 
                                    >> 0xcU))),3);
    bufp->fullCData(oldp+47,((0x1fU & (vlSelf->NPC__DOT__M_MPORT_data 
                                       >> 0xfU))),5);
    bufp->fullSData(oldp+48,((vlSelf->NPC__DOT__M_MPORT_data 
                              >> 0x14U)),12);
    bufp->fullBit(oldp+49,((0x100073U == vlSelf->NPC__DOT__M_MPORT_data)));
    bufp->fullIData(oldp+50,(vlSelf->NPC__DOT__rs1Val),32);
    bufp->fullIData(oldp+51,(((0U == ((0x100073U == vlSelf->NPC__DOT__M_MPORT_data)
                                       ? 0xbU : 0U))
                               ? 0U : vlSelf->NPC__DOT__R
                              [((0x100073U == vlSelf->NPC__DOT__M_MPORT_data)
                                 ? 0xbU : 0U)])),32);
    bufp->fullBit(oldp+52,(vlSelf->clock));
    bufp->fullBit(oldp+53,(vlSelf->reset));
    bufp->fullBit(oldp+54,(vlSelf->io_halt));
    bufp->fullBit(oldp+55,(1U));
}
