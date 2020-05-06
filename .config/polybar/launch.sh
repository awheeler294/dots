#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

primary_output=$(xrandr --query | grep " primary" | cut -d" " -f1)
#echo "primary_output: $primary_output"

tp=none

for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
   
   if [[ $m == $primary_output ]]; then
      tp=right
   fi

   #echo "MONITOR: $m TRAY_POSITION: $tp"
   MONITOR=$m TRAY_POSITION=$tp polybar --reload default-bar &

done

#echo "Bars launched..."
