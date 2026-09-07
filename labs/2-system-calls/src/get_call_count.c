#include "types.h"
#include "user.h"
#include "syscall.h"

int
main(int argc, char *argv[])
{
  if (fork() == 0) {
    printf(1, "child fork count %d\n", get_call_count(SYS_fork));
    printf(1, "child write count %d\n", get_call_count(SYS_write));
	printf(1, "child get_call_count count %d\n", get_call_count(SYS_get_call_count));
  } else {
    wait();
    printf(1, "parent fork count %d\n", get_call_count(SYS_fork));
    printf(1, "parent write count %d\n", get_call_count(SYS_write));
	printf(1, "parent get_call_count count %d\n", get_call_count(SYS_get_call_count));
  }
  printf(1, "wait count %d\n", get_call_count(SYS_wait));
  exit();
}
