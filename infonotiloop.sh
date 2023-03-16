#!/bin/dash

hdir="$(dirname "$(readlink -f "$0")")"

writeinfo () {

    cd "$hdir"/iwaited

    # simple is the best
    line1noti=$(paste -d '' datetime dlm1 batstatus dlm2 batlevel dlm2 batnotistate)
    line2noti=$(paste -d '' constate dlm1 curessid dlm1 curipaddr dlm1 screenbl)
    line3noti=$(paste -d '' audiomutestate dlm1 volumelevel)

    notify-send -h string:x-canonical-private-synchronous:infonoti \
        " " "$line1noti\n\n$line2noti\n\n$line3noti\n_"
    cd ../
}
writeinfo

i=1
while true; do
    if [ $((i)) -gt 60 ]; then
        notify-send -t 700 -h string:x-canonical-private-synchronous:infonoti \
            "'" " --- Closed Info --- \n_"
        "$hdir"/loopswitch.sh stoploops &
        break
    fi
    i=$((i+1))
    inotifywait -qq --event modify "$hdir"/iwaited/*
    writeinfo
done & > /dev/null 2>&1
