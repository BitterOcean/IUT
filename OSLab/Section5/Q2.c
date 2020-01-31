#include <sys/types.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <time.h>
#include <wait.h>
#define MAXCHILD 5

int main()
{
	pid_t childPid[MAXCHILD];
	int pipe;
	char path[20],lastChild[256],ID[256];
	int i,child_id,status=0;
	sprintf(path,"Question2");
	mkfifo(path,0777);
	for(i=0;i<MAXCHILD;i++)
	{
		childPid[i]=fork();
		child_id=i;
		if(!childPid[i])// child should not fork!
			break;
	}
	if(!childPid[i])// in child
	{	
		printf("Child %d starts\n",child_id);
		pipe=open(path,O_RDWR);
		srand(time(NULL));
		sleep(rand()%10);// each child should executs t sec
		bzero(ID,256);
		sprintf(ID,"%d",child_id);
		while(1)
		{
			read(pipe,lastChild,255);
			printf("Child %d pipe value : %s\n",child_id,lastChild);
			if(!strcmp("0",lastChild))
			{
				write(pipe,lastChild,strlen(lastChild));
				printf("Child %d reach the point!\n",child_id);
				exit(0);
			}
			else if(!strcmp(ID,lastChild))
			{
				bzero(lastChild,256);
				sprintf(lastChild,"%d",child_id-1);
			}
			write(pipe,lastChild,strlen(lastChild));
		}
	}
	else // in parent
	{
		pipe=open(path,O_WRONLY|O_TRUNC);
		bzero(lastChild,256);
		sprintf(lastChild,"%d",MAXCHILD-1);
		write(pipe,lastChild,strlen(lastChild));
		for(int j=0;j<MAXCHILD;j++)
			wait(&status);
		printf("The program finished successfully!\n");
	}
	return 0;
}
