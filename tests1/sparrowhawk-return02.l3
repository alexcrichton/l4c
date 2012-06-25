//test return -40

// Program that converts between fahrenheit and celsius

int f2c(int f)
{
	int c = fromfloat(fmul(fdiv(tofloat(5), tofloat(9)), 
			       fsub(tofloat(f), tofloat(32))));
	return c;
}

int c2f(int c)
{
	int f = fromfloat(fadd(fdiv(fmul(tofloat(c), tofloat(9)), tofloat(5)), 
			       tofloat(32)));
	return f;
}

int main()
{

	int f = -40;
	int c;

	c = f2c(f); //Note that -40f == -40c
	f = c2f(c);
	
	return f;
	
}

