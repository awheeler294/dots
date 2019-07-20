#! /usr/bin/sh
#echo "kaunchibng Polybar" 1>&2
# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

#PRIMARY_MONITOR="$(xrandr --listmonitors | grep "0:" | cut -d ' ' -f6)"
# Launch bar
#MONITOR="$PRIMARY_MONITOR" polybar main &

echo "$(polybar --list-monitors | cut -d":" -f1)"
for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar --reload status &
    echo "Launched bar 'status' on monitor $m" 1>&2
done

echo "Bar launched"
#echo "Bar launched" 1>&2
