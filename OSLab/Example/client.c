#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <time.h>
#include <stdlib.h>


#define SERVER_PORT 6002
int main(){
  int x;
  srand(time(NULL) + getpid());
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
while(1) {
bzero (buffer ,256);
x = rand()%100;
printf("produced = %d\n",x);
sprintf(buffer,"%d",x);
write(client_socket , buffer , strlen(buffer));
bzero (buffer ,256);
read(client_socket , buffer , 256);
x = atoi(buffer);
printf("score = %d\n", x);
if(x == 10)
{
  close(client_socket);
  printf("I Win\n");
  sleep(50);
  return 0;
}
}

}
