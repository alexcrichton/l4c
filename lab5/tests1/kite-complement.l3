//test return 0
//Problem "2's Complement" from Codesprint, restricted to positive ints


int triv(int p) {
  return p*(1<<(p-1));
}

int nupto(int high) {

  if(high <= 1)
    return high;
  
  int last = 0;
  for(int i = 0; i < 31; i++) {
    if((high & (1<<i)) != 0)
      last = i;
  }
  int p = 1<<last;

  int r = high-p;

  return (r+1)+nupto(r)+triv(last);
}

int main() {
  int T = readint();

  for(int caseno = 0; caseno < T; caseno++) {
    int A = readint();
    int B = readint();

    int tot = 0;

    
    if(A < 0 || A > B) {
      1/0;
    } else if(A == 0) {
      tot = nupto(B);
    } else {
      tot = nupto(B) - nupto(A-1);
    }

    printint(tot);
    printchar(10);
  }

  return 0;
}
