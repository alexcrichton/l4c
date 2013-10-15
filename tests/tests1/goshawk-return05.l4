//test return 27
// sorts a list of pairs using a lexicographic comparison

struct pair {
    int fst;
    int snd;
};

typedef struct pair pair;

int selection_sort(pair *[] arr, int n);
int compare(pair *i, pair *j);
int swap(pair *[] arr, int i, int j);

int main()
{
    int n = readint();

    pair *[] arr = alloc_array(pair *, n);

    for (int i = 0; i < n; i++) {
        arr[i] = alloc(pair);
        arr[i]->fst = readint();
        arr[i]->snd = readint();
    }

    selection_sort(arr, n);

    for (int i = 0; i < n; i++) {
        printchar(0x28);
        printint(arr[i]->fst);
        printchar(0x2c);
        printchar(0x20);
        printint(arr[i]->snd);
        printchar(0x29);
        printchar(0xa);
    }

    return n;
}

int selection_sort(pair *[] arr, int n)
{
    for (int i = 0; i < n; i++) {
        pair *min = arr[i];
        int min_index = i;
        
        for (int j = i + 1; j < n; j++) {
            if (compare(arr[j], min) < 0) {
                min = arr[j];
                min_index = j;
            }
        }

        swap(arr, i, min_index);
    }
    return 0;
}

int compare(pair *i, pair *j)
{
    if (i->fst != j->fst)
        return i->fst - j->fst;
    else
        return i->snd - j->snd;
}

int swap(pair *[] arr, int i, int j)
{
    int tmp1 = arr[i]->fst;
    int tmp2 = arr[i]->snd;

    arr[i]->fst = arr[j]->fst;
    arr[i]->snd = arr[j]->snd;

    arr[j]->fst = tmp1;
    arr[j]->snd = tmp2;

    return 0;
}
