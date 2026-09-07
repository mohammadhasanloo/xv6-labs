# xv6 Labs

Five sets of changes to the xv6 teaching kernel: console editing, new system
calls, a multilevel scheduler, semaphores, and page protection.

| lab | |
| --- | --- |
| [1 — boot and debug](labs/1-boot-and-debug) | command history and cursor movement in the console |
| [2 — system calls](labs/2-system-calls) | four new calls, and per-process call counting |
| [3 — scheduling](labs/3-scheduling) | three queues: round robin, first come first served, best job first |
| [4 — synchronisation](labs/4-synchronisation) | counting semaphores and a reentrant mutex |
| [5 — memory](labs/5-memory) | `mprotect` and `munprotect` over the page table |

Each lab has its own README explaining what it changes and why.

## Layout

```
xv6/                     upstream xv6-public, unmodified
labs/<lab>/src/          only the files that lab changes or adds
labs/<lab>/changes.diff  those changes as a diff against xv6/
labs/<lab>/README.md     what it does
scripts/apply.sh         lay one lab over a copy of xv6
```

Each lab is kept as the files it touched rather than as a branch or a chain of
commits. They are alternative modifications of the same kernel, not a sequence
building on each other, and a reader who wants to know what lab 4 did should
not have to work out which of five copies of `proc.c` differs from which.
`changes.diff` answers that in one file per lab; `src/` holds the result.

The five directories the assignments were submitted as held five full copies of
xv6 plus their build output: 101 MB, of which 1.4 MB was written by hand.

## Building

```bash
brew install x86_64-elf-gcc x86_64-elf-binutils qemu   # or a distro equivalent

make labs                    # list them
make LAB=3-scheduling        # apply and build, into build/3-scheduling
```

All five labs compile and link, producing `xv6.img` and `fs.img`.

xv6 builds with `-Werror`, against a compiler that predates most of what a
current gcc warns about, so `EXTRA_CFLAGS` carries `-Wno-error`. That switch is
passed in from the repository Makefile rather than written into the kernel's,
so the vendored source stays as upstream published it.

**The images do not boot under QEMU when built with gcc 16.** The kernel
compiles and links, and then triple-faults into a reboot loop before printing
anything. xv6 targets a compiler roughly fifteen years older, and the labs were
developed against the one the course supplied; reproducing a running kernel
needs a toolchain of that vintage. What is verified here is that every lab
compiles and links cleanly against a current cross toolchain.

## Where the work is

```bash
wc -l labs/*/changes.diff
```

```
 608  labs/1-boot-and-debug/changes.diff
1114  labs/2-system-calls/changes.diff
1319  labs/3-scheduling/changes.diff
1088  labs/4-synchronisation/changes.diff
1562  labs/5-memory/changes.diff
```

Labs 3 and 5 share a kernel: the memory lab was built on top of the scheduler
lab, so its diff carries both.
