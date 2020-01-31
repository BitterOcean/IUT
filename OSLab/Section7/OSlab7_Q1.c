/*
this program initializes a signal action
assigns a handler to this action and waits for SIGINT (ctrl+c) to be handled
*/
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <signal.h>
#define MAX_TRY 3
int counter=0;
// "handler1" is handler function for action1
void handler1(int signo)
{
  switch(signo)
  {
    case SIGINT:
      counter++;
      printf("\t Signal has received %d time\n", counter);
    break;
  }
}

int main()
{
  //initializing sigaction structure
  struct sigaction action1;
  action1.sa_handler = handler1;
  action1.sa_flags = 0;
  sigaction(SIGINT,(struct sigaction *) &action1,NULL);
  //runnign forever, while process is sensitive to SIGINT
  while(counter!=MAX_TRY);
  return 0;
}
