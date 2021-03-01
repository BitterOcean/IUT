// Server side implementation of UDP client-server model
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>

int main() {
  int server_socket;
  char buffer[256];
  char hello_msg[256];
  struct sockaddr_in server_address, client_address;
  // Creating a socket file descriptor
  if ( (server_socket = socket(AF_INET, SOCK_DGRAM, 0)) < 0 ) {
    printf("error: socket creation failed\n");
    return -1;
  }
  // Filling server information
  server_address.sin_family = AF_INET;
  server_address.sin_addr.s_addr=inet_addr("127.0.0.1");
  server_address.sin_port = htons(6000);
  // Bind the socket with the server address
  if ( bind(server_socket, (const struct sockaddr *)&server_address,sizeof(server_address)) < 0 )
  {
    printf("error: bind failed\n");
    return (-1);
  }
  while(1){
    int client_address_len = sizeof(client_address);
    int n;
    n = recvfrom(server_socket, (char *)buffer, 255, MSG_WAITALL, ( struct sockaddr *) &client_address, &client_address_len);
    buffer[n] = '\0';
    printf("A message from a client: %s\n" , buffer);
    int x,y;
    sscanf(buffer,"%d %d",&x,&y);
    sprintf(hello_msg,"%d",(x+y));
    sendto(server_socket, (const char *)hello_msg, strlen(hello_msg),MSG_CONFIRM,(const struct sockaddr *) &client_address, client_address_len);
    printf("Response message sent to the client.\n");
  }
  return 0;
}
