/*
making a pipe between parent and child and sending messages from parent to child
*/
#include <unistd.h>
#include <sys/types.h>
#include <stdio.h>
#include <sys/stat.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>

int main(){
  int pipe, inChild;
  int tmp;
  char path[20];
  sprintf(path,"/home/maryam/1.pipe");
  printf("%s\n",path);

  //making the named-pipe
  mkfifo(path,0777);

  char buffer[256];
  bzero(buffer,256);
  pid_t pid;
  pid=fork();
  inChild=0;
  if (pid==0)
    inChild=1;
  while(inChild==1)
  {
    /*
    operations on named-pipe are similar to a file
    we open the named-pipe
    */
    pipe=open(path,O_RDONLY|O_NONBLOCK);
    read(pipe,buffer,255);
    printf("child <- %s\n",buffer);
    bzero(buffer,256);
    sleep(1);
  }
  tmp=0;
  pipe=open(path,O_WRONLY);
  while(inChild==0)
  {
    sprintf(buffer,"%d",tmp);
    tmp++;
    printf("parent -> %s", buffer);
    write(pipe,buffer,strlen(buffer));
    sleep(1);
  }
  return 0;
}
