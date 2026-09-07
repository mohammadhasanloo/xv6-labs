# Command history in the console

The kernel console reads a line at a time into a fixed buffer and offers no way
back to what was typed before. This lab adds one.

## What changed

`console.c` keeps the last 20 completed lines in a ring buffer and interprets
four escape sequences the keyboard driver did not previously decode:

| key | effect |
| --- | --- |
| up | recall the previous line |
| down | recall the next one, ending at the line being typed |
| left, right | move the cursor inside the current line |

Moving the cursor is the part that costs work: the console buffer is written
and echoed in one pass, so inserting a character in the middle of a line means
shifting the tail of the buffer and repainting the row. `shiftbufleft`,
`shiftbufright` and `copyCharsToBeMoved` do that.

A line being edited is saved before the first recall and restored when the user
comes back down past the newest entry, so pressing up out of curiosity does not
lose what was half typed.

`history(char *buffer, int index)` exposes the ring to user space.

## Also here

`sort_string.c`, a user program that sorts the characters of its argument,
added so the shell has something new to run.

## Files

`console.c` `init.c` `usertests.c` `Makefile` `sort_string.c`
