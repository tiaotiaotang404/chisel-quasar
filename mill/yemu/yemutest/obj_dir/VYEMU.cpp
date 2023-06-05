// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "VYEMU.h"
#include "VYEMU__Syms.h"

//============================================================
// Constructors

VYEMU::VYEMU(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new VYEMU__Syms(contextp(), _vcname__, this)}
    , clock{vlSymsp->TOP.clock}
    , reset{vlSymsp->TOP.reset}
    , io_halt{vlSymsp->TOP.io_halt}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

VYEMU::VYEMU(const char* _vcname__)
    : VYEMU(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

VYEMU::~VYEMU() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void VYEMU___024root___eval_debug_assertions(VYEMU___024root* vlSelf);
#endif  // VL_DEBUG
void VYEMU___024root___eval_static(VYEMU___024root* vlSelf);
void VYEMU___024root___eval_initial(VYEMU___024root* vlSelf);
void VYEMU___024root___eval_settle(VYEMU___024root* vlSelf);
void VYEMU___024root___eval(VYEMU___024root* vlSelf);

void VYEMU::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate VYEMU::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    VYEMU___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        VYEMU___024root___eval_static(&(vlSymsp->TOP));
        VYEMU___024root___eval_initial(&(vlSymsp->TOP));
        VYEMU___024root___eval_settle(&(vlSymsp->TOP));
    }
    // MTask 0 start
    VL_DEBUG_IF(VL_DBG_MSGF("MTask0 starting\n"););
    Verilated::mtaskId(0);
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    VYEMU___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfThreadMTask(vlSymsp->__Vm_evalMsgQp);
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

//============================================================
// Events and timing
bool VYEMU::eventsPending() { return false; }

uint64_t VYEMU::nextTimeSlot() {
    VL_FATAL_MT(__FILE__, __LINE__, "", "%Error: No delays in the design");
    return 0;
}

//============================================================
// Utilities

const char* VYEMU::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void VYEMU___024root___eval_final(VYEMU___024root* vlSelf);

VL_ATTR_COLD void VYEMU::final() {
    VYEMU___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* VYEMU::hierName() const { return vlSymsp->name(); }
const char* VYEMU::modelName() const { return "VYEMU"; }
unsigned VYEMU::threads() const { return 1; }
