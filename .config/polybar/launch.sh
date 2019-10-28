#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
#polybar bar1 &
#polybar bar1-bottom &
#polybar bar2 &
#polybar bar2-bottom &
#polybar bar3 &
#polybar bar3-bottom &

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload default-bar &
  done
else
  polybar --reload example &
fi

echo "Bars launched..."
