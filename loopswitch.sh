#!/bin/dash

ck1pid=$(ps -A | awk '/datetimeloop.sh/ {print $1}')
ck2pid=$(ps -A | awk '/batstateloop.sh/ {print $1}')
ck3pid=$(ps -A | awk '/netstateloop.sh/ {print $1}')

hdir="$(dirname "$(readlink -f "$0")")"

case $1 in
    startloops)
        [ -z $ck1pid ] && "$hdir"/datetimeloop.sh & > /dev/null 2>&1
        [ -z $ck2pid ] && "$hdir"/batstateloop.sh & > /dev/null 2>&1
        [ -z $ck3pid ] && "$hdir"/netstateloop.sh & > /dev/null 2>&1
        ;;
    stoploops)
        [ ! -z $ck1pid ] && kill -9 "$ck1pid" > /dev/null 2>&1
        [ ! -z $ck2pid ] && kill -9 "$ck2pid" > /dev/null 2>&1
        [ ! -z $ck3pid ] && kill -9 "$ck3pid" > /dev/null 2>&1
        ;;
    *)
        exit 0
esac
