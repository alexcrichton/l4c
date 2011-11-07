//test return 0
//Saratov State University Online Contester: Problem 104: Little Shop of Flowers


int ppath(int v, int f, int[][] from)
{
  if(f==0)
    {
      printint(v+1);
    }
  else
    {
      ppath(from[f][v],f-1, from);
      printchar(32);
      printint(v+1);
    }
    return 0;
}

int main()
{
  int[][] best = alloc_array(int[], 100);
  int[][] util = alloc_array(int[], 100);
  int[][] from = alloc_array(int[], 100);

  for(int i = 0; i < 100; i++) {
    best[i] = alloc_array(int, 100);
    util[i] = alloc_array(int, 100);
    from[i] = alloc_array(int, 100);
  }
  

  int F = readint();
  int V = readint();

  for(int i = 0; i < F; i++)
    {
      for(int j = 0 ; j < V; j++)
      {
        util[i][j] = readint();
	best[i][j] = -1000000000;
      }
    }

  for(int i = 0; i < V; i++)
    {
      best[0][i] = util[0][i];
    }

  for(int i = 1; i < F; i++)
    {
      for(int j = 0; j < V; j++)
      {
        int max = -100000000;
	  int f = -1;
	    for(int k = 0; k < j; k++)
	        {
		      if(best[i-1][k]>max)
			{
			  max = best[i-1][k];
			  f = k;
			}
		}
	    best[i][j] = max+util[i][j];
	    from[i][j] = f;
      }
    }
  
  int m = -1000000000;
  int f = -1;
  for(int i = 0; i < V; i++)
    {
      if(best[F-1][i] > m)
      {
        m = best[F-1][i];
	f = i;
      }
    }
  
  printint(m);
  printchar(10);
  ppath(f,F-1, from);
  printchar(10);

  return 0;
}
