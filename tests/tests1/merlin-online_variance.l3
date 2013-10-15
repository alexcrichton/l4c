//test return 0 
//this program will compute an approximation of the variance and mean of 
//a sample population in-line, or by taking the items one at a time

int main()
{
  int mean = 0;
  int M2=0;
  int n = 0;

  int delta;
  int x;
  
  while(!eof())
  {
    x = readint();
    n++;
    delta = x-mean;
    mean = mean + (delta/n);
    M2 = M2 + delta*(x-mean);
  }

  printint(M2/(n));
  printchar(10);
  return 0;
}
