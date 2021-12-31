#!/usr/bin/env sh

colors() {
    [ "$1" -lt "15" ] && printf "#ff5555" && exit
    [ "$1" -lt "35" ] && printf "#ffb86c" && exit
    [ "$1" -lt "60" ] && printf "#f1fa8c"    && exit
    printf "#d8d8d2"
}

icona() {
    [ "$1" -lt "15" ] && printf "" && exit
    [ "$1" -lt "35" ] && printf "" && exit
    [ "$1" -lt "60" ] && printf "" && exit
    [ "$1" -lt "80" ] && printf "" && exit
    printf ""
}

IC_CURRENT="^c#f1fa8c^"
IC_PLUG="^c#d8d8d2^"

acpi > /tmp/acpi_info
while read line; do
    percent="$(echo "$line" | awk -F ', ' '{print $2}' | sed 's/.$//')"

    if echo "$line" | grep "Discharging," > /dev/null; then
        # DESCARREGANT
        printf "^c$(colors "$percent")^"
        printf "$(icona "$percent") "
        printf "$percent%%"

        time_left="$(echo "$line" | awk '{print $5}' | sed "s/:[0-9][0-9]$//g")"
        printf " ($time_left)"

    elif echo "$line" | grep "Full" > /dev/null; then
        # COMPLETAMENT CARREGADA
        printf "$IC_PLUG 100%%"

    elif ! echo "$line" | grep "Unknown" > /dev/null; then
        # CARREGANT
        printf "$IC_CURRENT $IC_PLUG $percent%%"

    fi
done < /tmp/acpi_info
