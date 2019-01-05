#include "libasm.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define RUN(f) run(#f, f);

void run(const char *name, int (*f)()) {
    int   len = strlen(name);
    char *buf = malloc(80 - len);
    memset(buf, '.', 80 - len);
    printf("%s%s", name, buf);

    int res = f();
    if (res == 0)
        printf(" OK!\n");
    else
        printf(" KO!\n");
    free(buf);
}

int test_bzero() {
    char buf[] = "hello";
    b_bzero(buf, 3);
    for (int i = 0; i < 3; i++) {
        if (buf[i] != 0) {
            printf("index %d != 0\n", i);
            return 1;
        }
    }
    if (buf[3] == 0) {
        printf("overwrite\n");
        return 1;
    }

    return 0;
}

int main() { RUN(test_bzero); }
