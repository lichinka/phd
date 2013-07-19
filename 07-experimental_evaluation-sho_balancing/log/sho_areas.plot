#!/bin/bash

CMD=$( cat <<EOF
set terminal epslatex font "Helvetica" 15;
set output ".sho_areas_initial.tex";
set view map;
set pm3d map;
set palette color maxcolors 5;
set tics scale 1,0;
set cbtics ('Uncovered' 0, 'Covered, no SHO' 4, 'SHO' 1, 'no SHO$^{\downarrow}$, SHO$^{\uparrow}$' 2, 'SHO$^{\downarrow}$, no SHO$^{\uparrow}$' 3);
set xrange [-0.5:17];
set yrange [-0.5:10];
set nokey;
set xlabel 'km';
set ylabel 'km';
splot 'sho_areas_initial.dat' with points pt 5 ps 1 palette;
EOF
)
gnuplot -p -e "${CMD}"
latex sho_areas_initial.tex

