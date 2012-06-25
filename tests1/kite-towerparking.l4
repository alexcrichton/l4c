//test return 0
//Problem I: Tower Parking
//NWERC 2007

int shift(int[] lev, int by, int siz, int[][] spaces, int[] buf) {
  for(int i = 0; i < siz; i++)
    buf[i] = lev[i];

  for(int i = 0; i < siz; i++) {
    if(i+by < siz)
      lev[i] = lev[i+by];
    else
      lev[i] = buf[i+by-siz];
  }
  return 0;
}

int main() {

  int[][] spaces = alloc_array(int[], 50);
  for(int i = 0; i < 50; i++)
    spaces[i] = alloc_array(int, 50);

  int[] buf = alloc_array(int, 50);
  
  int cases = readint();

  for(int times = 0; times < cases; times++) {
    int h = readint();
    int l = readint();

    int max = 0;
    for(int i = 0; i < h; i++) {
      for(int j = 0; j < l; j++) {
      spaces[i][j] = readint();
      if(spaces[i][j] > max)
        max = spaces[i][j];
      }
    }

    int cur = 1;

    int t = 0;

    while(cur <= max) {
      for(int y = 0; y < h; y++) {
	int found = 0;
	for(int x = 0; x < l; x++) {
	  if(spaces[y][x] == cur) {
	    if(x <= l/2)
	      t += 5*x+20*y;
	    else
	      t += 5*(l-x)+20*y;
	    
	    shift(spaces[y], x, l, spaces, buf);
	  }
	}
	if(found == 1)
	  break;
      }
      
      cur++;
    }
    
    printint(t);
    printchar(10);
  }
  
  return 0;
}
