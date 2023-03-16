#!/bin/dash
# dwl battery watch script

hdir="$(dirname "$(readlink -f "$0")")"

while true; do
    batcap=$(cat /sys/class/power_supply/BAT0/capacity)
    batstatus=$(cat /sys/class/power_supply/BAT0/status)
    bnstate=$(cat "$hdir"/iwaited/batnotistate)
    if [ "$batstatus" = "Discharging" ]; then
        [ $((batcap)) -lt 20 ] && systemctl hibernate
        [ $((batcap)) -lt 25 ] && notify-send -u critical -t 12000 "BATTERY POWER" \
            "Battery power is critically low.\n$(acpi)\n.....\nCharge it NOW."
        [ "$bnstate" = "Noti-on" ] && [ $((batcap)) -lt 40 ] && notify-send -u critical -t 12000 "BATTERY POWER" \
            "Battery power is low.\n$(acpi)\n.....\nPlease charge the battery before shutdown soon."
        [ $((batcap)) -gt 50 ] && sleep 90
    else
        [ "$bnstate" = "Noti-on" ] && [ $((batcap)) -gt 80 ] && notify-send -t 7000 "BATTERY CHARGING" \
            "Battery power is now over 80%.\n$(acpi)\n.....\nIt is recommended to stop charging for battery health."
        sleep 30
    fi
    sleep 30
done &
