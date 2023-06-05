// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VNPC.h for the primary calling header

#include "verilated.h"

#include "VNPC__Syms.h"
#include "VNPC___024root.h"

VL_ATTR_COLD void VNPC___024root___eval_static(VNPC___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VNPC__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VNPC___024root___eval_static\n"); );
}

VL_ATTR_COLD void VNPC___024root___eval_initial(VNPC___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VNPC__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VNPC___024root___eval_initial\n"); );
    // Body
    vlSelf->__Vtrigprevexpr___TOP__clock__0 = vlSelf->clock;
}

VL_ATTR_COLD void VNPC___024root___eval_final(VNPC___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VNPC__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VNPC___024root___eval_final\n"); );
}

VL_ATTR_COLD void VNPC___024root___eval_triggers__stl(VNPC___024root* vlSelf);
#ifdef VL_DEBUG
VL_ATTR_COLD void VNPC___024root___dump_triggers__stl(VNPC___024root* vlSelf);
#endif  // VL_DEBUG
VL_ATTR_COLD void VNPC___024root___eval_stl(VNPC___024root* vlSelf);

VL_ATTR_COLD void VNPC___024root___eval_settle(VNPC___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VNPC__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VNPC___024root___eval_settle\n"); );
    // Init
    CData/*0:0*/ __VstlContinue;
    // Body
    vlSelf->__VstlIterCount = 0U;
    __VstlContinue = 1U;
    while (__VstlContinue) {
        __VstlContinue = 0U;
        VNPC___024root___eval_triggers__stl(vlSelf);
        if (vlSelf->__VstlTriggered.any()) {
            __VstlContinue = 1U;
            if (VL_UNLIKELY((0x64U < vlSelf->__VstlIterCount))) {
#ifdef VL_DEBUG
                VNPC___024root___dump_triggers__stl(vlSelf);
#endif
                VL_FATAL_MT("NPC.v", 1, "", "Settle region did not converge.");
            }
            vlSelf->__VstlIterCount = ((IData)(1U) 
                                       + vlSelf->__VstlIterCount);
            VNPC___024root___eval_stl(vlSelf);
        }
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void VNPC___024root___dump_triggers__stl(VNPC___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VNPC__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VNPC___024root___dump_triggers__stl\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VstlTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VstlTriggered.word(0U))) {
        VL_DBG_MSGF("         'stl' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void VNPC___024root___stl_sequent__TOP__0(VNPC___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VNPC__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VNPC___024root___stl_sequent__TOP__0\n"); );
    // Body
    vlSelf->NPC__DOT__R_MPORT_4_data = ((IData)(4U) 
                                        + vlSelf->NPC__DOT__PC);
    vlSelf->NPC__DOT__M_MPORT_data = vlSelf->NPC__DOT__M
        [(0xffU & vlSelf->NPC__DOT__PC)];
    vlSelf->NPC__DOT__R_MPORT_1_addr = ((0x100073U 
                                         == vlSelf->NPC__DOT__M_MPORT_data)
                                         ? 0xaU : (0x1fU 
                                                   & (vlSelf->NPC__DOT__M_MPORT_data 
                                                      >> 0xfU)));
    vlSelf->NPC__DOT__rs1Val = ((0U == (IData)(vlSelf->NPC__DOT__R_MPORT_1_addr))
                                 ? 0U : vlSelf->NPC__DOT__R
                                [vlSelf->NPC__DOT__R_MPORT_1_addr]);
    vlSelf->io_halt = ((0x100073U == vlSelf->NPC__DOT__M_MPORT_data) 
                       & (1U == vlSelf->NPC__DOT__rs1Val));
}

VL_ATTR_COLD void VNPC___024root___eval_stl(VNPC___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VNPC__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VNPC___024root___eval_stl\n"); );
    // Body
    if ((1ULL & vlSelf->__VstlTriggered.word(0U))) {
        VNPC___024root___stl_sequent__TOP__0(vlSelf);
        vlSelf->__Vm_traceActivity[1U] = 1U;
        vlSelf->__Vm_traceActivity[0U] = 1U;
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void VNPC___024root___dump_triggers__act(VNPC___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VNPC__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VNPC___024root___dump_triggers__act\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VactTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 0 is active: @(posedge clock)\n");
    }
}
#endif  // VL_DEBUG

#ifdef VL_DEBUG
VL_ATTR_COLD void VNPC___024root___dump_triggers__nba(VNPC___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VNPC__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VNPC___024root___dump_triggers__nba\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VnbaTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 0 is active: @(posedge clock)\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void VNPC___024root___ctor_var_reset(VNPC___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VNPC__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VNPC___024root___ctor_var_reset\n"); );
    // Body
    vlSelf->clock = VL_RAND_RESET_I(1);
    vlSelf->reset = VL_RAND_RESET_I(1);
    vlSelf->io_halt = VL_RAND_RESET_I(1);
    for (int __Vi0 = 0; __Vi0 < 32; ++__Vi0) {
        vlSelf->NPC__DOT__R[__Vi0] = VL_RAND_RESET_I(32);
    }
    vlSelf->NPC__DOT__R_MPORT_1_addr = VL_RAND_RESET_I(5);
    vlSelf->NPC__DOT__R_MPORT_4_data = VL_RAND_RESET_I(32);
    for (int __Vi0 = 0; __Vi0 < 256; ++__Vi0) {
        vlSelf->NPC__DOT__M[__Vi0] = VL_RAND_RESET_I(32);
    }
    vlSelf->NPC__DOT__M_MPORT_data = VL_RAND_RESET_I(32);
    vlSelf->NPC__DOT__PC = VL_RAND_RESET_I(32);
    vlSelf->NPC__DOT__rs1Val = VL_RAND_RESET_I(32);
    vlSelf->__Vtrigprevexpr___TOP__clock__0 = VL_RAND_RESET_I(1);
    for (int __Vi0 = 0; __Vi0 < 2; ++__Vi0) {
        vlSelf->__Vm_traceActivity[__Vi0] = 0;
    }
}
