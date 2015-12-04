import os
import sys

with open('exp2-c-graph.txt', 'r') as f1:
    with open('exp2-c-graph-t.txt', 'w') as f2:
        f2.write(f1.readline())
        f2.write(f1.readline())
        f2.write(f1.readline())
        f2.write(f1.readline())
        for line in f1:
            a, b = [int(x) for x in line.split('\t')]
            f2.write(str(a+1) + '\t' + str(b+1) + '\n')