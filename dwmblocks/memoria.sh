#!/usr/bin/env sh

#color="^c#6Bc9dD^"
color="^c#81a1c1^"
text="$(free -h | awk '/^Mem/ { print $3"/"$2 }' | sed s/i//g)"
echo "$color$text^c#444444^"
