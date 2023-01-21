#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char *argv[])
{

        int saved_ebx, number = atoi(argv[1]);
        // we can add assembly instructions using asm
		asm volatile(
			"movl %%ebx, %0;"
			"movl %1, %%ebx;"
			: "=r" (saved_ebx)
			: "r"(number)
		);

		printf(1, "The next prime number is:  %d\n", find_next_prime_number());
		asm("movl %0, %%ebx" : : "r"(saved_ebx));
		exit();
}