//test return 0
//compute the sum, average, and variance of a list of numbers
//there will be some rounding error, as all computations use integers
//contains many common subexpressions

int main()
{
    int n = readint();
    int[] a = alloc_array(int, n);
    
    int sum = 0;

    for (int i = 0; i < n; i++) {
        a[i] = readint();
        sum += a[i];
    }

    int average = sum / n;
    int variance = 0;

    for (int i = 0; i < n; i++) {
        variance += (a[i] - average) * (a[i] - average);     
    }

    printint(sum);
    printchar(0xa);
    printint(average);
    printchar(0xa);
    printint(variance);

    return 0;
}
