# Adding system calls

Four new calls, and the bookkeeping that lets the kernel report on how it is
being called.

| call | what it does |
| --- | --- |
| `find_next_prime_number(n)` | the first prime above n, computed in the kernel |
| `wait_for_process(pid)` | block until a specific child exits, rather than any child |
| `get_call_count(pid, syscall)` | how many times a process has made one call |
| `get_most_caller(syscall)` | which process has made a call the most times |

The last two are the interesting pair. Counting requires a per-process tally
kept in `struct proc` and incremented in `syscall()`, on the one path every
call already goes through — which is the reason that path is the right place
for it and the wrappers are not.

`wait_for_process` differs from `wait` in what it sleeps on. `wait` wakes for
any child; this one checks the pid it was given and goes back to sleep
otherwise, so a parent waiting for one particular child is not woken by its
siblings.

## Adding a call, end to end

A system call in xv6 touches six files, and missing one gives a different
failure each time:

```
syscall.h    the number
syscall.c    the number to function table, and the extern declaration
sysproc.c    the kernel-side function, which reads its arguments off the stack
usys.S       the user-side stub that traps
user.h       the declaration user programs see
Makefile     the new user programs to build into the image
```

## Files

`proc.c` `proc.h` `syscall.c` `syscall.h` `sysproc.c` `defs.h` `user.h`
`usys.S` `console.c` `init.c` `usertests.c` `Makefile`, and the user programs
`find_next_prime_number_interface.c` `get_call_count.c` `get_most_caller.c`
`getpid_gdb.c` `wait_for_process_test.c` `sort_string.c`
