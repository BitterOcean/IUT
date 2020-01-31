/*
  Name : Maryam Saeedmehr
  StudentNO : 9629373
*/
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <pthread.h>
#include <stdlib.h>
#include <signal.h>

#define SERVER_PORT 6000

int flag=0;
int start=0;
int num;

struct client
{
  int socket;
  struct sockaddr_in address;
};

void *routine1(void * x)
{
  char buffer [256];
  // wait untill all of the players have connected to the server
  while( !start );
  while(1)
  {
    bzero(buffer,256);
    read(((struct client*)x)->socket,buffer,256);
    num -= atoi(buffer);

    if( num > 0 )
      printf("player %d plays , num = %d\n",ntohs((((struct client*)x)->address).sin_port),num);
    else
      printf("player %d plays , num = 0\n",ntohs((((struct client*)x)->address).sin_port));

    if( num <= 0 )
        flag = 1;

    if( flag == 1 )
    {
      printf("Player %d is the winner\n",ntohs((((struct client*)x)->address).sin_port));
      close(((struct client*)x)->socket);
      pthread_exit(NULL);
    }

  }// end of while(1)
}// end of routine1()

// argv[1] is the number of players
// argv[2] is the number of stones
int main(int argc, char* argv[])
{
  int counter=0;/* a variable to count the number of players
                 * to make sure that all clients have connected
                 * to the server in order to start the game */

  num = atoi(argv[2]);// number of stones
  int n = atoi(argv[1]);// number of players
  struct client *cli = (struct client*)malloc(sizeof(struct client)*n);
  int server_socket,client_socket ;
  // server_address = explicit address of server
  //client_address = client information
  struct sockaddr_in server_address , client_address ;
  //filling the server address record
  server_address.sin_family = AF_INET; //IPv4
  server_address.sin_port = htons(SERVER_PORT);
  server_address.sin_addr.s_addr = inet_addr("127.0.0.1");
  //server_address.sin_addr.s_addr=INADDR_ANY;
  //making socket family = AF_INET, type = SOCK_STREAM , protocol = TCP
  server_socket = socket ( AF_INET , SOCK_STREAM , IPPROTO_TCP );
  //binding socket to the server address
  bind(server_socket , (struct sockaddr * ) & server_address , sizeof(server_address));
  //listening to incoming requests from clients with backlog of 5 clients
  listen(server_socket , n);

  pthread_t threads[n];
  //for every client I have one thread
  for( int i = 0 ; i < n ; i++ )
  {
    int clientsize = sizeof(client_address);
    if ((client_socket = accept ( server_socket , (struct sockaddr * ) & client_address , &(clientsize)))>=0)
      {
        // printf("A connection from a client is recieved\n");
        if(++counter == n)
          start=1;
        cli[i].socket=client_socket;
        cli[i].address=client_address;
        pthread_create(&threads[i], NULL, routine1, (void *)&cli[i] );
      }
    else
      printf("Error in accepting the connection from the client\n");
  }

  //waiting for all threads
  for( int i = 0 ; i < n ; i++ )
    pthread_join(threads[i],NULL);

  return 0;
}
