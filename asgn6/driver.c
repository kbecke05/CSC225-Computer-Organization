#include <stdio.h>
#include <stdlib.h>
#include "stack.h"

int main (int argc, char *argv[]) {
  char mode;
  int print_num = 0;
  int address;
  printf("Welcome to the stack program. \n");
  while (mode != 'x') {
    printf("\n");
    printf("Enter option: ");
    scanf(" %c", &mode);
    if (mode == 'u') {
      printf("What number? ");
      scanf("%d", &address);
      if (push(address)==1) {
        printf("Overflow!!!\n");
      }
      printStack(print_num);
    }
    else if (mode == 'o') {
      int address;
      if (pop(&address)==1) {
        printf("Underflow!!!\n");
      } else {
      printf("Popped %d\n", address);}
      printStack(print_num);
    }
    else if (mode == 'h') {
      print_num = 1;
      printStack(print_num);
    }
    else if (mode == 'c') {
      print_num = 2;
      printStack(print_num);
    }
    else if (mode == 'd') {
      print_num = 0;
      printStack(print_num);
    } 
    else if (mode == 'x'){
      printf("Goodbye! \n");
    }
    else {
      printf("\n");
    } 
  }
  return 0;
}