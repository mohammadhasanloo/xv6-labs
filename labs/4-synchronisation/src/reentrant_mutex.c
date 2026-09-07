#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char *argv[])
{
    int count = atoi(argv[1]);


    printf(1, "acquire() count: %d\n", count);
    reentrant_mutex(count);
    exit();
}