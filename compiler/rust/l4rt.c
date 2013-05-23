#include <stdlib.h>
#include <stdio.h>
#include <signal.h>

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
  printf("%d", _c0_main());
  exit(0);
}

void raise_segv() {
  *(int*)NULL = 0;
}

void *salloc(int32_t elems, size_t bytes) {
  void *ptr = calloc(elems, bytes);
  if (ptr == NULL)
    raise_segv();
  return ptr;
}

void *salloc_array(int32_t elems, size_t bytes) {
  if (elems < 0)
    raise_segv();
  size_t s = elems * bytes;
  size_t *ptr = calloc(1, s + sizeof(size_t));
  if (ptr == NULL)
    raise_segv();
  *ptr = elems;
  return ptr + 1;
}
