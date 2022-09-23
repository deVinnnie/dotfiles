#!/bin/sh
export BLUE='\e[92m  '
export BLUE_ANIME='\e[92m '
export GREEN='\e[92m  '
export RED='\e[91m  '
export RED_ANIME='\e[91m '
export YELLOW='\e[33m  '
export YELLOW_ANIME='\e[33m '
export ABORTED='  '
export ABORTED_ANIME=' '
export RESET='\e[0m'
export BOLD='\e[97m'

while :
do
    BUILD_MONITOR_VIEW=$(curl -s $JENKINS_DASHBOARD)
    TITLE=$(echo $BUILD_MONITOR_VIEW \
        | jq-win64.exe --raw-output '.name')

    JOBS=$(echo $BUILD_MONITOR_VIEW \
        | jq-win64.exe --raw-output '.jobs[] | "$" + (.color | ascii_upcase) + " " + .name + "$RESET"' \
        | sed "s/\$RESET/\\$RESET/g" \
        | sed "s/\$BLUE_ANIME/\\$BLUE_ANIME/g" \
        | sed "s/\$BLUE/\\$BLUE/g" \
        | sed "s/\$RED_ANIME/\\$RED_ANIME/g" \
        | sed "s/\$RED/\\$RED/g" \
        | sed "s/\$YELLOW_ANIME/\\$YELLOW_ANIME/g" \
        | sed "s/\$YELLOW/\\$YELLOW/g" \
        | sed "s/\$NOTBUILT/\\$ABORTED/g" \
        | sed "s/\$ABORTED_ANIME/\\$ABORTED_ANIME/g" \
        | sed "s/\$ABORTED/\\$ABORTED/g")
    clear
    echo -e "$BOLD # $TITLE\n$RESET"
    echo -e "$JOBS"
    # envsubst scrambles special characters...
    #| envsubst '$BLUE $BLUE_ANIME $RED $RED_ANIME $YELLOW $YELLOW_ANIME $RESET'`

    echo ""
    echo "Hit [CTRL+C] to stop!"
    sleep 30
done

