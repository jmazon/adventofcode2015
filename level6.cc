#include <vector>
#include <cstdio>
#include <cstdlib>

using namespace std;

int main()
{
  vector<vector<bool> > v(1000);
  for (int i = 0; i < 1000; i++) {
    v[i].resize(1000);
  }
  while (!feof(stdin)) {
    int op, a, b, c, d;
    op = getchar();
    fread(&a, sizeof(int), 1, stdin);
    fread(&b, sizeof(int), 1, stdin);
    fread(&c, sizeof(int), 1, stdin);
    fread(&d, sizeof(int), 1, stdin);
    printf("%d (%d,%d) (%d,%d)\n", op, a, b, c, d);
    for (int i = a; i <= c; i++) {
      for (int j = b; j <= d; j++) {
        if ( op == 1 ) { v[i][j] = true; }
        else if ( op == 2 ) { v[i][j] = false; }
        else if ( op == 3 ) { v[i][j] = !v[i][j]; }
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
      if (v[i][j])
        c++;
  printf("%d\n", c);
}
