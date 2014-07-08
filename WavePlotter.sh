#!/bin/bash
for file in *.wav ; do
        echo $file

        sox -r 1024 $file /tmp/$file.dat
        grep -v '^;' /tmp/$file.dat > /tmp/$file.plt
        rm /tmp/*.dat

        cat << EOF > /tmp/plottemp
set title "Waveform of $file\n\nGraphs by http://datanoise.net"
set style line 1 lc rgb '#8b1a0e' pt 1 ps 1 lt 1 lw 2 # --- red
set style line 2 lc rgb '#5e9c36' pt 6 ps 1 lt 1 lw 2 # --- green
set style line 11 lc rgb '#808080' lt 1
set border 3 back ls 11
set tics nomirror
set style line 12 lc rgb '#808080' lt 0 lw 1
set grid back ls 12
set xrange [0:0.585]
set yrange [-1.0:1.0]
set ylabel "Value"
set xlabel "Sample"
set term pngcairo
set output "graphs/$file.png"
plot '/tmp/$file.plt' with lines linestyle 1 notitle
EOF
        gnuplot /tmp/plottemp
done
