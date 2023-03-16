#!/bin/dash

hdir="$(dirname "$(readlink -f "$0")")"

while true; do
    constate=$(cat /sys/class/net/wlo1/operstate)
    echo "WiFi Connection: "$constate"" > "$hdir"/iwaited/constate
    echo "ESSID: "$(iwgetid -r)"" > "$hdir"/iwaited/curessid
    echo "IP: "$(ip addr show wlp0s20f3 | awk '/inet 192.168/ {print $2}')"" > "$hdir"/iwaited/curipaddr
    sleep 30
    ckmpid=$(ps -A | awk '/infonotiloop.sh/ {print $1}')
    [ -z "$ckmpid" ] && break
done & > /dev/null 2>&1
