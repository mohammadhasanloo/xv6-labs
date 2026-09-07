#include "types.h"
#include "stat.h"
#include "user.h"
#include "syscall.h"


int main(void) 
{
    printf(1, "pid of the most caller(wait): %d\n", get_most_caller(SYS_wait));
    printf(1, "pid of the most caller(fork): %d\n", get_most_caller(SYS_fork));
    printf(1, "pid of the most caller(wrtie): %d\n", get_most_caller(SYS_write));

    exit();
} 