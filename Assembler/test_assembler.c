#include "stdio.h"
#include "string.h"
#include "assembler.c"
#include "stdlib.h"

int main() {
    char* aCode;
    unsigned int result;
    aCode = "assembly_code";
    assembler(aCode);
    return 0;
}