#!/bin/bash

LOGS="$@"

if [ $# -gt 1 ]; then
    i=0
    for l in ${LOGS}; do
        i=$(( ${i} + 1 ))
        # for SA only
        # grep ':' ${l} | tr -s ' ' | cut -d' ' -f3 | tail -n+2 > /tmp/${i}

        # for DASA only
        #sort -nr ${l} > /tmp/${i}

        grep score ${l} | tr -s ' ' | cut -d' ' -f4 | sort -nr > /tmp/${i}
        echo -n "."
    done

    echo
    rm -f /tmp/.conv
    touch /tmp/.conv


    for f in $( seq 1 ${i} ); do
        cat /tmp/${f} | paste - /tmp/.conv > /tmp/.foo
        cp /tmp/.foo /tmp/.conv
        echo -n "."
    done

    CMD="$( cat <<EOF
import numpy as np

t = np.genfromtxt (fname='/tmp/.conv')
mi = t.min (axis=1)
av = (t.sum (axis=1))/t.shape[1]
ma = t.max (axis=1)

for i in range (mi.size):
    print ("%d\t%.2f\t%.2f\t%.2f" % (i+1, mi[i], av[i], ma[i]))

EOF
)"
    python -c "${CMD}" > /tmp/.foo

    CMD="$( cat <<EOF
set terminal postscript eps enhanced monochrome font "Helvetica,20";
set output "algorithm_convergence.eps";
set grid;
set format x "%.1e";
set xtics font ",14";
set xtics 20000;
set xlabel 'Number of evaluations';
set yrange [2280000.00:2460000.00];
set log y;
set format y "%.2e";
set ytics 40000;
set ytics font ",14";
set ylabel 'Objective-function value';
plot '/tmp/.foo' using 1:2 with lines lw 2 title 'Best', \
     '/tmp/.foo' using 1:3 with lines lw 2 title 'Mean', \
     '/tmp/.foo' using 1:4 with lines lw 2 title 'Worst';
EOF
)"
    echo "${CMD}"
    gnuplot -p -e "${CMD}"
else
    echo "Usage: $0 [log files ...]"
    echo "Creates the convergence plot from the given log files.-"
    exit -1
fi

