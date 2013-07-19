#!/bin/bash

CMD=$( cat <<EOF
set terminal epslatex font "Helvetica" 10;
set output "coverage_area.tex";
set view map;
set pm3d map;
set palette color maxcolors 2;
set tics scale 1,0;
set cbtics ('\$\overline{A_{\mathrm{covered}}}\$' 0, '\$A_{\mathrm{covered}}\$' 1);
set xrange [-0.5:17];
set yrange [-0.5:10];
unset key;
set xlabel 'km';
set ylabel 'km';
splot 'coverage_area.dat' with points pt 5 ps 1 palette;
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
  \input{coverage_area.tex}
\end{center}
\end{document}
EOF
)

echo -n '.' ; gnuplot -p -e "${CMD}"
echo "${TEX}" > cov_area.tex
echo -n '.' ; latex cov_area.tex > /dev/null
echo -n '.' ; dvips -E cov_area.dvi -o cov_area.eps > /dev/null 2>&1
echo -n '.' ; ps2pdf -dEPSCrop cov_area.eps coverage_area.pdf > /dev/null


