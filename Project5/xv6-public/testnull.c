#include "syscall.h"
#include "types.h"
#include "user.h"

#define NULL 0
#define stdout 1
int main()
{
    printf(stdout, "Test program for null ptr \n");
    int *p = NULL;
    printf(1, "*p: %d \n",*p);
    exit();
}
