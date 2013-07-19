#!/bin/bash

if [ $# -gt 2 ]; then
    OUTPUT="$3"
    echo "Rendering into ${OUTPUT} ..."
    cp "$1" /tmp/.data_file
    P=$(cat "$2" | sed -e "s/@1/\/tmp\/\.data_file/g") ; gnuplot -p -e "${P}" > ${OUTPUT}
    #gsview ${OUTPUT}
    feh -. ${OUTPUT}
else
    echo "$0 [data file] [plot file] [output file]"
fi
