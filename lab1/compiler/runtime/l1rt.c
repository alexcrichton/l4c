#include <assert.h>
#include <signal.h>
#include <stdlib.h>
#include "l1rt.h"

void sigfpe(int sig) {
  printf("SIGFPE");
  exit(1);
}

/* The main function, which calls _l1_main */
int main() {
  assert(signal(SIGFPE, sigfpe) != SIG_ERR);
  printf("%d\n", _l1_main());
  exit(0);
}
