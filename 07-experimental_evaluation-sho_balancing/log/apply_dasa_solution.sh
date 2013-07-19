#!/bin/bash

if [ $# -gt 0 ]; then
    cat ../data/cell_powers.txt | cut -d' ' -f1-7 > /tmp/.dasa_powers_1.txt
    cat ../data/cell_powers.txt | cut -d' ' -f9-  > /tmp/.dasa_powers_3.txt
    rm -f /tmp/.dasa_powers_2.txt

    echo "pilot" >> /tmp/.dasa_powers_2.txt
    for l in $( head -n32 $1 | tail -n 25 | tr -d ' ' ); do
        pilot=$( echo "${l}" | cut -d'=' -f2 )
        pilot=$( echo "scale=0; ((${pilot} * 10) + 0.5) / 1" | bc )
        echo ${pilot} >> /tmp/.dasa_powers_2.txt
    done

    #
    # create power configuration file, based on the given solution 
    #
    paste -d' ' /tmp/.dasa_powers_1.txt /tmp/.dasa_powers_2.txt /tmp/.dasa_powers_3.txt > /tmp/.dasa_powers.txt

    #
    # dump 2D map data, based on the created power configuration file
    #
    CURR_DIR=$( pwd )
    cd ../src/eval
    ./create_map.py /tmp/.dasa_powers.txt ../../data/dl_path_loss/ ../../data/ul_path_loss ../../data/dl_path_loss/best_server.GRD 370 661 /tmp/dasa
    cd ${CURR_DIR}
else
    echo "Usage:"
    echo "$0 [DASA stat file]"
fi
