// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VYEMU.h for the primary calling header

#include "verilated.h"

#include "VYEMU__Syms.h"
#include "VYEMU__Syms.h"
#include "VYEMU___024root.h"

#ifdef VL_DEBUG
VL_ATTR_COLD void VYEMU___024root___dump_triggers__act(VYEMU___024root* vlSelf);
#endif  // VL_DEBUG

void VYEMU___024root___eval_triggers__act(VYEMU___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VYEMU__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VYEMU___024root___eval_triggers__act\n"); );
    // Body
    vlSelf->__VactTriggered.set(0U, ((IData)(vlSelf->clock) 
                                     & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__clock__0))));
    vlSelf->__Vtrigprevexpr___TOP__clock__0 = vlSelf->clock;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        VYEMU___024root___dump_triggers__act(vlSelf);
    }
#endif
}

VL_INLINE_OPT void VYEMU___024root___nba_sequent__TOP__0(VYEMU___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VYEMU__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VYEMU___024root___nba_sequent__TOP__0\n"); );
    // Init
    CData/*4:0*/ YEMU__DOT__R_MPORT_1_addr;
    YEMU__DOT__R_MPORT_1_addr = 0;
    CData/*4:0*/ __Vdlyvdim0__YEMU__DOT__R__v0;
    __Vdlyvdim0__YEMU__DOT__R__v0 = 0;
    QData/*63:0*/ __Vdlyvval__YEMU__DOT__R__v0;
    __Vdlyvval__YEMU__DOT__R__v0 = 0;
    CData/*0:0*/ __Vdlyvset__YEMU__DOT__R__v0;
    __Vdlyvset__YEMU__DOT__R__v0 = 0;
    // Body
    if (VL_UNLIKELY((1U & (~ (((IData)((0x13U == (0x707fU 
                                                  & vlSelf->YEMU__DOT___T_9))) 
                               | (0x100073U == vlSelf->YEMU__DOT___T_9)) 
                              | (IData)(vlSelf->reset)))))) {
        VL_FWRITEF(0x80000002U,"Assertion failed: Invalid instruction 0x%x\n    at Yemu.scala:23 assert(isAddi || isEbreak, \"Invalid instruction 0x%%x\", inst.asUInt)\n",
                   32,vlSelf->YEMU__DOT___T_9);
    }
    if (VL_UNLIKELY((1U & (~ (((IData)((0x13U == (0x707fU 
                                                  & vlSelf->YEMU__DOT___T_9))) 
                               | (0x100073U == vlSelf->YEMU__DOT___T_9)) 
                              | (IData)(vlSelf->reset)))))) {
        VL_WRITEF("[%0t] %%Fatal: YEMU.v:88: Assertion failed in %NYEMU\n",
                  64,VL_TIME_UNITED_Q(1),-12,vlSymsp->name());
        VL_STOP_MT("YEMU.v", 88, "");
    }
    if (VL_UNLIKELY((((0x100073U == vlSelf->YEMU__DOT___T_9) 
                      & (0ULL == vlSelf->YEMU__DOT__rs1Val)) 
                     & (~ (IData)(vlSelf->reset))))) {
        VL_FWRITEF(0x80000002U,"%c",8,(0xffU & (IData)(
                                                       ((0U 
                                                         == 
                                                         ((0x100073U 
                                                           == vlSelf->YEMU__DOT___T_9)
                                                           ? 0xbU
                                                           : 0U))
                                                         ? 0ULL
                                                         : 
                                                        vlSelf->YEMU__DOT__R
                                                        [
                                                        ((0x100073U 
                                                          == vlSelf->YEMU__DOT___T_9)
                                                          ? 0xbU
                                                          : 0U)]))));
    }
    __Vdlyvset__YEMU__DOT__R__v0 = 0U;
    if ((IData)((0x13U == (0x707fU & vlSelf->YEMU__DOT___T_9)))) {
        __Vdlyvval__YEMU__DOT__R__v0 = (vlSelf->YEMU__DOT__rs1Val 
                                        + ((((vlSelf->YEMU__DOT___T_9 
                                              >> 0x1fU)
                                              ? 0xfffffffffffffULL
                                              : 0ULL) 
                                            << 0xcU) 
                                           | (QData)((IData)(
                                                             (vlSelf->YEMU__DOT___T_9 
                                                              >> 0x14U)))));
        __Vdlyvset__YEMU__DOT__R__v0 = 1U;
        __Vdlyvdim0__YEMU__DOT__R__v0 = (0x1fU & (vlSelf->YEMU__DOT___T_9 
                                                  >> 7U));
    }
    vlSelf->YEMU__DOT__PC = ((IData)(vlSelf->reset)
                              ? 0ULL : vlSelf->YEMU__DOT___T_33);
    if (__Vdlyvset__YEMU__DOT__R__v0) {
        vlSelf->YEMU__DOT__R[__Vdlyvdim0__YEMU__DOT__R__v0] 
            = __Vdlyvval__YEMU__DOT__R__v0;
    }
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
