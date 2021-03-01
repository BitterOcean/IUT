#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <pthread.h>
#define SERVER_PORT 7000

struct client_sock{
  int sock;
  struct sockaddr_in address;
};

void* func(void* arg)
{
  char* buffer = (char *)malloc(256*sizeof(char));
  read((*(struct client_sock *)arg).sock , buffer , 256) ;
  printf("client %d:  %s\n",ntohs((*(struct client_sock *)arg).address.sin_port),buffer );
  write((*(struct client_sock *)arg).sock , buffer , 256);
  while(strcmp(buffer,"bye\n") != 0)
  {
  bzero(buffer,256);
  read((*(struct client_sock *)arg).sock, buffer , 256) ;
  write((*(struct client_sock *)arg).sock , buffer , 256);
  printf ("%s\n", buffer);
}
  close((*(struct client_sock *)arg).sock);
  pthread_exit(NULL);
}

int main(){
int server_socket;
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
listen (server_socket , 5);
int clientsize=sizeof(client_address);
while(1){
  int client_socket;
  struct client_sock *cli=(struct client_sock *)malloc(sizeof(struct client_sock));

  if ((client_socket = accept ( server_socket , (struct sockaddr * ) &
  client_address , &(clientsize)))>=0)
  printf("A connection from a client is recieved\n");
  else
  printf("Error in accepting the connection from the client\n ");
  cli->sock = client_socket;
  cli->address = client_address;
  pthread_t thread;
  pthread_create(&thread, NULL, func,(void *)cli);

}
return 0;
}
