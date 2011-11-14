//test return 0
// reads an input file, printing "Yes" for each palindrome and "No"
// for each nonpalindrome

int printYes();
int printNo();

// Checks to see if x is a palindrome by comparing the most and least
// significant digit, then calling the function recursively without those
// digits
bool isPalindrome(int x)
{
    // All one digit numbers are palindromes
    if (x / 10 == 0) {
        return true;
    }

    int leastSigDigit = x % 10;
    //int mostSigDigit = leastSigDigit;

    // Calculate everything except the most and least significant digit
    // to recurse.  Digits will be reversed, but that's fine.
    int y = x / 10;
    int z = 0;

    while (y / 10 > 0) {
        z += (y % 10);
        z *= 10;
        y /= 10;
    }

    int mostSigDigit = y;

    if (mostSigDigit != leastSigDigit) {
        return false;
    }

    return isPalindrome(z / 10);
}

// reads in some ints and prints out whether they are palindromes
int main()
{
    while(!eof()) {
        int number = readint();
        if (isPalindrome(number)) {
            printYes();
        } else {
            printNo();
        }
    }

    return 0;
}

int printYes()
{
    printchar(0x59);
    printchar(0x65);
    printchar(0x73);
    printchar(0xa);
    return 0;
}

int printNo()
{
    printchar(0x4e);
    printchar(0x6f);
    printchar(0xa);
    return 0;
}
