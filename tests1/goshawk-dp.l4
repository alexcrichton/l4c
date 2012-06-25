//test return 0
// caches the sums of all rectangles in 2D-array

int sum_rect(int[][] dp, int row1, int col1, int row2, int col2)
{
    return dp[row2][col2]
        - (row1 == 0 ? 0 : dp[row1-1][col2])
        - (col1 == 0 ? 0 : dp[row2][col1-1])
        + (row1 == 0 || col1 == 0 ? 0 : dp[row1-1][col1-1]);
}

int main()
{
    int rows = readint();
    int cols = readint();
    int[][] matrix = alloc_array(int[], rows);
    for (int i = 0; i < rows; i++)
        matrix[i] = alloc_array(int, cols);

    for (int i = 0; i < rows; i++)
        for (int j = 0; j < cols; j++)
            matrix[i][j] = readint();

    int[][] dp = alloc_array(int[], rows);
    for (int i = 0; i < rows; i++)
        dp[i] = alloc_array(int, cols);

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            dp[i][j] = matrix[i][j];
            dp[i][j] += i == 0 ? 0 : dp[i-1][j];
            dp[i][j] += j == 0 ? 0 : dp[i][j-1];
            dp[i][j] -= i == 0 || j == 0 ? 0 : dp[i-1][j-1];
            //dp[i][j] = i == 0 || j == 0 ? 0 :
                //matrix[i][j] + dp[i][j-1] + dp[i-1][j] - dp[i-1][j-1];
        }
    }

    while(!eof()) {
        printint(sum_rect(dp, readint(), readint(), readint(), readint()));
        printchar(0xa);
    }

    return 0;
}
