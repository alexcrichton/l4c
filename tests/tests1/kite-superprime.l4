//test return 0
//Problem 116: Index of super-prime
//Saratov State University Online Contester

int main() {
  int[] primes = alloc_array(int,10000);
  int[] sprimes = alloc_array(int, 10000);
  int nprime=0;
  int nsprime=0;
  int[] knapsack = alloc_array(int, 10001);
  int[] from = alloc_array(int, 10001);
  int n;
  n = readint();

  
  for(int i = 2 ; i<= 10000; i ++) {
    int p = 1;
    for(int d = 2; d*d<= i; d++)
      if(i%d==0) {
	p=0;
	break;
      }

    if(p==1) {
      primes[nprime] = i;
      nprime++;
    }
  }

  for(int i = 0; primes[i] < nprime; i++) {
    sprimes[nsprime] = primes[primes[i]-1];
    nsprime++;
  }

  for(int i = 0; i<nsprime; i++) {
    int s = sprimes[i];
    for(i = s; i <= n; i++) {
      if(i>s && knapsack[i-s] ==0)
      continue;

      if(knapsack[i]==0 || 1+knapsack[i-s] < knapsack[i]) {
	knapsack[i] = 1+knapsack[i-s];
	from[i] = i-s;
      }
    }
  }
  
  printint(knapsack[n]);
  printchar(10);
  
  if(knapsack[n] == 0)
    return 0;
  
  bool space = false;
  for(int i = n; i >0; i=from[i]) {
    if(space) printchar(32);
    space = true;
    printint(i-from[i]);
  }
  printchar(10);

  return 0;
}
