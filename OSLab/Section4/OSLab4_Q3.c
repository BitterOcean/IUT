#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/time.h> //gettimeofday
#include <time.h>     //time
#include <fcntl.h>
#include <wait.h>

int main(){
  int log = open("log.txt",O_CREAT|O_RDWR|O_APPEND,00777);
  char header[100];
  sprintf(header, "Date     time      Execution Time(ms)\n");
  write(log,header, strlen(header));

  while (1){
    struct timeval start,stop;
    int t;
    char **argVal;
    printf("\nEnter number of the args: ");
    scanf("%d",&t );
    printf("\nEnter the ARGs : ");
    for(int i=0;i<t;i++)
      scanf("%s", &argVal[i]);

    pid_t pid = fork();
    gettimeofday(&start,NULL);
    if(pid == 0)
      execl("./",argVal);

    else{
      wait(0);
      gettimeofday(&stop,NULL);
      long sec = stop.tv_sec - start.tv_sec;
      float m1 = start.tv_usec;
      float m2 = stop.tv_usec;
      long elapsed = sec*1000 + (m2-m1);

      time_t time1 = time(NULL);
      struct tm* ltime = localtime(&time1);
      char log_line[200];
      sprintf(log_line,"%d-%d-%d\t\t%d : %d\t\t%ld\n",ltime->tm_year+1900,ltime->tm_mon,ltime->tm_mday,ltime->tm_hour,ltime->tm_min,elapsed);
      write(log,log_line,strlen(log_line));
      }
      break;
    }

    close(log);
    return 0;
}
