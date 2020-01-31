/*
  Name : Maryam Saeedmehr
  StudentNO : 9629373
*/
#include <unistd.h>
#include <stdio.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <string.h>
#include <time.h>
#include <stdlib.h>
#include <signal.h>

#define SERVER_PORT 6000

int main(){
  int client_socket;
  char buffer [256];
  //making the server address record with a recognized server IP and port
  struct sockaddr_in server;
  server.sin_family=AF_INET;
  server.sin_port=htons(SERVER_PORT);
  server.sin_addr.s_addr=inet_addr("127.0.0.1");
  //making socket family = AF_INET, type = SOCK_STREAM , protocol = TCP
  client_socket = socket ( AF_INET , SOCK_STREAM , IPPROTO_TCP );
  //connecting to the server
  if (connect ( client_socket , (struct sockaddr * ) &server , sizeof(server))==0)
    printf("Client is connected to the server!\n");
  else
    printf("Error in connecting to the server\n");
  srand(getpid()+time(NULL));
  while(1)
  {
    char buffer[256];
    bzero(buffer,256);
    int T=rand()%5;
    sprintf(buffer,"%d",T);
    //sending T to server means that I want to play a round
    write(client_socket , buffer , 256);
    sleep(T);
    bzero(buffer,256);
  }
  return 0;
}
