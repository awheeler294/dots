#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

#log_flag="-l info"
log_flag=""

primary_output=$(xrandr --query | grep " primary" | cut -d" " -f1)
echo "primary_output: $primary_output"

for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
   
   if [[ $m == $primary_output ]]; then
      echo "MONITOR: $m"
      MONITOR=$m polybar --reload $log_flag primary-bar &
   else
      echo "MONITOR: $m"
      MONITOR=$m polybar --reload $log_flag default-bar &
   fi
done

#echo "Bars launched..."
