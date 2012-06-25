//test return 0

typedef int float;

float scalex(float x)
{
    float f35 = fdiv(tofloat(7), tofloat(2));
    float f25 = fdiv(tofloat(5), tofloat(2));
    float scaledVal = fmul(fdiv(x, tofloat(50)), f35);
    return fsub(scaledVal, f25);
}

float scaley(float y)
{
    float scaledVal = fdiv(y, tofloat(25));
    return fsub(scaledVal, tofloat(1));
}

int mandelbrot(int max_iteration)
{
    for(int ypix = 0; ypix < 50; ypix++)
    {
        for(int xpix = 0; xpix < 50; xpix++)
        {
            int iteration = 0;

            float x0 = scalex(tofloat(xpix));
            float y0 = scaley(tofloat(ypix));

            float x = tofloat(0);
            float y = tofloat(0);

            while(fromfloat(fadd(fmul(x, x), fmul(y, y))) < 4 && iteration < max_iteration)
            {
                //printint(fromfloat(fadd(fmul(x, x), fmul(y, y))));
                float xtemp = fadd(fsub(fmul(x, x), fmul(y, y)), x0);
                y = fadd(fmul(tofloat(2), fmul(x, y)), y0);
                x = xtemp;

                iteration++;
            }

            if(fromfloat(fadd(fmul(x, x), fmul(y, y))) < 4)
            {
                printchar(46); //.
            } else {
                if(iteration > 9)
                {
                    printint(9);
                } else {
                    printint(iteration); //'color'
                }
            }
        }
        printchar(10); //newline
    }

    return 0;
}

int main()
{
    mandelbrot(1000);
    return 0;
}
