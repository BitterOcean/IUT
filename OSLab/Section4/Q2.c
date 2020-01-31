#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

#define MAXCHILD 5

void SLEEP(int r){for(r;r>0;r--) for(long int i=0;i<100000000;i++);}

int main(){
	pid_t child [MAXCHILD];
	int inChild=0;
	int status=0;
	for (int i=0;i<MAXCHILD;i++){
		child[i]=fork();
		if(child[i]==0){
			inChild=1;
			break;
		}
	}

	while(1){

		if (inChild==1){
			srand(getpid());
			int r = rand()%10;
			printf("message from child %d : sleeping %d seconds\n",getpid(), r);
			SLEEP(r);
			inChild=-1;
			exit(0);
		}

		if (inChild==0){
			sleep(5);
			for(int i=0;i<MAXCHILD;i++){
				int child_d;
				//**comment from next line
				//child_d = wait(&status);
				//if (child_d>0)
				//	printf("child[%d] is dead now \n",child_d);
				//else if(child_d==-1)
				//	printf("no child to wait for \n");
				//**comment till this line
				 child_d = waitpid(child[i],&status,WNOHANG);
				// if(child_d==0)
				//	printf("child[%d] is still alive\n",child[i]);
				if(child_d>0){
					printf("New child instead of Child_PID : %d \n",child[i]);
					child[i]=fork();
					if(child[i]==0){
						inChild=1;
						break;
					}
				}
			}
		}
	}

	return 0;
}
