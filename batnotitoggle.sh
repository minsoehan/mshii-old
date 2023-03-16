#!/bin/dash

sdir="$(dirname "$(readlink -f "$0")")"
bnst=$(cat /tmp/mshbattnotionoff)

case $1 in
    "")
        if [ $((bnst)) -eq 1 ]; then
            echo "0" > /tmp/mshbattnotionoff && echo "Noti-off" > "$sdir"/iwaited/batnotistate
        else
            echo "1" > /tmp/mshbattnotionoff && echo "Noti-on" > "$sdir"/iwaited/batnotistate
        fi
        ;;
    enable)
        echo "1" > /tmp/mshbattnotionoff && echo "Noti-on" > "$sdir"/iwaited/batnotistate
        ;;
    disable)
        echo "0" > /tmp/mshbattnotionoff && echo "Noti-off" > "$sdir"/iwaited/batnotistate
        ;;
    *)
        notify-send -t 1800 " " "Do enable, disable or leaving blank.\n_"
        exit 0
        ;;
esac
