#!/bin/bash

best=99999999.0
worst=0.0
score=0
score_acc=0
score_count=0

for f in $( ls ../src/de/run-np_100-cr_0.8-f_0.5-gmax_1000-* ); do 
    score=$( grep -F 'Objective function value' ${f} | cut -d':' -f2 )
    if [ -n "${score}" ]; then
        score_acc=$( echo "${score_acc} + ${score}" | bc )
        score_count=$( echo "${score_count} + 1" | bc )
        echo "${score}"

        update_best=$( echo "${best} > ${score}" | bc )
        if [ ${update_best} -eq 1 ]; then
            best=${score}
        fi
        update_worst=$( echo "${worst} < ${score}" | bc )
        if [ ${update_worst} -eq 1 ]; then
            worst=${score}
        fi
    fi
done 

mean=$( echo "scale=6;${score_acc}/${score_count}" | bc )

echo
echo "Best  = ${best}"
echo "Worst = ${worst}"
echo "Mean  = ${mean}"

#
# calculate std. deviation
#
score=0
score_acc=0
score_count=0

for f in $( ls ../src/de/run-np_100-cr_0.8-f_0.5-gmax_1000-* ); do 
    score=$( grep -F 'Objective function value' ${f} | cut -d':' -f2 )
    if [ -n "${score}" ]; then
        score_acc=$( echo "(${score} - ${mean}) * (${score} - ${mean})" | bc )
        score_count=$( echo "${score_count} + 1" | bc )
    fi
done 

std_dev=$( echo "scale=6;${score_acc}/${score_count}" | bc )
echo "Std.dev = ${std_dev}"

