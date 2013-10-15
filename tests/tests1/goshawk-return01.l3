//test return 3
// finds a root of a polynomial using bracketing

typedef int float;

float root(float a, float b);
float quadratic(float x);

int main()
{
    int a = readint();
    int b = readint();
    return fromfloat(root(tofloat(a), tofloat(b)));
}

// Finds a root of the quadratic x^2 + x - 12 within the interval (a,b)
// to some unspecified precision
// Expects (but does not check) that a < b and the quadratic has a different
// sign evaluated at a than at b.
float root(float a, float b) {
    float mid = fdiv(fadd(a, b), tofloat(2));
    float fofmid = quadratic(mid);
    float fofa = quadratic(a);

    if (fromfloat(mid) <= fromfloat(a) || fofmid == fromfloat(0)) {
        return mid;
    } else {
        if (fromfloat(fmul(fofa, fofmid)) > 0) {
            return root(mid, b);
        } else {
            return root(a, mid);
        }
    }
}

float quadratic(float x) {
    return fsub(fadd(fmul(x, x), x), tofloat(12));
}
