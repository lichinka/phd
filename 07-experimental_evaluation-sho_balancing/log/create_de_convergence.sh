#!/bin/bash

if [ $# -gt 0 ]; then
    score_acc=0
    best=99999999.0
    for score_count in $( seq 0 999 );
    do
        for score in $( grep -F "Generation ${score_count}/1000" $1 | egrep -o '[0-9]+\.[0-9]+$' ); 
        do 
            update_best=$( echo "${best} > ${score}" | bc )
            if [ ${update_best} -eq 1 ]; then
                best=${score}
            fi
        done
        echo "${best}"
    done 
else
    echo "$0 [DE log file]"
fi
