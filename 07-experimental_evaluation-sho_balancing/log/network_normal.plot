set terminal postscript enhanced font "Times" 18;
set palette gray;
set style line 1 lt 1 lw 2;
set style line 2 lt 5 lw 2;
set style line 3 lt 3 lw 2;
set style line 4 lt 4 lw 2;
set yrange [-105.9:-103.5];
set y2range [-5:430];
set y2tics 0, 40;
set ytics nomirror;
unset xtics;
set xlabel 'Time';
set ylabel 'dBm';
set y2label 'kBytes';
plot '@1' using 2:xticlabels(1) axis x1y1 with lines ls 1 title 'UL RSSI (cell 1)', 
     '@1' using 3:xticlabels(1) axis x1y1 with lines ls 3 title 'UL RSSI (cell 2)',
     '@1' using 4:xticlabels(1) axis x1y2 with lines ls 2 title 'HSUPA traffic (cell 1)', 
     '@1' using 5:xticlabels(1) axis x1y2 with lines ls 4 title 'HSUPA traffic (cell 2)
