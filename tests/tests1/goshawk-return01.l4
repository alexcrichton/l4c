//test return 70600674
//finds the greatest product of four adjacent numbers in any given
//direction in the 20 by 20 input grid

int prod_down(int i, int j, int[][] nums);
int prod_right(int i, int j, int[][] nums);
int prod_down_left(int i, int j, int[][] nums);
int prod_down_right(int i, int j, int[][] nums);

int main()
{
    int i;
    int j;
    int max_prod = 0;

    int[][] nums = alloc_array(int[], 20);
    for (i = 0; i < 20; i++) {
        nums[i] = alloc_array(int, 20);
    }

    for (i = 0; i < 20; i++) {
        for (j = 0; j < 20; j++) {
            nums[i][j] = readint();
        }
    }

    for (i = 0; i < 20; i++) {
        for (j = 0; j < 17; j++) {
            int prod = prod_down(i, j, nums);
            if (prod > max_prod)
                max_prod = prod;
        }
    }

   for (i = 0; i < 17; i++) {
        for (j = 0; j < 20; j++) {
            int prod = prod_right(i, j, nums);
            if (prod > max_prod)
                max_prod = prod;
        }
    }

    for (i = 0; i < 17; i++) {
        for (j = 0; j < 17; j++) {
            int prod = prod_down_right(i, j, nums);
            if (prod > max_prod)
                max_prod = prod;
        }
    }

    for (i = 3; i < 20; i++) {
        for (j = 0; j < 17; j++) {
            int prod = prod_down_left(i, j, nums);
            if (prod > max_prod)
                max_prod = prod;
        }
    }

    return max_prod;
}

int prod_down(int i, int j, int[][] nums)
{
    int prod = 1;
    for (int k = 0; k < 4; k++) {
        prod *= nums[i][j+k];
    }
    return prod;
}

int prod_right(int i, int j, int[][] nums)
{
    int prod = 1;
    for (int k = 0; k < 4; k++)
        prod *= nums[i+k][j];
    return prod;
}

int prod_down_right(int i, int j, int[][] nums)
{
    int prod = 1;
    for (int k = 0; k < 4; k++) {
        prod *= nums[i+k][j+k];
    }
    return prod;
}

int prod_down_left(int i, int j, int[][] nums)
{
    int prod = 1;
    for (int k = 0; k < 4; k++)
        prod *= nums[i-k][j+k];
    return prod;
}                        
