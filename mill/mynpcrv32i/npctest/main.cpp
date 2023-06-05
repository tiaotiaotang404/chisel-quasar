#include <stdio.h>
#include "obj_dir/VNPC.h"
#include "VNPC___024root.h"
#include "VNPC__Syms.h"
static VNPC *top = NULL;

void step()
{
    top->clock = 0;
    top->eval();
    top->clock = 1;
    top->eval();
}
void reset(int n)
{
    top->reset = 1;
    while (n--)
    {
        step();
    }
    top->reset = 0;
}
void load_prog(const char *bin)
{
    FILE *fp = fopen(bin, "r");
    fread(&top->rootp->NPC__DOT__M, 1, 1024, fp);
    fclose(fp);
}

int main(int argc, char *argv[])
{
    top = new VNPC;
    load_prog(argv[1]);
    reset(10);
    while (!top->io_halt)
    {
        step();
    }
    return 0;
}
