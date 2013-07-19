#!/bin/bash

if [ $# -gt 0 ]; then
    cat ../data/cell_powers.txt | cut -d' ' -f1-7 > /tmp/.de_powers_1.txt
    cat ../data/cell_powers.txt | cut -d' ' -f9-  > /tmp/.de_powers_3.txt
    rm -f /tmp/.de_powers_2.txt

    echo "pilot" >> /tmp/.de_powers_2.txt
    for l in $( cat $1 | tail -n27 | grep '=' | tr -d ' ' ); do
        pilot=$( echo "${l}" | cut -d'=' -f2 )
        pilot=$( echo "scale=0; ((${pilot} * 10) + 0.5) / 1" | bc )
        echo ${pilot} >> /tmp/.de_powers_2.txt
    done

    #
    # create power configuration file, based on the given solution 
    #
    paste -d' ' /tmp/.de_powers_1.txt /tmp/.de_powers_2.txt /tmp/.de_powers_3.txt > /tmp/.de_powers.txt

    #
    # dump 2D map data, based on the created power configuration file
    #
    CURR_DIR=$( pwd )
    cd ../src/eval
    ./create_map.py /tmp/.de_powers.txt ../../data/dl_path_loss/ ../../data/ul_path_loss ../../data/dl_path_loss/best_server.GRD 370 661 /tmp/de
    cd ${CURR_DIR}
else
    echo "Usage:"
    echo "$0 [DE output file]"
fi
