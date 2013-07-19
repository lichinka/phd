set terminal postscript enhanced font "Helvetica" 15;
set output "algorithm_convergence.eps";
set palette gray;
set style line 1 lt 1 lw 2;
set style line 2 lt 5 lw 2;
set style line 3 lt 3 lw 2;
set grid;
set format x "%.1e";
set xrange [1000:100000];
set xtics font ",12"
set xlabel 'Number of evaluations';
set yrange [2280000.00:2400000.00];
set format y "%.2e"
set ytics font ",12" 
set ylabel 'Objective-function value';
plot 'de_convergence.dat' using ($1*1000):2 axis x1y1 with lines ls 3 title 'DE', \
     'dasa_convergence.dat' using ($1*1000):2 axis x1y1 with lines ls 1 title 'DASA', \
     'sa_convergence.dat' using ($1*1000):2 axis x1y1 with lines ls 2 title 'SA'
