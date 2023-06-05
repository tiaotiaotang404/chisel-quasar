// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "VNPC__Syms.h"


void VNPC___024root__trace_chg_sub_0(VNPC___024root* vlSelf, VerilatedVcd::Buffer* bufp);

void VNPC___024root__trace_chg_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VNPC___024root__trace_chg_top_0\n"); );
    // Init
    VNPC___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<VNPC___024root*>(voidSelf);
    VNPC__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    // Body
    VNPC___024root__trace_chg_sub_0((&vlSymsp->TOP), bufp);
}

void VNPC___024root__trace_chg_sub_0(VNPC___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    VNPC__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VNPC___024root__trace_chg_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode + 1);
    // Body
    if (VL_UNLIKELY(vlSelf->__Vm_traceActivity[1U])) {
        bufp->chgIData(oldp+0,(vlSelf->NPC__DOT__R[0]),32);
        bufp->chgIData(oldp+1,(vlSelf->NPC__DOT__R[1]),32);
        bufp->chgIData(oldp+2,(vlSelf->NPC__DOT__R[2]),32);
        bufp->chgIData(oldp+3,(vlSelf->NPC__DOT__R[3]),32);
        bufp->chgIData(oldp+4,(vlSelf->NPC__DOT__R[4]),32);
        bufp->chgIData(oldp+5,(vlSelf->NPC__DOT__R[5]),32);
        bufp->chgIData(oldp+6,(vlSelf->NPC__DOT__R[6]),32);
        bufp->chgIData(oldp+7,(vlSelf->NPC__DOT__R[7]),32);
        bufp->chgIData(oldp+8,(vlSelf->NPC__DOT__R[8]),32);
        bufp->chgIData(oldp+9,(vlSelf->NPC__DOT__R[9]),32);
        bufp->chgIData(oldp+10,(vlSelf->NPC__DOT__R[10]),32);
        bufp->chgIData(oldp+11,(vlSelf->NPC__DOT__R[11]),32);
        bufp->chgIData(oldp+12,(vlSelf->NPC__DOT__R[12]),32);
        bufp->chgIData(oldp+13,(vlSelf->NPC__DOT__R[13]),32);
        bufp->chgIData(oldp+14,(vlSelf->NPC__DOT__R[14]),32);
        bufp->chgIData(oldp+15,(vlSelf->NPC__DOT__R[15]),32);
        bufp->chgIData(oldp+16,(vlSelf->NPC__DOT__R[16]),32);
        bufp->chgIData(oldp+17,(vlSelf->NPC__DOT__R[17]),32);
        bufp->chgIData(oldp+18,(vlSelf->NPC__DOT__R[18]),32);
        bufp->chgIData(oldp+19,(vlSelf->NPC__DOT__R[19]),32);
        bufp->chgIData(oldp+20,(vlSelf->NPC__DOT__R[20]),32);
        bufp->chgIData(oldp+21,(vlSelf->NPC__DOT__R[21]),32);
        bufp->chgIData(oldp+22,(vlSelf->NPC__DOT__R[22]),32);
        bufp->chgIData(oldp+23,(vlSelf->NPC__DOT__R[23]),32);
        bufp->chgIData(oldp+24,(vlSelf->NPC__DOT__R[24]),32);
        bufp->chgIData(oldp+25,(vlSelf->NPC__DOT__R[25]),32);
        bufp->chgIData(oldp+26,(vlSelf->NPC__DOT__R[26]),32);
        bufp->chgIData(oldp+27,(vlSelf->NPC__DOT__R[27]),32);
        bufp->chgIData(oldp+28,(vlSelf->NPC__DOT__R[28]),32);
        bufp->chgIData(oldp+29,(vlSelf->NPC__DOT__R[29]),32);
        bufp->chgIData(oldp+30,(vlSelf->NPC__DOT__R[30]),32);
        bufp->chgIData(oldp+31,(vlSelf->NPC__DOT__R[31]),32);
        bufp->chgCData(oldp+32,(vlSelf->NPC__DOT__R_MPORT_1_addr),5);
        bufp->chgIData(oldp+33,(vlSelf->NPC__DOT__R
                                [vlSelf->NPC__DOT__R_MPORT_1_addr]),32);
        bufp->chgCData(oldp+34,(((0x100073U == vlSelf->NPC__DOT__M_MPORT_data)
                                  ? 0xbU : 0U)),5);
        bufp->chgIData(oldp+35,(vlSelf->NPC__DOT__R
                                [((0x100073U == vlSelf->NPC__DOT__M_MPORT_data)
                                   ? 0xbU : 0U)]),32);
        bufp->chgIData(oldp+36,((vlSelf->NPC__DOT__rs1Val 
                                 + ((((vlSelf->NPC__DOT__M_MPORT_data 
                                       >> 0x1fU) ? 0xfffffU
                                       : 0U) << 0xcU) 
                                    | (vlSelf->NPC__DOT__M_MPORT_data 
                                       >> 0x14U)))),32);
        bufp->chgCData(oldp+37,((0x1fU & (vlSelf->NPC__DOT__M_MPORT_data 
                                          >> 7U))),5);
        bufp->chgBit(oldp+38,((IData)((0x13U == (0x707fU 
                                                 & vlSelf->NPC__DOT__M_MPORT_data)))));
        bufp->chgIData(oldp+39,(((IData)(4U) + vlSelf->NPC__DOT__PC)),32);
        bufp->chgBit(oldp+40,((0x6fU == (0x7fU & vlSelf->NPC__DOT__M_MPORT_data))));
        bufp->chgCData(oldp+41,((0xffU & vlSelf->NPC__DOT__PC)),8);
        bufp->chgIData(oldp+42,(vlSelf->NPC__DOT__M_MPORT_data),32);
        bufp->chgIData(oldp+43,(vlSelf->NPC__DOT__PC),32);
        bufp->chgCData(oldp+44,((0x7fU & vlSelf->NPC__DOT__M_MPORT_data)),7);
        bufp->chgCData(oldp+45,((7U & (vlSelf->NPC__DOT__M_MPORT_data 
                                       >> 0xcU))),3);
        bufp->chgCData(oldp+46,((0x1fU & (vlSelf->NPC__DOT__M_MPORT_data 
                                          >> 0xfU))),5);
        bufp->chgSData(oldp+47,((vlSelf->NPC__DOT__M_MPORT_data 
                                 >> 0x14U)),12);
        bufp->chgBit(oldp+48,((0x100073U == vlSelf->NPC__DOT__M_MPORT_data)));
        bufp->chgIData(oldp+49,(vlSelf->NPC__DOT__rs1Val),32);
        bufp->chgIData(oldp+50,(((0U == ((0x100073U 
                                          == vlSelf->NPC__DOT__M_MPORT_data)
                                          ? 0xbU : 0U))
                                  ? 0U : vlSelf->NPC__DOT__R
                                 [((0x100073U == vlSelf->NPC__DOT__M_MPORT_data)
                                    ? 0xbU : 0U)])),32);
    }
    bufp->chgBit(oldp+51,(vlSelf->clock));
    bufp->chgBit(oldp+52,(vlSelf->reset));
    bufp->chgBit(oldp+53,(vlSelf->io_halt));
}

void VNPC___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VNPC___024root__trace_cleanup\n"); );
    // Init
    VNPC___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<VNPC___024root*>(voidSelf);
    VNPC__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    vlSymsp->__Vm_activity = false;
    vlSymsp->TOP.__Vm_traceActivity[0U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[1U] = 0U;
}
