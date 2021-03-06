#include <vector>
#include <cstdio>
#include <cstdlib>

using namespace std;

int main()
{
  vector<vector<int> > v(1000);
  for (int i = 0; i < 1000; i++) {
    v[i].resize(1000);
  }
  while (!feof(stdin)) {
    int op, a, b, c, d;
    op = getchar();
    if (op == EOF) break;
    fread(&a, sizeof(int), 1, stdin);
    fread(&b, sizeof(int), 1, stdin);
    fread(&c, sizeof(int), 1, stdin);
    fread(&d, sizeof(int), 1, stdin);
    printf("%d (%d,%d) (%d,%d)\n", op, a, b, c, d);
    for (int i = a; i <= c; i++) {
      for (int j = b; j <= d; j++) {
        if ( op == 1 ) { v[i][j]++; }
        else if ( op == 2 ) { if (v[i][j] > 0) v[i][j]--; }
        else if ( op == 3 ) { v[i][j] += 2; }
        else {
          fprintf(stderr, "Unknown op: %d\n", op);
          goto count;
        }
      }
    }
  }
 count:
  int c = 0;
  for (int i = 0; i < 1000; i++)
    for (int j = 0; j < 1000; j++)
      c += v[i][j];
  printf("%d\n", c);
}
