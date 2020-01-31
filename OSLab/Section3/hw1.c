#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <fcntl.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>

int main (int argc, char *argv[])
{
	if (strcmp(argv[1], "-c")==0)
	{
		umask(0);
		int per = strtol(argv[2], NULL, 8);
		char path [100];
		strcat(path, argv[3]);
		strcat(path, "/open.txt");
		int openFile=open(path,O_CREAT|O_RDWR,per);
		close(openFile);
	}
	else if (strcmp(argv[1], "-w")==0)
	{
		char path[100];
		strcat(path, argv[2]);
		int openFile=open(path,O_CREAT|O_RDWR | O_APPEND,00755);
		char text[256];
		char temp[256];
		fgets(temp, 255, stdin);
		sprintf(text, "%s", temp);
		write(openFile,text,strlen(text));
		close(openFile);
	}
	else if (strcmp(argv[1], "-r")==0)
	{
		char path[100];
		char text[4];
		strcat(path, argv[2]);
		int openFile=open(path,O_RDWR,00755);
		
		while (read(openFile ,text,4))
		{
			fprintf(stdout, "%s", text);
		}
		
		close(openFile);
	}
	else if (strcmp(argv[1], "-m")==0)
	{
		char path[100];
		char temp[100];
		strcat(path, argv[2]);
		strcat(path, "/");
		strcat(path, argv[3]);
		int files [1000];
		int j=0;
		for (int i=atoi(argv[5]); i<=atoi(argv[6]); i++)
		{
			strcpy(temp, path);
			char index[10];
			sprintf(index, "%d", i);
			strcat(temp, index);
			strcat(temp, ".");
			strcat(temp, argv[4]);
			printf("%s \n", temp);
			files[j]=open(temp,O_CREAT|O_RDWR,00755);
			close (files[j]);
			j++;
		}
	}
	return 0;
}
