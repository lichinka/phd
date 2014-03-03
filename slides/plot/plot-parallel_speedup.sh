#!/bin/bash

#
# ... and display it
#
PLOT_CMD=$( cat <<EOF
set term postscript eps enhanced font "Helvetica,20";
set output "parallel_speedup_1.eps";
set key top left;
set xlabel "Number of worker processes";
set xrange [1:65];
set xtics 2;
set log x;
set ylabel "Average speedup";
set yrange [1:65];
set ytics 2;
set log y;
set grid ytics;
plot x with lines lw 2 title "Perfect speedup";
EOF
)
echo "${PLOT_CMD}"
gnuplot -p -e "${PLOT_CMD}"


PLOT_CMD=$( cat <<EOF
set term postscript eps enhanced font "Helvetica,20";
set output "parallel_speedup_2.eps";
set key top left;
set xlabel "Number of worker processes";
set xrange [1:65];
set xtics 2;
set log x;
set ylabel "Average speedup";
set yrange [1:65];
set ytics 2;
set log y;
set grid ytics;
plot x with lines lw 3 title "Perfect speedup", \
     "parallel_speedup-MW.dat" using 2:(\$3+\$6+\$9)/3 with linespoints lw 3 title "MW";
EOF
)
echo "${PLOT_CMD}"
gnuplot -p -e "${PLOT_CMD}"

PLOT_CMD=$( cat <<EOF
set term postscript eps enhanced font "Helvetica,20";
set output "parallel_speedup_3.eps";
set key top left;
set xlabel "Number of worker processes";
set xrange [1:65];
set xtics 2;
set log x;
set ylabel "Average speedup";
set yrange [1:65];
set ytics 2;
set log y;
set grid ytics;
plot x with lines lw 3 title "Perfect speedup", \
     "parallel_speedup-MW.dat" using 2:(\$3+\$6+\$9)/3 with linespoints lw 3 title "MW" ,\
     "parallel_speedup-MWD.dat" using 2:(\$3+\$6+\$9)/3 with linespoints lw 3 title "MWD";
EOF
)
echo "${PLOT_CMD}"
gnuplot -p -e "${PLOT_CMD}"

