// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VNPC.h for the primary calling header

#include "verilated.h"

#include "VNPC__Syms.h"
#include "VNPC__Syms.h"
#include "VNPC___024root.h"

void VNPC___024root___ctor_var_reset(VNPC___024root* vlSelf);

VNPC___024root::VNPC___024root(VNPC__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , vlSymsp{symsp}
 {
    // Reset structure values
    VNPC___024root___ctor_var_reset(this);
}

void VNPC___024root::__Vconfigure(bool first) {
    if (false && first) {}  // Prevent unused
}

VNPC___024root::~VNPC___024root() {
}
