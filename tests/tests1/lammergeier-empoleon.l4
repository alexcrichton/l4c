//test return 574153321
//tests for leal, a corruption of loule

int main() {
    // this implements a really dumb hash
    int sum = 0x1337D00D;
    while (!eof()) {
        int c = readchar();
        if ((c & 0x3) == 0)
            sum += c;
        else if ((c & 0x3) == 1)
            sum += c * 2;
        else if ((c & 0x3) == 2)
            sum += c * 4;
        else if ((c & 0x3) == 3)
            sum += c * 8;
        else {
            int *die = NULL;
            *die = 0;
        }
    }
    return sum;
}
