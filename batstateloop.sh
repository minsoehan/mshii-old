#!/bin/dash

hdir="$(dirname "$(readlink -f "$0")")"

while true; do
    echo "BAT: $(cat /sys/class/power_supply/BAT0/status)" > "$hdir"/iwaited/batstatus
    echo "$(cat /sys/class/power_supply/BAT0/capacity)%" > "$hdir"/iwaited/batlevel
    sleep 15
    ckmpid=$(ps -A | awk '/infonotiloop.sh/ {print $1}')
    [ -z "$ckmpid" ] && break
done & > /dev/null 2>&1
