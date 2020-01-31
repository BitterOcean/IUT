#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <time.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>

#define SERVER_PORT 6002

int SIZE;
int *winners;
int num, seen, alive, winnum, start;
int minormax;
int myround;
int *client_socket;
sem_t sem1, sem2;

void *routine1(void * x)
{
  char buffer[256];
  int id = *(int*)x;
  int score = 0;
  int t;
  while(1)
  {
    while(!start);
    bzero(buffer,256);
    read(client_socket[id] , buffer , 255);
    //read(client_socket[id] , buffer , 255);
    t = atoi(buffer);
    printf("t = %d\n", t);
    if(myround && t > minormax)
    {
      sem_wait(&sem1);
      minormax = t;
      sem_post(&sem1);
    }
    else if(!myround && t < minormax)
    {
      sem_wait(&sem1);
      minormax = t;
      sem_post(&sem1);
    }
    sem_wait(&sem2);
    num++;
    sem_post(&sem2);
    while(num<SIZE);
    if(t == minormax)
      score++;
    //printf("minormax = %d\n", minormax);
    bzero(buffer,256);
    sprintf(buffer,"%d",score);
    write(client_socket[id] , buffer , strlen(buffer));
    start = 0;
    if(score == 10)
    {
      winners[winnum++] = id;
      close(client_socket[id]);
      sem_wait(&sem2);
      SIZE--;
      sem_post(&sem2);
      pthread_exit(NULL);
    }
    sem_wait(&sem2);
    seen++;
    sem_post(&sem2);
  }
}

int main(int argc, char** argv){
  SIZE = atoi(argv[1]);
  winners = (int*)malloc(sizeof(int)*SIZE);
  client_socket = (int*)malloc(sizeof(int)*SIZE);
  int thread_id[SIZE];
  pthread_t threads[SIZE];
  char buffer [256];
  int server_socket ;
  struct sockaddr_in server_address, client_address;

  server_address.sin_family=AF_INET; //IPv4
  server_address.sin_port=htons(SERVER_PORT);
  server_address.sin_addr.s_addr=inet_addr("127.0.0.1");
  server_socket = socket ( AF_INET , SOCK_STREAM , IPPROTO_TCP );
//initialization:
  sem_init(&sem1,0,1);
  sem_init(&sem2,0,1);
  srand(time(NULL));
  myround = rand()%2;
  if(myround)
    minormax = -1;
  else
    minormax = 100;
  seen = 0;
  num = 0;
  alive = SIZE;
  winnum = 0;
  start = 1;
//main start********************
  bind ( server_socket , (struct sockaddr * ) & server_address ,
  sizeof(server_address)) ;
  listen (server_socket , SIZE);
  int clientsize=sizeof(client_address);
  for(int i=0; i<SIZE;)
  {
    if ((client_socket[i] = accept ( server_socket , (struct sockaddr * ) &
    client_address , &(clientsize)))>=0)
    {
      printf("A connection from a client is recieved\n");
      thread_id[i] = i;
      pthread_create(&threads[i], NULL, routine1, (void *)&thread_id[i] );
      i++;
    }
    else
      printf("Error in accepting the connection from the client\n ");
  }
  /*for (int i=0; i<SIZE; i++)
    pthread_join(threads[i],(void**)&retval);*/
  while(SIZE)
  {
    if(seen == SIZE)
    {
      myround = rand()%2;
      if(myround)
        minormax = -1;
      else
        minormax = 100;
      seen = 0;
      num = 0;
      printf("round = %d\n", myround);
      start = 1;
    }
  }
  SIZE = atoi(argv[1]);
  for(int i=0;i<SIZE;i++)
    printf("%d\n",winners[i]);
  sleep(50);
return 0;
}
