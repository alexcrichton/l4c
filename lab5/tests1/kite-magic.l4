//test return 0
//Problem 109: Magic of David Copperfield II
//Saratove State University Online Contester

int main() {
  int N = readint();

  int k = N;
  if(N%2==0)
    k++;

  printint(k);	

  for(int i = 0; i < N*N; i++) {
    int x = i%N;
    int y = i/N;
    if(i!=2 &&((x+y)%2==0)) {
      printchar(32);
      printint(i+1);
    }
  }
  printchar(10);

  k += 2;
  printint(k);

  for(int i = 0; i < N*N; i++) {
    int x = i%N;
    int y = i/N;
    if(((x+y)%2==1)) {
      printchar(32);
      printint(i+1);
    }
  }
  printchar(10);
  return 0;
}
