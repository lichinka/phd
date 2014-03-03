#!/bin/bash

DATA=$1
NFRAME=$2
OUT=movie.avi

if [ -n "${DATA}" ] && [ -n "${NFRAME}" ]; then
    echo -n "Creating frames ..."
    LINES_FRAME="$( cat ${DATA} | wc -l )"
    LINES_FRAME="$( echo "${LINES_FRAME}/${NFRAME}" | bc )"
    for i in $( seq -w 0001 ${NFRAME} ); do
        echo -n "."
        LINES="$( echo "${LINES_FRAME}*${i}" | bc )"
        head -n${LINES} ${DATA} > /tmp/.frame.dat
        PLOT_CMD=$( cat <<EOF
set term png enhanced font "Helvetica,17";
set output "frame_${i}.png";
set xlabel "Iterations";
set xrange [0:3500];
set xtics 350 font ",15";
set ylabel "Total power [Watts]";
set yrange [130:350];
set format y "%.0f";
set grid ytics;
plot '/tmp/.frame.dat' using 1:(\$3/350) with points pt 5 notitle;
EOF
)
        gnuplot -p -e "${PLOT_CMD}"
    done
    echo " done"
else
    echo "Usage: $0 [data file] [number of frames]"
    echo "Creates a graph movie containing the given number of frames.-"
    exit 1
fi
