#!/bin/dash

hdir="$(dirname "$(readlink -f "$0")")"

infoupdate () {
    echo "Audio $(pactl get-sink-mute @DEFAULT_SINK@)" > "$hdir"/iwaited/audiomutestate
    echo "Volume: $(pactl get-sink-volume @DEFAULT_SINK@ | awk '/Volume: / {print $5,$12}')" > "$hdir"/iwaited/volumelevel
    echo "Screen* $(brightnessctl | awk -F '[()]' '/Current brightness: / {print $2}')" > "$hdir"/iwaited/screenbl
}

ckpid=$(ps -A | awk '/infonotiloop.sh/ {print $1}')
if [ -z "$ckpid" ]; then
    infoupdate
    "$hdir"/infonotiloop.sh &
    sleep 0.3
    "$hdir"/loopswitch.sh startloops &
else
    kill -9 "$ckpid"
    notify-send -t 700 -h string:x-canonical-private-synchronous:infonoti \
        "'" " --- Closed Info --- \n_"
    "$hdir"/loopswitch.sh stoploops &
fi
