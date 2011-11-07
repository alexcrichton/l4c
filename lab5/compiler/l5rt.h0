/*************************************************************
 * Output -- These print to stderr.
 */

int printchar (int c);
int printint (int n);
int printhex (int n);
int printfloat (int x);

/*************************************************************
 * Input -- These read from stdin. Note that the read*() functions raise
 * SIGSEGV if called when eof() is true.
 */

int readchar();
int readint();
int readhex();
int readfloat();

/*
 * Checks for EOF; this will yield true when the last character has been read
 * from the file,
 */
bool eof();

/*************************************************************
 * Utility -- Floating point and boolean coercion
 */

int tofloat (int n);
int fromfloat (int x);
int fadd (int x, int y);
int fsub (int x, int y);
int fmul (int x, int y);
int fdiv (int x, int y);
int booltoint (bool x);
bool inttobool (int y);
