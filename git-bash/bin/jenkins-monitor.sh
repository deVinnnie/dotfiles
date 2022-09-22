#!/bin/sh
export BLUE='\\e[92m  '
export BLUE_ANIME='\\e[92m '
export GREEN='\\e[92m  '
export RED='\\e[91m  '
export RED_ANIME='\\e[91m '
export YELLOW='\\e[33m  '
export YELLOW_ANIME='\\e[33m '
export ABORTED='  '
export ABORTED_ANIME=' '
export RESET='\\e[0m'

while :
do
    JOBS=$(curl -s $JENKINS_DASHBOARD \
        | jq-win64.exe '.jobs[] | "$" + (.color | ascii_upcase) + " " + .name + "$RESET"' \
        | tr -d '"' \
        | sed "s/\$RESET/$RESET/g" \
        | sed "s/\$BLUE_ANIME/$BLUE_ANIME/g" \
        | sed "s/\$BLUE/$BLUE/g" \
        | sed "s/\$RED_ANIME/$RED_ANIME/g" \
        | sed "s/\$RED/$RED/g" \
        | sed "s/\$YELLOW_ANIME/$YELLOW_ANIME/g" \
        | sed "s/\$YELLOW/$YELLOW/g" \
        | sed "s/\$ABORTED_ANIME/$ABORTED_ANIME/g" \
        | sed "s/\$ABORTED/$ABORTED/g")
    clear
    echo -e "$JOBS"
    # envsubst scrambles special characters...
    #| envsubst '$BLUE $BLUE_ANIME $RED $RED_ANIME $YELLOW $YELLOW_ANIME $RESET'`

    echo ""
    echo "Hit [CTRL+C] to stop!"
    sleep 30
done

