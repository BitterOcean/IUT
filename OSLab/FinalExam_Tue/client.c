/*
  Sajede Nicknadaf
  9637453
*/
#include<unistd.h>
#include<stdio.h>
#include<sys/socket.h>
#include<arpa/inet.h>
#include<string.h>
#include<time.h>
#include<stdlib.h>
#include<signal.h>

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
  while(1) {
    char command;
    printf("enter y for run\n");
    scanf("%c",&command);
    while(command!='y')
    {
      scanf("%c",&command);
    }
    int n=rand()%2;

    char buffer[256];
    bzero(buffer,256);
    sprintf(buffer,"get");
    //sending "get" to server means that I want to play
    write(client_socket , buffer , 256);
    sleep(3);
    bzero(buffer,256);

    //reading old buffer
    if(read(client_socket , buffer , 256)==-1)
    {
      close(client_socket);
      kill(0,9);
      return 0;
    }
    printf("old buffer is : %s\n",buffer);
    char newbuffer[256];
    bzero(newbuffer,256);

    printf("you have to insert %d words\n",n+1);
    if(n!=0)
    {

        scanf("%s",newbuffer);
        strcat(buffer,"/");
        strcat(buffer,newbuffer);
        bzero(newbuffer,256);
    }
    scanf("%s",newbuffer);
    strcat(buffer,"/");
    strcat(buffer,newbuffer);
    bzero(newbuffer,256);
    printf("newbuffer is : %s\n",buffer);

    //sending new buffer to server
    if(write(client_socket , buffer , 256)==-1)
    {
      close(client_socket);
      kill(0,9);
      return 0;
    }
  }
  return 0;
}
