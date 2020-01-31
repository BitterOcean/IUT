#include <stdio.h>
void f3(){
  printf("function f3 calling f1\n");
  int ret = f1();
  printf("f1 return %d\n", ret);
  f2();
}
