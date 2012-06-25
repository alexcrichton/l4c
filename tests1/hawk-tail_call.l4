//test return 0

// a tail-recursive binary search for optimization testing
// alas, this is IO bound rather than computation-bound

struct bin_result {
	bool found;
	int index;
};
typedef struct bin_result bin_result;

bin_result *binsearch (int [] arr, int hi, int lo, int seek)
{
	if (hi == lo ) {
		bin_result *ans = alloc (bin_result);
		ans -> index = hi;
		ans -> found = arr[lo] == seek;
		return ans;
	}
	int mid = (hi + lo) / 2; // wrong for very large arrays but I'm lazy
	
	if (arr[mid] >= seek) {
		return binsearch(arr, mid, lo, seek);
	}
	else {
		return binsearch (arr, hi, mid+1, seek);
	}
}

int main () {
    int size = readint ();

	int seek = readint ();

	int expected = readint ();

    int[] array = alloc_array (int, size);

    for (int i = 0; i < size; i++) {
		printint(i);
		printchar(0x20);
        array[i] = readint();
    }

	printchar(0xA);

	bin_result *result = binsearch(array, size, 0, seek);
	
	printint (result -> index);

	if(! result -> found) {1 / 0;}
	
	return expected - result -> index;
}


