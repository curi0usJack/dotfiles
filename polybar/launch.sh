#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar top >>/tmp/topbar.log 2>&1 &
polybar bottom >>/tmp/bottombar.log 2>&1 &
# polybar external >>/tmp/external.log 2>&1 &

echo "Bars launched..."
