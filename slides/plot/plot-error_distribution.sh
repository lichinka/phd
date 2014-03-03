#!/bin/bash

CELL_FILE=$1
WLOGS=${@:2}

if [ -n "${CELL_FILE}" ] && [ -n "${WLOGS}" ]; then
    rm -f /tmp/.diff.dat
    #
    # grep out the prediction and measurement data
    #
    for C in $( cat ${CELL_FILE} ); do
        LOG="$( grep -l "${C}" ${WLOGS} )"
        egrep '^#' ${LOG} | sed -e 's/^#//' > /tmp/.${C}.dat
        #
        # optimized parameters
        #
        OPTIM="$( cat ${LOG} | grep -A4 '\[Solution\]' | tail -n+2 | cut -d'=' -f2 | tr -d ' ' | tr '\n' ',' | sed -e 's/,$//' )"
        #
        # prepare data for histogram
        #
        CMD=$( cat <<EOF
import sys
import numpy as np

params = {}
params['default'] = np.array ([38.0, 32.0, -12.0, 0.1])
params['optim']   = np.array ([${OPTIM}])

data_file="/tmp/.${C}.dat"

pwr     = np.genfromtxt (fname=data_file, skip_header=1, usecols=(0))
rcv     = np.genfromtxt (fname=data_file, skip_header=1, usecols=(1))
logHa   = np.genfromtxt (fname=data_file, usecols=(2))
pl_Ha   = np.genfromtxt (fname=data_file, usecols=(3))
pl_freq = np.genfromtxt (fname=data_file, usecols=(4))
clut    = np.genfromtxt (fname=data_file, usecols=(5))
nlos    = np.genfromtxt (fname=data_file, usecols=(6))
logD    = np.genfromtxt (fname=data_file, usecols=(7))
pl_ant  = np.genfromtxt (fname=data_file, usecols=(8))

#
# the path loss with different parameter sets
#
for set in params.keys ( ):
    L  = params[set][0] 
    L += params[set][1] * logD 
    L += params[set][2] * logHa 
    L += params[set][3] * logHa * logD
    L -= pl_Ha
    L += pl_freq + clut + nlos + pl_ant

    err = rcv - pwr + L
    for e in err:
        print ("%s\t%.5f" % (set, e))
    sys.stderr.write ("*** INFO: [${C}] %s parameter set, mean [%.5f], std.dev. [%.5f]\n" % (set.upper ( ),
                                                                                             np.mean (err),
                                                                                             np.std (err)))
EOF
)
        python -c "${CMD}" >> /tmp/.diff.dat
    done
    for SET in default optim; do
        egrep "^${SET}" /tmp/.diff.dat > /tmp/.${SET}.dat
        #
        # create histogram data
        #
        CMD=$( cat <<EOF
import sys
import numpy as np

diff = np.array ([])
a = np.genfromtxt ("/tmp/.${SET}.dat", usecols=(1))
diff = np.concatenate ( (diff, a) )
bins = [i for i in range (-40, 45, 5)]
bins.insert (0, -255)
bins.append (255)
hist, bins = np.histogram (diff, 
                           bins=bins,
                           density=True)
for idx in range (len (bins) - 1):
    if idx >= len (hist):
        h = 0.0
    else:
        h = float (hist[idx])
    print ('%d\t%.5f' % (bins[idx],
                        h))
sys.stderr.write ("*** INFO: [${SET}], mean [%.5f], std.dev. [%.5f]\n" % (a.mean ( ), 
                                                                          a.std ( )))

EOF
)
        python -c "${CMD}" > /tmp/.plot.dat
        #
        # ... and display it
        #
        PLOT_CMD=$( cat <<EOF
set term postscript eps enhanced font "Helvetica,20";
set output "${SET}_distribution.eps";
set xlabel "Difference [dB]";
set xtics rotate by -45 ("[-255,-40)" 0, "[-40,-35)" 1, "[-35,-30)" 2, "[-30,-25)" 3, "[-25,-20)" 4, "[-20,-15)" 5, "[-15,-10)" 6, "[-10,-5)" 7, "[-5,0)" 8, "[0,5)" 9, "[5,10)" 10, "[10,15)" 11, "[15,20)" 12, "[20,25)" 13, "[25,30)" 14, "[30,35)" 15, "[35,40)" 16, "[40,255]" 17) font "Helvetica,13";
set ylabel "Probability density distribution";
set yrange [0:0.045];
set format y "%.3f";
set grid ytics;
plot '/tmp/.plot.dat' using 2 with boxes lt -1 fs pattern 2 notitle;
EOF
)
        echo "${PLOT_CMD}"
        gnuplot -p -e "${PLOT_CMD}"
    done
else
    echo "Usage: $0 [cell file] [worker LOG files ...]"
    echo "Generates error-distribution plots between measurements and predictions for the given cells.-"
    echo
    exit -1
fi

