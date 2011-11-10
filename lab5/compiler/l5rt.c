#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <signal.h>
#include <string.h>

void* zeromem(size_t bytes) {
  void *mem = calloc(bytes, 1);
  if (mem == NULL) {
    raise(SIGSEGV);
  }
  return mem;
}

void raise_segv() {
  raise(SIGSEGV);
}

/* Two arguments for compatibility with calloc when using --safe/--unsafe */
void* salloc(ssize_t elements, size_t size) {
  return zeromem(elements * size);
}

void* salloc_array(ssize_t elements, size_t size) {
  if (elements < 0) {
    raise(SIGSEGV);
  }
  /* 8 extra bytes to shove the size of the array before the array */
  uint32_t *mem = zeromem(elements * size + 8);
  *mem = (uint32_t) elements;
  /* Return the pointer to actual data so everything is compatible */
  return mem + 2;
}

void checkeof () {
  if (feof(stdin)) {
    raise(SIGSEGV);
  }
}

int eof () {
  int ret;
  int ch = fgetc(stdin);
  ret = !!feof(stdin);
  ungetc(ch, stdin);
  return ret;
}

int booltoint (int n) {
  return n;
}

int inttobool (int n) {
  return !!n;
}

int printchar (int c) {
  fputc(c, stderr);
  return c;
}

int printint (int n) {
  fprintf(stderr, "%d", n);
}

int printhex (int n) {
  fprintf(stderr, "0x%X", n);
}

int readchar () {
  checkeof();
  return fgetc(stdin);
}

int readint () {
  int ret;
  checkeof();
  fscanf(stdin, "%d ", &ret);
  return ret;
}

int readhex () {
  int ret;
  checkeof();
  fscanf(stdin, "%x ", &ret);
  return ret;
}

union view {
  int ival;
  float fval;
};

float viewasfloat (int n) {
  union view v;
  v.ival = n;
  return v.fval;
}

int viewasint (float x) {
  union view v;
  v.fval = x;
  return v.ival;
}

int printfloat (int x) {
  fprintf(stderr, "%f", viewasfloat(x));
}

int readfloat () {
  float f;
  checkeof();
  fscanf(stdin, "%f ", &f);
  return viewasint(f);
}

int tofloat (int n) {
  return viewasint((float)n);
}

int fromfloat (int x) {
  return (int)(viewasfloat(x));
}

int fadd (int x, int y) {
  return viewasint(viewasfloat(x)+viewasfloat(y));
}

int fsub (int x, int y) {
  return viewasint(viewasfloat(x)-viewasfloat(y));
}

int fmul (int x, int y) {
  return viewasint(viewasfloat(x)*viewasfloat(y));
}

int fdiv (int x, int y) {
  return viewasint(viewasfloat(x)/viewasfloat(y));
}

extern int _c0_main();

/* The main function, which calls _c0_main */
int main() {
  printf("%d\n", _c0_main());
  exit(0);
}
