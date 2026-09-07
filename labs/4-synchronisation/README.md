# Semaphores in the kernel

Counting semaphores, a reentrant mutex, and a producer-consumer program that
uses them.

## System calls

| call | |
| --- | --- |
| `sem_init(i, value)` | set semaphore i to a starting count |
| `sem_acquire(i)` | take one, sleeping while the count is zero |
| `sem_release(i)` | give one back and wake a waiter |
| `reentrant_mutex(i)` | a lock the holder may take again without deadlocking |

The semaphores live in the kernel, in a fixed array, so processes that share
nothing else can still synchronise through them: the index is the whole
identity, and both parties agree on it in advance.

## The reentrant one

A plain mutex taken twice by the same process deadlocks: the second acquire
waits for a release that only the blocked process can issue. A reentrant mutex
records who holds it and how deep, lets that holder pass straight through, and
only frees it when the depth returns to zero. Recursive routines that lock on
entry need this, and finding out they need it usually means finding out the
hard way.

## Producer and consumer

`producer_consumer.c` runs the classic pair over a five-slot ring with three
semaphores:

| semaphore | starts at | means |
| --- | --- | --- |
| `EMPTY` | 5 | slots free to write into |
| `FULL` | 0 | slots holding something to read |
| `MUTEX` | 1 | one process in the buffer at a time |

The producer takes `EMPTY` then `MUTEX`; the consumer takes `FULL` then
`MUTEX`. Both take the counting semaphore before the mutex, and the order is
not incidental: a process holding the mutex while it waits for a slot is
holding the lock the other process needs to make that slot appear.

`FULL` starts at zero because nothing has been written yet. Starting it at the
buffer size — the same value as `EMPTY`, which is the easy mistake — lets the
consumer take five slots before the producer has filled any of them, and it
reads whatever was in the buffer to begin with.

## Files

`proc.c` `syscall.c` `syscall.h` `sysproc.c` `defs.h` `user.h` `usys.S`
`console.c` `init.c` `usertests.c` `Makefile`, and the user programs
`producer_consumer.c` `reentrant_mutex.c` `sem_init.c` `sem_acquire.c`
`sem_release.c` `sort_string.c`
