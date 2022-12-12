#!/usr/bin/env gnuplot
set grid  #设置网格
set xlabel "x"
set ylabel "y"
set title "yhp"
plot\
    "m.dat" u 1:3 w l t "t1"
pause -1
