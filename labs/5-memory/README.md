# Page protection

Two system calls that let a process make part of its own address space
read-only, and take it back.

| call | |
| --- | --- |
| `mprotect(addr, len)` | clear the writable bit on `len` pages from `addr` |
| `munprotect(addr, len)` | set it again |

Both refuse anything that is not a page-aligned address inside the process's
own address space, before touching a single page table entry. Rejecting the
whole request first matters: a loop that validates as it goes leaves half the
range protected when it finds the bad page, and the caller has no way to know
how far it got.

## What it touches

The work is in `walkpgdir`, which follows a virtual address down the two-level
page table to the entry that maps it. Clearing `PTE_W` there makes the next
write to that page fault. The page table is the one the
hardware is walking right now, and the processor caches translations, so both
calls reload `cr3` before returning rather than leaving the change to take
effect at the next context switch.

`protection_test.c` shows that protection belongs to an address space rather
than to a page of memory. It protects a page, forks, and the two processes then
disagree about it: the child unprotects its own copy and writes successfully,
while the parent — whose copy is still protected — writes and is killed by the
trap. `testnull.c` dereferences a null pointer, which faults for a different
reason: xv6 leaves the first page unmapped precisely so that it does.

## Also here

This lab builds on the scheduler from lab 3, so the queues, the best-job-first
rank and `ps` are present here too.

## Files

`vm.c` `exec.c` `proc.c` `proc.h` `spinlock.c` `spinlock.h` `syscall.c`
`syscall.h` `sysproc.c` `defs.h` `user.h` `usys.S` `console.c` `usertests.c`
`Makefile`, and the user programs `protection_test.c` `testnull.c` `ps.c`
`set_queue.c` `set_bjf.c` `set_all_bjf.c` `set_priority.c` `rwtest.c` `foo.c`
`strdiff.c`
