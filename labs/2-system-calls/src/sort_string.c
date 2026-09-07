#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"




int
main(int argc, char *argv[])
{
  char* curr_string = argv[1];
  int stringLength = strlen(curr_string);
  char temp;

  for (int i = 0; i < stringLength - 1; i++) {
    for (int j = i + 1; j < stringLength; j++) {
      if (curr_string[i] > curr_string[j]) {
        temp = curr_string[i];
        curr_string[i] = curr_string[j];
        curr_string[j] = temp;
      }
    }
  }
  
  int fd;
  unlink("sort_string.txt");
  fd = open("sort_string.txt", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "Something went wrong in opening file\n");
  }
  write(fd, curr_string, stringLength);
  close(fd);
  
  exit();
}
