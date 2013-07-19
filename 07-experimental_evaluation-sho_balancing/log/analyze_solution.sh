#!/bin/bash

if [ $# -gt 0 ]; then
    pixel_count=$( cat $1 | wc -l )

    not_covered=$( grep '0$' $1 | wc -l )
    not_covered=$( echo "scale=4;(${not_covered}/${pixel_count})*100" | bc )
    no_sho=$( grep '5$' $1 | wc -l )
    no_sho=$( echo "scale=4;(${no_sho}/${pixel_count})*100" | bc )
    normal_sho=$( grep '1$' $1 | wc -l )
    normal_sho=$( echo "scale=4;(${normal_sho}/${pixel_count})*100" | bc )
    no_sho_dl=$( grep '2$' $1 | wc -l )
    no_sho_dl=$( echo "scale=4;(${no_sho_dl}/${pixel_count})*100" | bc )
    no_sho_ul=$( grep '3$' $1 | wc -l )
    no_sho_ul=$( echo "scale=4;(${no_sho_ul}/${pixel_count})*100" | bc )

    total=$( echo "scale=2;${not_covered}+${no_sho}+${normal_sho}+${no_sho_dl}+${no_sho_ul}" | bc )

    echo "Not covered       = ${not_covered}"
    echo "Covered, no SHO   = ${no_sho}"
    echo "Normal SHO        = ${normal_sho}"
    echo "No SHO DL, SHO UL = ${no_sho_dl}"
    echo "SHO DL, no SHO UL = ${no_sho_ul}"
    echo "                 -------------------"
    echo "Total             = ${total}"
else
    echo "Usage:"
    echo "$0 [2D map state file]"
fi
