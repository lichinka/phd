#!/bin/bash

for out in sho_areas_initial sho_areas_final; do
    CMD=$( cat <<EOF
set terminal epslatex font "Helvetica" 10;
set output "${out}.tex";
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
splot '${out}.dat' with points pt 5 ps 1 palette;
EOF
)

    TEX=$( cat <<EOF
\documentclass{article}
\usepackage{graphics}
\usepackage{nopageno}
\usepackage{txfonts}
\usepackage[usenames]{color}

\begin{document}
\fontsize{7pt}{8pt}\selectfont
\begin{center}
  \input{${out}.tex}
\end{center}
\end{document}
EOF
)
    echo -n '.' ; gnuplot -p -e "${CMD}"
    echo "${TEX}" > sho_areas.tex
    echo -n '.' ; latex sho_areas.tex > /dev/null
    echo -n '.' ; dvips -E sho_areas.dvi -o sho_areas.eps > /dev/null 2>&1
    echo -n '.' ; ps2pdf -dEPSCrop sho_areas.eps ${out}.pdf > /dev/null
done

