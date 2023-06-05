// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VYEMU.h for the primary calling header

#include "verilated.h"

#include "VYEMU__Syms.h"
#include "VYEMU___024root.h"

VL_ATTR_COLD void VYEMU___024root___eval_static(VYEMU___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VYEMU__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VYEMU___024root___eval_static\n"); );
}

VL_ATTR_COLD void VYEMU___024root___eval_initial(VYEMU___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VYEMU__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VYEMU___024root___eval_initial\n"); );
    // Body
    vlSelf->__Vtrigprevexpr___TOP__clock__0 = vlSelf->clock;
}

VL_ATTR_COLD void VYEMU___024root___eval_final(VYEMU___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VYEMU__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VYEMU___024root___eval_final\n"); );
}

VL_ATTR_COLD void VYEMU___024root___eval_triggers__stl(VYEMU___024root* vlSelf);
#ifdef VL_DEBUG
VL_ATTR_COLD void VYEMU___024root___dump_triggers__stl(VYEMU___024root* vlSelf);
#endif  // VL_DEBUG
VL_ATTR_COLD void VYEMU___024root___eval_stl(VYEMU___024root* vlSelf);

VL_ATTR_COLD void VYEMU___024root___eval_settle(VYEMU___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VYEMU__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VYEMU___024root___eval_settle\n"); );
    // Init
    CData/*0:0*/ __VstlContinue;
    // Body
    vlSelf->__VstlIterCount = 0U;
    __VstlContinue = 1U;
    while (__VstlContinue) {
        __VstlContinue = 0U;
        VYEMU___024root___eval_triggers__stl(vlSelf);
        if (vlSelf->__VstlTriggered.any()) {
            __VstlContinue = 1U;
            if (VL_UNLIKELY((0x64U < vlSelf->__VstlIterCount))) {
#ifdef VL_DEBUG
                VYEMU___024root___dump_triggers__stl(vlSelf);
#endif
                VL_FATAL_MT("YEMU.v", 1, "", "Settle region did not converge.");
            }
            vlSelf->__VstlIterCount = ((IData)(1U) 
                                       + vlSelf->__VstlIterCount);
            VYEMU___024root___eval_stl(vlSelf);
        }
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void VYEMU___024root___dump_triggers__stl(VYEMU___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VYEMU__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VYEMU___024root___dump_triggers__stl\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VstlTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VstlTriggered.word(0U))) {
        VL_DBG_MSGF("         'stl' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void VYEMU___024root___stl_sequent__TOP__0(VYEMU___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VYEMU__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VYEMU___024root___stl_sequent__TOP__0\n"); );
    // Init
    CData/*4:0*/ YEMU__DOT__R_MPORT_1_addr;
    YEMU__DOT__R_MPORT_1_addr = 0;
    // Body
    vlSelf->YEMU__DOT___T_33 = (4ULL + vlSelf->YEMU__DOT__PC);
    vlSelf->YEMU__DOT___T_9 = vlSelf->YEMU__DOT__M[
        (0xffU & (IData)((vlSelf->YEMU__DOT__PC >> 2U)))];
    YEMU__DOT__R_MPORT_1_addr = ((0x100073U == vlSelf->YEMU__DOT___T_9)
                                  ? 0xaU : (0x1fU & 
                                            (vlSelf->YEMU__DOT___T_9 
                                             >> 0xfU)));
    vlSelf->YEMU__DOT__rs1Val = ((0U == (IData)(YEMU__DOT__R_MPORT_1_addr))
                                  ? 0ULL : vlSelf->YEMU__DOT__R
                                 [YEMU__DOT__R_MPORT_1_addr]);
    vlSelf->io_halt = ((0x100073U == vlSelf->YEMU__DOT___T_9) 
                       & (1ULL == vlSelf->YEMU__DOT__rs1Val));
}

VL_ATTR_COLD void VYEMU___024root___eval_stl(VYEMU___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VYEMU__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VYEMU___024root___eval_stl\n"); );
    // Body
    if ((1ULL & vlSelf->__VstlTriggered.word(0U))) {
        VYEMU___024root___stl_sequent__TOP__0(vlSelf);
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void VYEMU___024root___dump_triggers__act(VYEMU___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VYEMU__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VYEMU___024root___dump_triggers__act\n"); );
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
VL_ATTR_COLD void VYEMU___024root___dump_triggers__nba(VYEMU___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VYEMU__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VYEMU___024root___dump_triggers__nba\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VnbaTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 0 is active: @(posedge clock)\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void VYEMU___024root___ctor_var_reset(VYEMU___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VYEMU__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VYEMU___024root___ctor_var_reset\n"); );
    // Body
    vlSelf->clock = VL_RAND_RESET_I(1);
    vlSelf->reset = VL_RAND_RESET_I(1);
    vlSelf->io_halt = VL_RAND_RESET_I(1);
    for (int __Vi0 = 0; __Vi0 < 32; ++__Vi0) {
        vlSelf->YEMU__DOT__R[__Vi0] = VL_RAND_RESET_Q(64);
    }
    for (int __Vi0 = 0; __Vi0 < 256; ++__Vi0) {
        vlSelf->YEMU__DOT__M[__Vi0] = VL_RAND_RESET_I(32);
    }
    vlSelf->YEMU__DOT__PC = VL_RAND_RESET_Q(64);
    vlSelf->YEMU__DOT___T_9 = VL_RAND_RESET_I(32);
    vlSelf->YEMU__DOT__rs1Val = VL_RAND_RESET_Q(64);
    vlSelf->YEMU__DOT___T_33 = VL_RAND_RESET_Q(64);
    vlSelf->__Vtrigprevexpr___TOP__clock__0 = VL_RAND_RESET_I(1);
}
