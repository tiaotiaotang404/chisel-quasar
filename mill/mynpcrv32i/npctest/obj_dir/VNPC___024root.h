// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See VNPC.h for the primary calling header

#ifndef VERILATED_VNPC___024ROOT_H_
#define VERILATED_VNPC___024ROOT_H_  // guard

#include "verilated.h"

class VNPC__Syms;

class VNPC___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    VL_IN8(clock,0,0);
    VL_IN8(reset,0,0);
    VL_OUT8(io_halt,0,0);
    CData/*4:0*/ NPC__DOT__R_MPORT_1_addr;
    CData/*0:0*/ __Vtrigprevexpr___TOP__clock__0;
    CData/*0:0*/ __VactContinue;
    IData/*31:0*/ NPC__DOT__R_MPORT_4_data;
    IData/*31:0*/ NPC__DOT__M_MPORT_data;
    IData/*31:0*/ NPC__DOT__PC;
    IData/*31:0*/ NPC__DOT__rs1Val;
    IData/*31:0*/ __VstlIterCount;
    IData/*31:0*/ __VactIterCount;
    VlUnpacked<IData/*31:0*/, 32> NPC__DOT__R;
    VlUnpacked<IData/*31:0*/, 256> NPC__DOT__M;
    VlUnpacked<CData/*0:0*/, 2> __Vm_traceActivity;
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<1> __VactTriggered;
    VlTriggerVec<1> __VnbaTriggered;

    // INTERNAL VARIABLES
    VNPC__Syms* const vlSymsp;

    // CONSTRUCTORS
    VNPC___024root(VNPC__Syms* symsp, const char* v__name);
    ~VNPC___024root();
    VL_UNCOPYABLE(VNPC___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);


#endif  // guard
