// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VYEMU.h for the primary calling header

#include "verilated.h"

#include "VYEMU__Syms.h"
#include "VYEMU___024root.h"

void VYEMU___024root___eval_act(VYEMU___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VYEMU__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VYEMU___024root___eval_act\n"); );
}

void VYEMU___024root___nba_sequent__TOP__0(VYEMU___024root* vlSelf);

void VYEMU___024root___eval_nba(VYEMU___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VYEMU__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VYEMU___024root___eval_nba\n"); );
    // Body
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        VYEMU___024root___nba_sequent__TOP__0(vlSelf);
    }
}

void VYEMU___024root___eval_triggers__act(VYEMU___024root* vlSelf);
#ifdef VL_DEBUG
VL_ATTR_COLD void VYEMU___024root___dump_triggers__act(VYEMU___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void VYEMU___024root___dump_triggers__nba(VYEMU___024root* vlSelf);
#endif  // VL_DEBUG

void VYEMU___024root___eval(VYEMU___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VYEMU__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VYEMU___024root___eval\n"); );
    // Init
    VlTriggerVec<1> __VpreTriggered;
    IData/*31:0*/ __VnbaIterCount;
    CData/*0:0*/ __VnbaContinue;
    // Body
    __VnbaIterCount = 0U;
    __VnbaContinue = 1U;
    while (__VnbaContinue) {
        __VnbaContinue = 0U;
        vlSelf->__VnbaTriggered.clear();
        vlSelf->__VactIterCount = 0U;
        vlSelf->__VactContinue = 1U;
        while (vlSelf->__VactContinue) {
            vlSelf->__VactContinue = 0U;
            VYEMU___024root___eval_triggers__act(vlSelf);
            if (vlSelf->__VactTriggered.any()) {
                vlSelf->__VactContinue = 1U;
                if (VL_UNLIKELY((0x64U < vlSelf->__VactIterCount))) {
#ifdef VL_DEBUG
                    VYEMU___024root___dump_triggers__act(vlSelf);
#endif
                    VL_FATAL_MT("YEMU.v", 1, "", "Active region did not converge.");
                }
                vlSelf->__VactIterCount = ((IData)(1U) 
                                           + vlSelf->__VactIterCount);
                __VpreTriggered.andNot(vlSelf->__VactTriggered, vlSelf->__VnbaTriggered);
                vlSelf->__VnbaTriggered.thisOr(vlSelf->__VactTriggered);
                VYEMU___024root___eval_act(vlSelf);
            }
        }
        if (vlSelf->__VnbaTriggered.any()) {
            __VnbaContinue = 1U;
            if (VL_UNLIKELY((0x64U < __VnbaIterCount))) {
#ifdef VL_DEBUG
                VYEMU___024root___dump_triggers__nba(vlSelf);
#endif
                VL_FATAL_MT("YEMU.v", 1, "", "NBA region did not converge.");
            }
            __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
            VYEMU___024root___eval_nba(vlSelf);
        }
    }
}

#ifdef VL_DEBUG
void VYEMU___024root___eval_debug_assertions(VYEMU___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VYEMU__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VYEMU___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->clock & 0xfeU))) {
        Verilated::overWidthError("clock");}
    if (VL_UNLIKELY((vlSelf->reset & 0xfeU))) {
        Verilated::overWidthError("reset");}
}
#endif  // VL_DEBUG
