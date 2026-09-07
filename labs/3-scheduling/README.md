# Multilevel scheduling

xv6 schedules round robin over every runnable process. This lab replaces that
with three queues, each with its own discipline, and a system call to move a
process between them.

| queue | discipline |
| --- | --- |
| 1 | round robin |
| 2 | first come, first served |
| 3 | best job first |

The scheduler tries the queues in order and takes the first process it finds,
so a process in queue 1 always runs before one in queue 3. Round robin is the
default a process is created in.

## Best job first

Queue 3 orders by a rank, and the lowest rank wins:

```
rank = priority x priority_ratio
     + creation_time x arrival_time_ratio
     + executed_cycle x executed_cycle_ratio
```

The three ratios are per-process and settable, which is what makes the queue
useful for experimenting: setting `executed_cycle_ratio` high approximates
shortest-remaining-time, setting `arrival_time_ratio` high approximates first
come first served, and the mixture in between is the point of the exercise.

`priority` is seeded randomly between 1 and 1000 at creation, so two processes
that arrive together and have run for the same time still have an order.

## Starvation

A process at the back of queue 3 behind a stream of arrivals in queue 1 never
runs. `wait_cycles` counts how long a process has been runnable without being
picked, and is reset when it runs, so ageing can act on it.

## System calls

| call | |
| --- | --- |
| `set_queue(pid, queue)` | move a process between queues |
| `set_bjf_params(pid, ...)` | the three ratios for one process |
| `set_all_bjf_params(...)` | the three ratios for every process |
| `print_processes_info()` | the scheduler's view of every process |

`ps.c` prints that view: pid, state, queue, the three ratios, the rank each
process would be given, and how many cycles it has waited.

## Files

`proc.c` `proc.h` `spinlock.c` `spinlock.h` `syscall.c` `syscall.h` `sysproc.c`
`vm.c` `defs.h` `user.h` `usys.S` `console.c` `usertests.c` `Makefile`, and the
user programs `ps.c` `set_queue.c` `set_bjf.c` `set_all_bjf.c` `set_priority.c`
`rwtest.c` `foo.c` `strdiff.c`
