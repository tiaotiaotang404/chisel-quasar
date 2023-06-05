// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VYEMU__SYMS_H_
#define VERILATED_VYEMU__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "VYEMU.h"

// INCLUDE MODULE CLASSES
#include "VYEMU___024root.h"

// SYMS CLASS (contains all model state)
class VYEMU__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    VYEMU* const __Vm_modelp;
    VlDeleter __Vm_deleter;
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    VYEMU___024root                TOP;

    // SCOPE NAMES
    VerilatedScope __Vscope_YEMU;

    // CONSTRUCTORS
    VYEMU__Syms(VerilatedContext* contextp, const char* namep, VYEMU* modelp);
    ~VYEMU__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

#endif  // guard
