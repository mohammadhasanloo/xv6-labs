#include "types.h"
#include "stat.h"
#include "user.h"
#include "syscall.h"

void wait_for_process_test(void) {
    int pid1, pid2;
    if((pid1 = fork())!=0) // Create a child
    {
        // We are in the parent
        if((pid2 = fork())!=0)
        {
            // We are in the parent
            wait();
            printf(1, "Second child has finished \n");
            printf(1, "Parent has been finished\n");
            exit();    
        }
        else
        {
            // We are in the 2nd child
            int termpid = wait_for_process(pid1);
		    if(termpid > 0){
			    printf(1, "First child has finished \n");
		    }         
		    exit();  

        }    
    }
    else
    {
        // We are in the 1st child
        for(int i=0;i<100000000;i++){
            if(i== 9000){
                printf(1, "Wait %d iterations for first child\n", i);
            }
            else if(i== 900000){
                printf(1, "Wait %d iterations for first child\n", i);
            }
            else if(i== 9000000){
                printf(1, "Wait %d iterations for first child\n", i);
            }
            else if(i== 90000000){
                printf(1, "Wait %d iterations for first child\n", i);
            }                        
        }
        exit();     
    }
}

int
main(int argc, char *argv[])
{
	printf(1, "Testing wait_for_process function\n");
	wait_for_process_test();
	
	exit();
}