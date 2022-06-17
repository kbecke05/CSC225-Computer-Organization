#include <stdio.h>
#include <stdlib.h>


  int stack[10];
  int num_items = 0;
  
  int push(int value) {
    if (num_items == 10) {
      return 1;
    }
    else {
      stack[num_items] = value;
      num_items += 1;
      return 0;
    }
  }
  
  int pop(int *value) {
    if (num_items == 0) {
      return 1;
    }
    else{
      int pop_num = stack[num_items - 1];
      num_items -= 1;
      *value = pop_num; 
      return 0;
    }
  }
  
  void printStack(int value) {
    int i;
    printf ("Stack: ");
    if (value == 0) { 
      for (i=0; i < num_items; i++) {
        printf("%d ", stack[i]);
      }
      printf("\n"); 
    }
    else if (value == 1){ 
      for (i=0; i < num_items; i++) {
        printf("%x ", stack[i]);
      }
      printf("\n"); 
    }
    else { 
      for (i=0; i < num_items; i++) {
        printf("%c ", stack[i]);
      }
      printf("\n"); 
    }
  }
