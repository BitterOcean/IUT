/*
making a pipe between parent and child, sending messages from parent to child
*/
#include <unistd.h>
#include <sys/types.h>
#include <stdio.h>
int main(){
  int fd[2];
  char buffer[256];
  int x=pipe(fd);
  printf("fd=%d\n",fd[0]);
  pid_t pid;
  pid=fork();
  if(pid==0) //in child
  {
    close(fd[1]); //**comment this line => in comment mode : process terminated
    //                                    => in uncomment mode : process won't hault even with ^c :||
    while(1)
    {
    printf("in child\n");
    if(read(fd[0],buffer,255)>0)
      printf("%s\n",buffer);
    else
      printf("pipe is not available\n");
    }
  }
  else// in parent
  {
    close(fd[0]);
    int i = 0;
    while(i<5)
    {
      printf("in parent\n");
      sprintf(buffer,"message %d to child", i++);
      write(fd[1],buffer,255);
      sleep(2);
    }
  }
return 0;
}
