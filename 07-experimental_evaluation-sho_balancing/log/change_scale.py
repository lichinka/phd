#!/usr/bin/env python2


import sys

in_file = sys.argv[1]

with open (in_file, 'r') as f:
    for l in f:
        x, y, v = l.split (' ')
        v = int (v)
        print '%6.2f\t%6.2f\t%d' % ((int(x)*25) / 1000.0,
                                    (int(y)*25) / 1000.0,
                                    v)
f.close ( )
