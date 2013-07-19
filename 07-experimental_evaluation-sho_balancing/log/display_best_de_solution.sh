for f in $(ls ../src/de/run-np_100-cr_0.8-f_0.5-gmax_1000-*); do 
    grep -F 'Objective function value' ${f}
done | sort -nk4

grep -r 2286292.000000000000000 ../src/de/run-np_100-cr_0.8-f_0.5-gmax_1000-*
