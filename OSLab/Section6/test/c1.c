/*
example of TCP client, the client frequently sends messages to the server
*/
#include <unistd.h>
#include <stdio.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <string.h>
#include <fcntl.h>
#include <stdlib.h>

#define SERVER_PORT 6000
int main(){
  int client_socket;
  char buffer [256];
  char address [256];
  //making the server address record with a recognized server IP and port
  struct sockaddr_in server;
  server.sin_family = AF_INET;
  server.sin_port = htons(SERVER_PORT);
  server.sin_addr.s_addr = inet_addr("127.0.0.1");
  //making socket family = AF_INET, type = SOCK_STREAM , protocol = TCP
  client_socket = socket ( AF_INET , SOCK_STREAM , IPPROTO_TCP );
  //connecting to the server
  while(1){
    if (connect ( client_socket , (struct sockaddr * ) &server , sizeof(server)) == 0)
      printf("Client is connected to the server!\n");
    else
    {
      printf("Error in connecting to the server\n");
      return 0;
    }
    int file = open("client_cpy.txt",O_CREAT|O_RDWR,00777);
    bzero (address ,256);
    fgets(address, 256,stdin);//getting file address
    write(client_socket , address , 256);
    printf("File address is sent to the server!\n");
    bzero(buffer ,256);
    read(client_socket , buffer , 256);
    while(strcmp(buffer,"") != 0) {
      write(file , buffer , strlen(buffer));
      bzero (buffer ,256);
      read(client_socket , buffer , 256);
    }
    close(file);
  }
  return 0;
}
