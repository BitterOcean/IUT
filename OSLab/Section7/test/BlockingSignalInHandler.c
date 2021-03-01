/*
this program initializes 2 signal actions, assigns same handler to both actions.
while action1 is handled, SIGUSR2 will be blocked on delivery.
*/
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <signal.h>
#define MAXCHILD 1
// "handler1" is handler function for action1 and action2, returns void
void handler1(int signo)
{
  switch(signo)
  {
    /* handling SIGUSR1 takes one second
    during this time if SIGUSR2 will be blocked on delivery. */
    case SIGUSR1:
      sleep(1);
      printf("SIGUSR1 received \n");
      break;
    case SIGUSR2:
      printf("SIGUSR2 received \n");
      break;
  }
}

int main()
{
  //initializing sigaction structures, action1 and action2 both use handler1
  struct sigaction action1;
  struct sigaction action2;
  sigset_t set1;
  sigemptyset(&set1);
  sigset_t set2;
  sigemptyset(&set2);
  sigaddset(&set1, SIGUSR2);
  //define signal set named "set1"
  //making set1 empty
  //adding SIGUSR2 to set1
  action1.sa_handler = handler1;
  action1.sa_mask = set1;
  //set1 includes SIGUSR2, it means if during handling action1
  //SIGUSR2 will be blocked on delivery.
  action1.sa_flags = 0;
  //
  action2.sa_handler = handler1;
  action2.sa_mask = set2;
  //no signal has been blocked for action2
  action2.sa_flags = 0;
  int inchild=0;
  //initializng parent process before fork()
  sigaction(SIGUSR1,(struct sigaction *) &action1,NULL);
  sigaction(SIGUSR2,(struct sigaction *) &action2,NULL);
  pid_t parent=getpid();
  pid_t pid[MAXCHILD];
  for ( int i=0;i<MAXCHILD;i++)
  {
    pid[i]=fork();
    if( pid[i]==0)
    {
      inchild=1;
      break;
    }
  }
  while(inchild==0);
  while(inchild==1)
  {
    //child sends SIGUSR1 and immediately SIGUSR2 to parent every one second
    kill(parent,SIGUSR1);
    kill(parent,SIGUSR2);
    sleep(1);
  }
  return 0;
}
