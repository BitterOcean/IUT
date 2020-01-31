// Client side implementation of UDP client-server model
#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<string.h>
#include<sys/types.h>
#include<sys/socket.h>
#include<arpa/inet.h>
#include<netinet/in.h>

int main()
{
  int client_socket;
  char buffer[256];
  char hello_msg[256];
  struct sockaddr_in server_address, client_address;
  // Creating a socket file descriptor
  if ((client_socket = socket(AF_INET, SOCK_DGRAM, 0)) <0 )
  {
    printf("error: socket creation failed\n");
    return -1;
  }
  //filling the server address record
  server_address.sin_family = AF_INET;
  server_address.sin_port = htons(6000);
  server_address.sin_addr.s_addr=inet_addr("127.0.0.1");
  int x,y;
  scanf("%d%d",&x,&y);
  sprintf(hello_msg, "%d %d",x,y);
  //send a message from the known server address
  sendto(client_socket, (const char *)hello_msg, strlen(hello_msg), MSG_CONFIRM,(const struct sockaddr *) &server_address, sizeof(server_address));
  printf("Hello message is sent.\n");
  int n, server_address_len;
  //receive a message from the known server address
  n = recvfrom(client_socket, (char *)buffer, 255, MSG_WAITALL, (struct sockaddr*) &server_address, &server_address_len);
  buffer[n] = '\0';
  printf("A message from the server : %s\n", buffer);
  close(client_socket);
  return 0;
}
