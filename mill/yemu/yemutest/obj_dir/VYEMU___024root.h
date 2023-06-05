// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See VYEMU.h for the primary calling header

#ifndef VERILATED_VYEMU___024ROOT_H_
#define VERILATED_VYEMU___024ROOT_H_  // guard

#include "verilated.h"

class VYEMU__Syms;

class VYEMU___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    VL_IN8(clock,0,0);
    VL_IN8(reset,0,0);
    VL_OUT8(io_halt,0,0);
    CData/*0:0*/ __Vtrigprevexpr___TOP__clock__0;
    CData/*0:0*/ __VactContinue;
    IData/*31:0*/ YEMU__DOT___T_9;
    IData/*31:0*/ __VstlIterCount;
    IData/*31:0*/ __VactIterCount;
    QData/*63:0*/ YEMU__DOT__PC;
    QData/*63:0*/ YEMU__DOT__rs1Val;
    QData/*63:0*/ YEMU__DOT___T_33;
    VlUnpacked<QData/*63:0*/, 32> YEMU__DOT__R;
    VlUnpacked<IData/*31:0*/, 256> YEMU__DOT__M;
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<1> __VactTriggered;
    VlTriggerVec<1> __VnbaTriggered;

    // INTERNAL VARIABLES
    VYEMU__Syms* const vlSymsp;

    // CONSTRUCTORS
    VYEMU___024root(VYEMU__Syms* symsp, const char* v__name);
    ~VYEMU___024root();
    VL_UNCOPYABLE(VYEMU___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);


#endif  // guard
