// C++ first program
#include <iostream>
using namespace std;
/*this is a comment*/

int findAnswer(int N, int K, int M)
{
    i;
    long long int r = 0; /* another one */

    for (i = 1; i <= N; i++)
    {
        r = r * 10 + 9;
    }

    long long int u = r - (r % M) - M * (K - 1);

    return u;
}

int main()
{
    /* here is the third one*/ int N = 9;
    int K = 6;

    /* the final one */ int M = 4;

    cout << findAnswer(N, K, M);
    return 0;
}