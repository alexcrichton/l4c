//test return 0

int power(int base, int exp)
{
    if(exp == 0)
        return 1;

    if(exp == 1)
        return base;

    return (base * power(base, exp - 1));
}

int push(int newNum, int stack)
{
    if(newNum > 9 || newNum < 1)
        return -1;
    
    return stack * 10 + newNum;
}

int pop(int stack)
{
    return stack / 10;
}

bool stackEmpty(int stack)
{
    return (stack == 0);
}

int len(int stack)
{
    int temp = stack;
    int retVal = 0;

    while(temp % 10 != 0)
    {
        retVal++;
        temp = temp / 10;
    }

    return retVal;
}

int head(int stack)
{
    return stack % 10;
}

int getIndex(int stack, int index)
{
    int divisor = power(10, index);
    int temp = stack / divisor;
    return temp % 10;
}

int max(int stack)
{
    int retVal = 0;
    int temp = stack;

    while(temp % 10 != 0)
    {
        int val = temp % 10;
        if(val > retVal)
            retVal = val;
        temp = temp / 10;
    }

    return retVal;
}

bool printTower(int stack)
{
    int stackLen = len(stack);

    printchar(91); //[
    for(int i = 0; i < stackLen; i++)
    {
        printint(getIndex(stack, i));
        if(i < (stackLen - 1))
            printchar(44); //,
    }
    printchar(93); //]

    return true;
}

bool printDisc(int size, int offset)
{
    for(int i = 0; i <= offset; i++)
        printchar(32); //space
    for(int i = 0; i < size; i++)
        printchar(45); //-
    printchar(10); //newline
    
    for(int i = 0; i < offset; i++)
        printchar(32); //space
    printchar(124); //|
    for(int i = 0; i < size; i++)
        printchar(32); //space
    printchar(124); //|
    printchar(10); //newline

    for(int i = 0; i <= offset; i++)
        printchar(32); //space
    for(int i = 0; i < size; i++)
        printchar(45); //-
    printchar(10); //newline

    return true;
}

bool printDiscs(int stack, int offset)
{
    int maxSize = max(stack);
    int numDiscs = len(stack);

    for(int i = 0; i < numDiscs; i++)
    {
        int value = getIndex(stack, i);
        printDisc(2 * value, (maxSize - i) + offset);
    }
    
    return true;
}

bool printTowers(int stackA, int stackB, int stackC)
{
        
    printchar(65);
    printchar(32);
    printTower(stackA);
    printchar(10);
    printchar(66);
    printchar(32);
    printTower(stackB);
    printchar(10);
    printchar(67);
    printchar(32);
    printTower(stackC);
    printchar(10);
    printchar(10);
    return true;
}

bool solved(int stackA, int stackB, int stackC)
{
    return (stackA == 0 && stackB == 0);
}

bool legalMove(int stackA, int stackB)
{
    int headA = head(stackA);
    int headB = head(stackB);

    if(headA != 0 && headB != 0)
        return headA < headB;

    return (headA != 0);
}

