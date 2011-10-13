//test return 0
//Problem "Clique" from Codesprint

int choose2(int n) {
  return n*(n-1) / 2;
}

int maxedges(int n, int c) {
  if(c == 1) {
    return 0;
  }

  int r = n % (c-1);

  int s1 = (n-r)/(c-1);
  int s2 = (n-r+c-1)/(c-1);

  int a = c-1-r;
  int b = r;

  return choose2(a)*s1*s1+a*b*s1*s2+choose2(b)*s2*s2;
}

int main() {
  int T = readint();

  for(int times = 0; times < T; times++) {
    int n;
    int M;

    n = readint();
    M = readint();

    int l = 1;
    int h = n;

    while(l < h) {

      int mid = (l+h+1)/2;
      int e = maxedges(n, mid);

      if(e == M) {
        l = mid-1;
        break;
      } else if(e < M) {
        l = mid;
      } else {
        h = mid-1;
      }
    }

    printint(l);
    printchar(10);
  }

  return 0;
}
