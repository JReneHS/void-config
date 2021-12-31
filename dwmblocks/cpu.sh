#!/usr/bin/env bash

cpu="$(awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else print ($2+$4-u1) * 100 / (t-t1); }' \
    <(grep 'cpu ' /proc/stat) <(sleep 1;grep 'cpu ' /proc/stat))"

int_cpu=${cpu%.*}

text=""

[ "$int_cpu" -lt "100" ] && text="^c#161b20^0"
[ "$int_cpu" -lt "10"  ] && text="${text}0"

if [ "$int_cpu" -ge "80" ] ; then
    text="$text^c#ff5555^"
elif [ "$int_cpu" -ge "60" ] ; then
    text="$text^c#ffb86c^"
else
    text="$text^c#f1fa8c^"
fi

echo "$text$int_cpu%"
