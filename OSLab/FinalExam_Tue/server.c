/*
  Sajede Nicknadaf
  9637453
*/
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include<pthread.h>
#include<stdlib.h>
#include<semaphore.h>
#include<signal.h>

#define SERVER_PORT 6000

char buffer [256]="";
int max;
sem_t sem1;
int flag=0;

struct client{
  int socket;
  struct sockaddr_in address;
};

void *routine1(void * x)
{
  //printf("I am here\n");
  char newbuffer [256];
  while(1){
    bzero(newbuffer,256);
    read(((struct client*)x)->socket,newbuffer,256);
    //if client say "get" means that he want to play
    if(strcmp(newbuffer,"get")==0){
      //buffer is global and critical section
      sem_wait(&sem1);
      printf("last buffer : %s\n",buffer);
      //sending old buffer for client
      write(((struct client*)x)->socket,buffer,256);
      sleep(3);
      bzero(buffer,256);
      //reading new buffer from client
      while(read(((struct client*)x)->socket,buffer,256)<0);
      printf("new buffer with player %d : %s\n",ntohs((((struct client*)x)->address).sin_port),buffer);
      sem_post(&sem1);

      //checking size of buffer
      if(strlen(buffer)>=max)
      {
        flag=1;

      }
      if(flag==1){
        close(((struct client*)x)->socket);
        //pthread_exit(NULL);
        kill(0,9);
      }

    }
  }
}

int main(int argc, char* argv[]){

  sem_init(&sem1,0,1);
  int n=atoi(argv[1]);
  struct client *cli=(struct client*)malloc(sizeof(struct client)*n);
  max=atoi(argv[2]);
  int server_socket,client_socket ;
  // server_address = explicit address of server
  //client_address = client information
  struct sockaddr_in server_address , client_address ;
  //filling the server address record
  server_address.sin_family=AF_INET; //IPv4
  server_address.sin_port=htons(SERVER_PORT);
  server_address.sin_addr.s_addr=inet_addr("127.0.0.1");
  //server_address.sin_addr.s_addr=INADDR_ANY;
  //making socket family = AF_INET, type = SOCK_STREAM , protocol = TCP
  server_socket = socket ( AF_INET , SOCK_STREAM , IPPROTO_TCP );
  //binding socket to the server address
  bind ( server_socket , (struct sockaddr * ) & server_address ,
  sizeof(server_address)) ;
  //listening to incoming requests from clients with backlog of 5 clients
  listen (server_socket , n);
  pthread_t threads[n];

//for every client we have one thread
  for(int i=0;i<n;i++){
    int clientsize=sizeof(client_address);
    if ((client_socket = accept ( server_socket , (struct sockaddr * ) &
    client_address , &(clientsize)))>=0)
    printf("A connection from a client is recieved\n");
    else
    printf("Error in accepting the connection from the client\n ");

    cli[i].socket=client_socket;
    cli[i].address=client_address;





    pthread_create(&threads[i], NULL, routine1, (void *)&cli[i] );

  }
  //waiting for all threads
  for(int i=0;i<n;i++){
    pthread_join(threads[i],NULL);
  }




  return 0;
}
