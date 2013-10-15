//test return 0
//Deterimines whether a list of numbers contains any repeats
//Contains a lot of booleans, so avoiding set instructions should save a lot

int main()
{
    while (true) {
        bool any_same = false;
        int n = readint();
        
        if (n == 0)
            break;

        int[] a = alloc_array(int, n);

        for (int i = 0; i < n; i++) {
            a[i] = readint();
            for (int j = 0; j < i; j++) {
                any_same = any_same || (a[i] == a[j]);
            }
        }

        if (any_same) {
            printint(0);
        } else {
            printint(1);
        }
        printchar(0xa);
    }

    return 0;
}