bool solveEven(int stackA, int stackB, int stackC)
{
    int transVal;
    int tempA = stackA;
    int tempB = stackB;
    int tempC = stackC;

    printint(stackA);
    printchar(10);
    printTowers(tempA, tempB, tempC);

    while(!solved(tempA, tempB, tempC))
    {
        if(head(tempA) != 0 || head(tempB) != 0)
        {
            int headA = head(tempA);
            int headB = head(tempB);

            if(legalMove(tempA, tempB))
            {
                printchar(65);
                printint(2);
                printchar(66);
                printchar(10);
                transVal = head(tempA);
                tempA = pop(tempA);
                tempB = push(transVal, tempB);
            } else {
                printchar(66);
                printint(2);
                printchar(65);
                printchar(10);
                transVal = head(tempB);
                tempB = pop(tempB);
                tempA = push(transVal, tempA);
            }
        }
        printTowers(tempA, tempB, tempC);
        printchar(10);
        
        if(solved(tempA, tempB, tempC))
            break;

        if(head(tempA) != 0 || head(tempC) != 0)
        {
            int headA = head(tempA);
            int headC = head(tempC);
            
            if(legalMove(tempA, tempC))
            {
                printchar(65);
                printint(2);
                printchar(67);
                printchar(10);
                transVal = head(tempA);
                tempA = pop(tempA);
                tempC = push(transVal, tempC);
            } else {
                printchar(67);
                printint(2);
                printchar(65);
                printchar(10);
                transVal = head(tempC);
                tempC = pop(tempC);
                tempA = push(transVal, tempA);
            }
        }
        printTowers(tempA, tempB, tempC);
        printchar(10);
        
        if(solved(tempA, tempB, tempC))
            break;
        
        if(head(tempB) != 0 || head(tempC) != 0)
        {
            int headB = head(tempB);
            int headC = head(tempC);

            if(legalMove(tempB, tempC))
            {
                printchar(66);
                printint(2);
                printchar(67);
                printchar(10);
                transVal = head(tempB);
                tempB = pop(tempB);
                tempC = push(transVal, tempC);
            } else {
                printchar(67);
                printint(2);
                printchar(66);
                printchar(10);
                transVal = head(tempC);
                tempC = pop(tempC);
                tempB = push(transVal, tempB);
            }
        }
    }

    return true;
}

bool solveOdd(int stackA, int stackB, int stackC)
{
    int transVal;
    int tempA = stackA;
    int tempB = stackB;
    int tempC = stackC;

    printint(stackA);
    printchar(10);
    printTowers(tempA, tempB, tempC);

    while(!solved(tempA, tempB, tempC))
    {
        if(head(tempA) != 0 || head(tempC) != 0)
        {
            int headA = head(tempA);
            int headC = head(tempC);

            if(legalMove(tempA, tempC))
            {
                printchar(65);
                printint(2);
                printchar(67);
                printchar(10);
                transVal = head(tempA);
                tempA = pop(tempA);
                tempC = push(transVal, tempC);
            } else {
                printchar(67);
                printint(2);
                printchar(65);
                printchar(10);
                transVal = head(tempC);
                tempC = pop(tempC);
                tempA = push(transVal, tempA);
            }
        }
        printTowers(tempA, tempB, tempC);
        printchar(10);

        if(solved(tempA, tempB, tempC))
            break;

        if(head(tempA) != 0 || head(tempB) != 0)
        {
            int headA = head(tempA);
            int headB = head(tempB);
            
            if(legalMove(tempA, tempB))
            {
                printchar(65);
                printint(2);
                printchar(66);
                printchar(10);
                transVal = head(tempA);
                tempA = pop(tempA);
                tempB = push(transVal, tempB);
            } else {
                printchar(66);
                printint(2);
                printchar(65);
                printchar(10);
                transVal = head(tempB);
                tempB = pop(tempB);
                tempA = push(transVal, tempA);
            }
        }
        printTowers(tempA, tempB, tempC);
        printchar(10);
        
        if(solved(tempA, tempB, tempC))
            break;
        
        if(head(tempB) != 0 || head(tempC) != 0)
        {
            int headB = head(tempB);
            int headC = head(tempC);

            if(legalMove(tempB, tempC))
            {
                printchar(66);
                printint(2);
                printchar(67);
                printchar(10);
                transVal = head(tempB);
                tempB = pop(tempB);
                tempC = push(transVal, tempC);
            } else {
                printchar(67);
                printint(2);
                printchar(66);
                printchar(10);
                transVal = head(tempC);
                tempC = pop(tempC);
                tempB = push(transVal, tempB);
            }
        }
        printTowers(tempA, tempB, tempC);
        printchar(10);
    }

    return true;
}

int main()
{
    int tower = 0;

    //First, we need to read in the number of discs
    int numDiscs = readint();

    //Create the initial stack
    for(int i = 0; i < numDiscs; i++)
    {
        tower = push(numDiscs - i, tower);
        //Debug
        printTower(tower);
    }
 
    //Print the discs
    printDiscs(tower, 0);

    if(numDiscs % 2 == 0)
        solveEven(tower, 0, 0);
    else
        solveOdd(tower, 0, 0);

    return 0;
}
