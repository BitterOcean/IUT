#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

// Size of array
#define SIZE 7

// Max number of thread
// Array
int a[SIZE] = {-10,20,120,-400,100,100,-11 };

// Array to store max of threads
int min = 10000000;
int thread_no = 0;
int stride = SIZE/2;
// Function to find maximum
void* func(void* arg)
{
    printf("enter func \n ");
    // int i, num = thread_no++;
    // int maxs = 0;
    //
        if (a[*(int*)arg] < a[*(int*)arg+stride]){
          min = a[*(int*)arg];
        }
        else{
          min = a[*(int*)arg+stride];

        }

    a[*(int*)arg] = min;
    printf("min : %d\n",min );
    for (int j = 0; j < SIZE; j++)
        printf("%d\t", a[j]);
    printf("\n");
    // max_num[num] = maxs;
}

// Driver code
int main()
{
    int cp[stride];
    printf("strid = %d\n",stride);
    // creating 4 threads

    while(stride != 0){
      pthread_t threads[stride];
      for (int i = 0; i < stride; i++){
        printf("i= %d\n",i );
        cp[i] = i;
        pthread_create(&threads[i], NULL, func,(void*) &cp[i]);
      }
      for (int j = 0; j < stride; j++)
          pthread_join(threads[j], NULL);
      printf("\n");
      if(a[0]>a[stride-1]){
              a[0]=a[stride-1];
      }
      stride /= 2;
    }


    // joining 4 threads i.e. waiting for
    // all 4 threads to complete


    // Finding max element in an array
    // by individual threads
    // for (i = 0; i < stride; i++) {
    //     if (max_num[i] > maxs)
    //         maxs = max_num[i];
    // }
    if(a[0]>a[SIZE-1]){
            a[0]=a[SIZE-1];
    }
    printf("Minimum Element is : %d\n", a[0]);

    return 0;
}
