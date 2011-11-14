//test return 48087969 
//possible candidate for cache optimizations
//
int main()
{
  int n = 400;
  int[] a = alloc_array(int,n*n);
  int[] b = alloc_array(int,n*n);
  int[] c = alloc_array(int,n*n);
  
  for(int i = 0; i < n*n; i++)
  {
     a[i] = readint();
     b[i] = readint();
     c[i] = 0;
  }

  for(int i = 0; i < n; i++)
    for(int j = 0; j < n; j++)
      for(int k = 0; k < n; k++)
        c[i+j*n] += a[k+j*n]*b[i+k*n];

  return c[15411];
}
