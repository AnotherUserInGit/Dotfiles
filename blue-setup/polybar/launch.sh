#!/usr/bin/env sh

# an easy script that restarts polybar in case of i3 refreshing
# PS: i found this script on the internet


# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch polybar
polybar bar &
