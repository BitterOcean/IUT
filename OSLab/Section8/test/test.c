/*
- this program creates 4 threads
- execution routine for threads is "routine1", we pass thread index (i) as
execution routine argument
- each thread executes the routine in an arbitrary order, in this condition we have
no control on order of execution
- at pthread_join(), master thread waits for worker threads to complete their execution, then
receives their “exit value” that is a random number generated in the thread’s routine
*/
#include <stdio.h>
#include <string.h>
#include <pthread.h>
#include <semaphore.h>
#include <stdlib.h>
#include <unistd.h>
#define THREADS 4
#define TIMEOUT 10

void *routine1(void * x)
{
  int *t = (int*)malloc(sizeof(int));
  *t = rand()%TIMEOUT;
  printf("threadIdx = %d, execution time = %d\n",*(int*)x, *t);
  // replace three above lines with two below lines
  // int t = rand()%TIMEOUT;
  // printf("threadIdx = %d, execution time = %d\n",*(int*)x, t);
  for(int i=0; i<*t; i++)
  // replace the above line with below line
  // for(int i=0; i<t; i++)
    printf("threadIdx = %d; run = %d\n", *(int*)x, i);
  pthread_exit((void*)t);
}

int main ()
{
  pthread_t threads[THREADS];
  int thread_id[THREADS];
  for ( int i=0;i<THREADS;i++){
    thread_id[i] = i;
    pthread_create(&threads[i], NULL, routine1, (void *)&thread_id[i] );
    // replace two above lines with the below line
    // pthread_create(&threads[i], NULL, routine1, (void *)&i );
  }
  int *retval = (int*)malloc(sizeof(int));
  for (int i=0; i<THREADS; i++)
  {
    pthread_join(threads[i],(void**)&retval);
    printf("threadIdx %d finished, return_value = %d \n",i,*retval);
  }
  return 0;
}
