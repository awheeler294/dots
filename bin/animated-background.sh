#!/bin/bash

WALLPAPER_DIR=$HOME/Pictures/gif/
wals=$(ls $WALLPAPER_DIR | shuf)
wals_len=$(wc -w <<< $wals)

pkill xwinwrap

#echo $wals
#echo $wals_len

n=0
for g in $(xrandr | grep " connected" | sed 's/ primary//g' | cut -d ' ' -f 3); do
   n=$(( $n + 1 ))
   #echo $n
   
   f=$(echo $wals | cut -d" " -f$n)
   #echo $f
   
   xwinwrap -ov -ni -g $g -- mpv -wid WID --keepaspect=yes --loop $WALLPAPER_DIR/$f &
   
   n=$(( $n % $wals_len ))
   #echo $n
done
