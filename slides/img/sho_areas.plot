set terminal png enhanced size 2560,2048 font "Times" 40;
set output 'sho_areas_initial.png';
set view map;
set pm3d map;
set palette gray;
set tics scale 1,0;
set cbtics font "Times" 30 ("Ok" 0, "Interf." 1);
set xrange [-0.5:17];
set yrange [-0.5:10];
unset key;
set xlabel 'km';
set ylabel 'km';
splot 'sho_areas_initial.dat' with points pt 5 ps 1 palette;

set output 'sho_areas_final.png';
splot 'sho_areas_final.dat' with points pt 5 ps 1 palette;
