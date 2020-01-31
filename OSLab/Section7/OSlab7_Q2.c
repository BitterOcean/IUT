/*
this program initializes 2 signal actions, assigns same handler to both actions.
while action1 is handled, SIGUSR2 will be blocked on delivery.
*/
#include <stdlib.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <time.h>
#include <wait.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <signal.h>
#define MAXCHILD 5
#define MAXIMUM 100
int total=0;
char path[20];
pid_t pid[MAXCHILD];

// "handler1" is handler function for action1 and action2, returns void
void handler1(int signo)
{
  int pipe;
  char buffer[20];
  switch(signo)
  {
    /* handling SIGUSR1 takes one second
    during this time if SIGUSR2 will be blocked on delivery. */
    case SIGUSR1:
      pipe=open(path,O_RDWR);
      read(pipe,buffer,20);
      total += atoi(buffer);
      if(total >= MAXIMUM)
        {
          for (int i=0;i<MAXCHILD;i++)
          {
            kill(pid[i],SIGKILL);
            printf("child %d killed \n", i);
          }
          printf("program has finished successfully \n");
          exit(0);
        }
      printf("SIGUSR1 received and total is : %d \n", total);
      break;
  }
}

int main()
{
  int pipe;
  //initializing sigaction structures, action1 and action2 both use handler1
  struct sigaction action1;
  sigset_t set1;
  sigemptyset(&set1);
  //define signal set named "set1"
  //making set1 empty
  //adding SIGUSR2 to set1
  action1.sa_handler = handler1;
  action1.sa_mask = set1;
  //set1 includes SIGUSR2, it means if during handling action1
  //SIGUSR2 will be blocked on delivery.
  action1.sa_flags = 0;
  int inchild=0;
  //initializng parent process before fork()
  sigaction(SIGUSR1,(struct sigaction *) &action1,NULL);
  pid_t parent=getpid();
  sprintf(path,"Question2");
  mkfifo(path,0777);
  for ( int i=0;i<MAXCHILD;i++)
  {
  	pid[i]=fork();
  	if(pid[i]==0)
    {
      inchild=1;
  		break;
    }
  }

  srand(time(NULL));
  while(inchild)
  {
    //child sends SIGUSR1 and immediately SIGUSR2 to parent every one second
    pipe = open(path,O_RDWR);
    int t = rand()%10;
    sleep(t);
    char buf[20];
    sprintf(buf,"%d",t);
    write(pipe,buf,20);
    kill(parent,SIGUSR1);
  }
  
  while(inchild==0);
  return 0;
}
