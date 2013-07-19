#!/bin/bash

best=99999999.0
worst=0.0
score=0
score_acc=0
score_count=0

for f in $( ls ../src/sa/run-temp_125-* ); do 
    score=$( grep -F 'Best difference' ${f} | cut -d'>' -f2 )
    score=$( echo "$( echo "${score}" | cut -d'e' -f1 | tr -d '.' )0" )
    if [ ${score} -lt 1000000 ]; then
        score="${score}0"
    fi
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

for f in $( ls ../src/sa/run-temp_125-* ); do 
    score=$( grep -F 'Best difference' ${f} | cut -d'>' -f2 )
    score=$( echo "$( echo "${score}" | cut -d'e' -f1 | tr -d '.' )0" )
    if [ ${score} -lt 1000000 ]; then
        score="${score}0"
    fi
    score_acc=$( echo "(${score} - ${mean}) * (${score} - ${mean})" | bc )
    score_count=$( echo "${score_count} + 1" | bc )
done 

std_dev=$( echo "scale=6;${score_acc}/${score_count}" | bc )
echo "Std.dev = ${std_dev}"


