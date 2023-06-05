// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VYEMU.h for the primary calling header

#include "verilated.h"

#include "VYEMU__Syms.h"
#include "VYEMU__Syms.h"
#include "VYEMU___024root.h"

void VYEMU___024root___ctor_var_reset(VYEMU___024root* vlSelf);

VYEMU___024root::VYEMU___024root(VYEMU__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , vlSymsp{symsp}
 {
    // Reset structure values
    VYEMU___024root___ctor_var_reset(this);
}

void VYEMU___024root::__Vconfigure(bool first) {
    if (false && first) {}  // Prevent unused
}

VYEMU___024root::~VYEMU___024root() {
}
