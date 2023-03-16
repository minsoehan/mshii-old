#!/bin/dash

hdir="$(dirname "$(readlink -f "$0")")"

while true; do
    date "+%F %A %R | %r" > "$hdir"/iwaited/datetime
    sleep 1
    ckmpid=$(ps -A | awk '/infonotiloop.sh/ {print $1}')
    [ -z "$ckmpid" ] && break
done & > /dev/null 2>&1
