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

    buf[w_index % BUFF_SIZE] = i;
    printf(1, "producer wrote %d into slot %d\n", i, w_index % BUFF_SIZE);
    w_index++;

    sem_release(MUTEX);
    sem_release(FULL);
  }
}

void
consumer()
{
  for(int i = 1; i<ITER_NUM + 1; i++) {
    sem_acquire(FULL);
    sem_acquire(MUTEX);

    int value = buf[r_index % BUFF_SIZE];
    printf(1, "consumer read  %d from slot %d\n", value, r_index % BUFF_SIZE);
    r_index++;

    sem_release(MUTEX);
    sem_release(EMPTY);
  }
}

int
main(int argc, char *argv[])
{
  sem_init(MUTEX, 1);
  // FULL counts slots holding something to read, and nothing has been written
  // yet. Starting it at the buffer size lets the consumer take five slots
  // before the producer has filled any of them.
  sem_init(FULL, 0);
  sem_init(EMPTY, BUFF_SIZE);

  if (fork() == 0) producer();
  else consumer();

  wait();

  exit();
}