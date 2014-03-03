#!/bin/bash

FROM_FRAME=$1
TO_FRAME=$2
OUT=$3

if [ -n "${FROM_FRAME}" ] && [ -n "${TO_FRAME}" ] && [ -n "${OUT}" ]; then
    echo -n "Creating frames ..."
    for i in $( seq -w ${FROM_FRAME} ${TO_FRAME} ); do
        echo -n "."
        montage -background '#a1a1a1' -size 760x900 null: agent_frame_${i}.png frame_${i}.png null: -gravity southeast -tile x1 -geometry -250+0 /tmp/.frame_${i}.png &
    done
    wait
    echo " done"
    echo "ffmpeg -r 15 -i /tmp/.frame_%04d.png -vcodec h264 -qscale:v 1 -s 1440x900 ${OUT}"
    ffmpeg -r 15 -i /tmp/.frame_%04d.png -vcodec h264 -qscale:v 1 -s 1440x900 ${OUT}
    #rm /tmp/.frame_*.png
else
    echo "Usage: $0 [frame start number] [frame stop number] [output movie]"
    echo "Creates a movie combining 'agent_frame_[num].png' and 'frame_[num].png'.-"
    exit 1
fi
