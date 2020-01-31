#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <stdlib.h>

#define READ_END 0
#define WRITE_END 1

int parse_pipe(char *command,char **parsed_command)
{
	int i;
	for(i=0; i<=1; i++)
	{
		parsed_command[i]=strsep(&command,”|”);
		if(parsed_command[i]==NULL)
		break;
	}
	if(parsed_command[1]==NULL)
		return 0;
	else 
		return 1;
}

void exec_command(char *command)
{
	pid_t pid=fork();
	if(pid<0)	
	{
		printf(“\nFailed on forking child!”);
		return;
	}
	else if(pid==0)
	{
		if(command[strlen(command)-1]==’&’)
		{
			char temp[256];
			strncpy(temp,command,strlen(command)-1);
			if(execlp(temp,temp,NULL)<0)
			{
				printf(“\nFailed on executing command!”);
			}
			exit(0);
		}
		else
		{
			if(execlp(command,command,NULL)<0)
			{
				printf(“\nFailed on executing command!”);
			}
			exit(0);
		}
	}
	else
	{
		if(command[strlen(command)-1]==’&’)
		{
			return;
		}
		else{
			wait(NULL); 
			return;
		}
	}
}

void exec_piped_commands(char **command)
{
	int pipefd[2];
	pid_t pid1, pid2;
	if(pipe(pipefd) < 0)
	{
		printf(“\nPipe initialization failed!”);
		return;
	}
	pid1=fork();
	if(pid1<0)
	{
		printf(“Forking failed!”);
		return;
	}
	if(pid1==0)
	{
		close(pipefd[READ_END]);
		dup2(STDOUT_FILENO, pipefd[WRITE_END]); //exchange the defaultt output of first command 
		if(execvp(command[0],command) < 0)
		{
			printf(“\nExecution failed for Command1!”);
			exit(0);
		}
	}
	else
	{
		pid2=fork();
		if(pid2<0)
		{
			printf(“\nForking failed!”);
			return;
		}
		else if(pid2==0)
		{
			close(pipefd[WRITE_END]);
			dup2(STDIN_FILENO, pipefd[READ_END]);
			if(execvp(command[1],command) < 0)
			{
				printf(“\nExecution failed for Command2!”);
				exit(0);
			}
		}
		else
		{
			//wait for two childs to complete
			wait(NULL);
			wait(NULL);
			
		}
	}
}

int main()
{
	char command[256];
	char *parsed_command[256];
	while(1)
	{
		scanf("%s",command);
		if(parse_pipe(command,parsed_command) == 0)
			exec_command(command);
		else 
			exec_piped_commands(parsed_command);
	}
	return 0;
}
