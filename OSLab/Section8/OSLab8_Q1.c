#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#define SIZE 7
int A[SIZE]={-10,20,120,100,-400,100,-11};

// #define SIZE 6
// int A[SIZE]={-10,20,120,100,-400,100};

int stride = SIZE/2;

void* runner(void *arg)
{
  if(A[*(int*)arg]>A[*(int*)arg+stride])
    A[*(int*)arg]=A[*(int*)arg+stride];
  if(stride%2)//stride is an odd number
      A[stride]=A[2*stride];
  // printf("stride is %d\n", stride);
  // printf("Array is :");
  // for(int j=0 ; j<stride ; j++)
  //   printf(" %d ,", A[j]);
  // printf("\n");
  pthread_exit((void*)arg);
}

int main()
{
  printf("Array is :");
  for(int j=0 ; j<SIZE ; j++)
    printf(" %d ,", A[j]);
  printf("\n");
  
  while(stride)
  {
    pthread_t threads[stride];
    int thread_id[stride];
    for ( int i=0;i<stride;i++ )
    {
      thread_id[i] = i;
      pthread_create(&threads[i], NULL, runner, (void *)&thread_id[i] );
    }

    int *retval = (int*)malloc(sizeof(int));
    for (int i=0; i<stride; i++)
    {
      pthread_join(threads[i],(void**)&retval);
      // printf("threadIdx %d finished, return_value = %d \n",i,*retval);
    }

    stride /= 2;
  }

  printf("Smallest value is : %d\n", A[0]);
  return 0;
}
