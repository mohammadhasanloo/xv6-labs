#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"


#define FULL 1
#define EMPTY 0
#define MUTEX 2

#define BUFF_SIZE 5
#define ITER_NUM 20

int buf[BUFF_SIZE];
int w_index = 0;
int r_index = 0;


void
producer()
{

  for(int i = 1; i<ITER_NUM + 1; i++) {
    sem_acquire(EMPTY);
    sem_acquire(MUTEX);

    printf(1, "Producer writes %d in %d\n", i, w_index % BUFF_SIZE);

    sem_release(MUTEX);
    sem_release(FULL);
    w_index++;
  }
}

void
consumer()
{
  for(int i = 1; i<ITER_NUM + 1; i++) {
    sem_acquire(FULL);
    sem_acquire(MUTEX);

    printf(1, "Consumer writes %d in %d\n", i, r_index % BUFF_SIZE);

    sem_release(MUTEX);
    sem_release(EMPTY);
    r_index++;
  }
}

int
main(int argc, char *argv[])
{
  sem_init(MUTEX, 1);
  sem_init(FULL, BUFF_SIZE);
  sem_init(EMPTY, BUFF_SIZE);

  if (fork() == 0) producer();
  else consumer();

  wait();

  exit();
}