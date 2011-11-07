//test return 0

int main () {
	int size = readint ();

	int[] array = alloc_array (int, size);
	
	for (int i = 0; i < size; i++) {
		array[i] = readint();
	}

	bool done = false;

	while (! done)
	{
		done = true;
		for (int i = 0; i < size -1; i++)
		{
			int tmp = array[i];
			if (array[i] > array[i+1]) {
				array[i] = array[i+1];
				array[i+1] = tmp;
				done = false;
			}
		}
	}

	for (int i = 0; i < size; i ++)
	{
		printint(array[i]);
		printchar(0x20); //space
	}

	printchar(0xA); //because ?
	return 0;
}
