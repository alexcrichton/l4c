//test return 1
//solve the subset sum problem naively
//by enumerating the powerset

int main()
{
  //between 1 and 31
  int num_elements = 16;
  int num_subsets = ~((-1)<<num_elements);
  
  int[] elements = alloc_array(int,num_elements);
  for(int i = 0; i < num_elements;i++)
    elements[i] = readint();

  int sum;
  for(int i = 1; i < num_subsets; i++)
  {
    sum = 0;
    for(int j = 0; j < 31; j++)
    {
      if(1 == ((i >> j) & 1)  )
        sum+=elements[j];
    }
    if(sum==0)
      return 1;
  }
  return 0;

}
