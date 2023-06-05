// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VNPC.h for the primary calling header

#include "verilated.h"

#include "VNPC__Syms.h"
#include "VNPC___024root.h"

void VNPC___024root___eval_act(VNPC___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VNPC__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VNPC___024root___eval_act\n"); );
}

VL_INLINE_OPT void VNPC___024root___nba_sequent__TOP__0(VNPC___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VNPC__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VNPC___024root___nba_sequent__TOP__0\n"); );
    // Init
    CData/*4:0*/ __Vdlyvdim0__NPC__DOT__R__v0;
    __Vdlyvdim0__NPC__DOT__R__v0 = 0;
    IData/*31:0*/ __Vdlyvval__NPC__DOT__R__v0;
    __Vdlyvval__NPC__DOT__R__v0 = 0;
    CData/*0:0*/ __Vdlyvset__NPC__DOT__R__v0;
    __Vdlyvset__NPC__DOT__R__v0 = 0;
    CData/*4:0*/ __Vdlyvdim0__NPC__DOT__R__v1;
    __Vdlyvdim0__NPC__DOT__R__v1 = 0;
    IData/*31:0*/ __Vdlyvval__NPC__DOT__R__v1;
    __Vdlyvval__NPC__DOT__R__v1 = 0;
    CData/*0:0*/ __Vdlyvset__NPC__DOT__R__v1;
    __Vdlyvset__NPC__DOT__R__v1 = 0;
    // Body
    if (VL_UNLIKELY((((0x100073U == vlSelf->NPC__DOT__M_MPORT_data) 
                      & (0U == vlSelf->NPC__DOT__rs1Val)) 
                     & (~ (IData)(vlSelf->reset))))) {
        VL_FWRITEF(0x80000002U,"%c",8,((0U == ((0x100073U 
                                                == vlSelf->NPC__DOT__M_MPORT_data)
                                                ? 0xbU
                                                : 0U))
                                        ? 0U : (0xffU 
                                                & vlSelf->NPC__DOT__R
                                                [((0x100073U 
                                                   == vlSelf->NPC__DOT__M_MPORT_data)
                                                   ? 0xbU
                                                   : 0U)])));
    }
    __Vdlyvset__NPC__DOT__R__v0 = 0U;
    __Vdlyvset__NPC__DOT__R__v1 = 0U;
    if ((IData)((0x13U == (0x707fU & vlSelf->NPC__DOT__M_MPORT_data)))) {
        __Vdlyvval__NPC__DOT__R__v0 = (vlSelf->NPC__DOT__rs1Val 
                                       + ((((vlSelf->NPC__DOT__M_MPORT_data 
                                             >> 0x1fU)
                                             ? 0xfffffU
                                             : 0U) 
                                           << 0xcU) 
                                          | (vlSelf->NPC__DOT__M_MPORT_data 
                                             >> 0x14U)));
        __Vdlyvset__NPC__DOT__R__v0 = 1U;
        __Vdlyvdim0__NPC__DOT__R__v0 = (0x1fU & (vlSelf->NPC__DOT__M_MPORT_data 
                                                 >> 7U));
    }
    if ((0x6fU == (0x7fU & vlSelf->NPC__DOT__M_MPORT_data))) {
        __Vdlyvval__NPC__DOT__R__v1 = ((IData)(4U) 
                                       + vlSelf->NPC__DOT__PC);
        __Vdlyvset__NPC__DOT__R__v1 = 1U;
        __Vdlyvdim0__NPC__DOT__R__v1 = (0x1fU & (vlSelf->NPC__DOT__M_MPORT_data 
                                                 >> 7U));
    }
    if (__Vdlyvset__NPC__DOT__R__v0) {
        vlSelf->NPC__DOT__R[__Vdlyvdim0__NPC__DOT__R__v0] 
            = __Vdlyvval__NPC__DOT__R__v0;
    }
    if (__Vdlyvset__NPC__DOT__R__v1) {
        vlSelf->NPC__DOT__R[__Vdlyvdim0__NPC__DOT__R__v1] 
            = __Vdlyvval__NPC__DOT__R__v1;
    }
    vlSelf->NPC__DOT__PC = ((IData)(vlSelf->reset) ? 0U
                             : vlSelf->NPC__DOT__R_MPORT_4_data);
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

void VNPC___024root___eval_nba(VNPC___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VNPC__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VNPC___024root___eval_nba\n"); );
    // Body
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        VNPC___024root___nba_sequent__TOP__0(vlSelf);
        vlSelf->__Vm_traceActivity[1U] = 1U;
    }
}

void VNPC___024root___eval_triggers__act(VNPC___024root* vlSelf);
#ifdef VL_DEBUG
VL_ATTR_COLD void VNPC___024root___dump_triggers__act(VNPC___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void VNPC___024root___dump_triggers__nba(VNPC___024root* vlSelf);
#endif  // VL_DEBUG

void VNPC___024root___eval(VNPC___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VNPC__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VNPC___024root___eval\n"); );
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
            VNPC___024root___eval_triggers__act(vlSelf);
            if (vlSelf->__VactTriggered.any()) {
                vlSelf->__VactContinue = 1U;
                if (VL_UNLIKELY((0x64U < vlSelf->__VactIterCount))) {
#ifdef VL_DEBUG
                    VNPC___024root___dump_triggers__act(vlSelf);
#endif
                    VL_FATAL_MT("NPC.v", 1, "", "Active region did not converge.");
                }
                vlSelf->__VactIterCount = ((IData)(1U) 
                                           + vlSelf->__VactIterCount);
                __VpreTriggered.andNot(vlSelf->__VactTriggered, vlSelf->__VnbaTriggered);
                vlSelf->__VnbaTriggered.thisOr(vlSelf->__VactTriggered);
                VNPC___024root___eval_act(vlSelf);
            }
        }
        if (vlSelf->__VnbaTriggered.any()) {
            __VnbaContinue = 1U;
            if (VL_UNLIKELY((0x64U < __VnbaIterCount))) {
#ifdef VL_DEBUG
                VNPC___024root___dump_triggers__nba(vlSelf);
#endif
                VL_FATAL_MT("NPC.v", 1, "", "NBA region did not converge.");
            }
            __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
            VNPC___024root___eval_nba(vlSelf);
        }
    }
}

#ifdef VL_DEBUG
void VNPC___024root___eval_debug_assertions(VNPC___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VNPC__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VNPC___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->clock & 0xfeU))) {
        Verilated::overWidthError("clock");}
    if (VL_UNLIKELY((vlSelf->reset & 0xfeU))) {
        Verilated::overWidthError("reset");}
}
#endif  // VL_DEBUG
