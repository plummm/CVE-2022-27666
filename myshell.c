#include <stdlib.h>

int main() {
    setuid(0);
    system("/bin/bash");
}