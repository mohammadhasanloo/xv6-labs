#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "fcntl.h"

int main(int argc, char *argv[])
{
    int arg1;

    if(argc > 1) {
        arg1 = atoi(argv[1]);
    }
    else {
        printf(1, "Invalid inputs for sem_release\n");
        exit();
    }


    sem_release(arg1);

    exit();
}