/*
example of TCP server
the server listens to incoming clients and lets maximum 5 client requests are
queued before acception. Then the server accepts one client socket and frequently
receives messages from it.
*/
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <fcntl.h>
#include <stdlib.h>

#define SERVER_PORT 6000
#define MAX_CLIENT 5

int main(){
  char buffer [256];
  char address [256];
  int server_socket , client_socket ;
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
  bind ( server_socket , (struct sockaddr * ) & server_address , sizeof(server_address)) ;
  //listening to incoming requests from clients with backlog of 5 clients
  listen (server_socket , MAX_CLIENT);
  int clientsize = sizeof(client_address);

  while(1){
    if ((client_socket = accept ( server_socket , (struct sockaddr * ) & client_address , &(clientsize)))>=0)
      printf("A connection from a client is recieved\n");
    else
      printf("Error in accepting the connection from the client\n ");

    bzero(buffer,256);
    bzero(address,256);
    read(client_socket , address , 256) ;
    address[strlen(address)-1] = '\0';
    int file = open(address,O_RDONLY);
    read(file,buffer,255);
    while(strcmp(buffer,"") != 0)
    {
      write(client_socket,buffer,255);
      bzero(buffer,256);
      read(file,buffer,255);
    }
  }
  return 0;
}
