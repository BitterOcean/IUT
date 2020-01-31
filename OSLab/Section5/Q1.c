#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <time.h>
#include <signal.h>
#include <string.h>
#define MAXCHILD 5
#define MAXIMUM 100

int main()	
{
	pid_t childPid[MAXCHILD];
	int fd[MAXCHILD][2];
	char num[3];
	int i,j;
	int total=0,valid=1;

	for (i=0;i<MAXCHILD;i++)
	{
		pipe(fd[i]);
		childPid[i]=fork();
		if(!childPid[i])
			break;
	}
	if(!childPid[i])//in child
	{
		close(fd[i][0]);//close read_descriptor
		srand(time(NULL));
		while(1)
		{
			sprintf(num,"%d",rand()%10);
			write(fd[i][1],num,strlen(num));
			sleep(1);// t=1
		}
	}
	else//in parent
	{

		for(j=0;j<MAXCHILD;j++)
			close(fd[j][1]);
		while(valid)
		{
			for(j=0;j<MAXCHILD;j++)
				if(read(fd[j][0],num,3)>0)
				{
					total+=atoi(num);
					if(total>MAXIMUM)
						valid=0;
					else
						printf("Total=%d\n",total);
				}			
		}
		kill(0,SIGKILL);
	}	
}
