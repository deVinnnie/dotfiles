#!/bin/sh
export BLUE='\e[92m   '
export BLUE_ANIME='\e[92m ⮀ '
export GREEN='\e[92m   '
export RED='\e[91m x '
export RED_ANIME='\e[91m\ ⮀ '
export YELLOW='\e[33m x '
export YELLOW_ANIME='\e[33m ⮀ '
export ABORTED='   '
export ABORTED_ANIME=' ⮀ '
export DISABLED="   \\\e[9m"
export RESET='\e[0m'
export BOLD='\e[97m'

function printDashboard
{
    JENKINS_DASHBOARD=$1
    COLUMN=$2

    BUILD_MONITOR_VIEW=$(curl --fail --silent $JENKINS_DASHBOARD)
    if [ $? -ne 0 ]; then
        echo -e "$RED Error fetching dashboard"
        exit
    fi

    TITLE=$(echo $BUILD_MONITOR_VIEW \
        | jq-win64.exe --raw-output '.name')

    LENGTH=$(echo $BUILD_MONITOR_VIEW \
        | jq-win64.exe --raw-output '.jobs | length')

    EXCLUDE='nothing'
    if [ $LENGTH -gt 20 ]; then
        EXCLUDE='$BLUE '
    fi

    JOBS=$(echo $BUILD_MONITOR_VIEW \
        | jq-win64.exe --raw-output '.jobs[] | "$" + (.color | ascii_upcase) + "" + .name + "$RESET"' \
        | grep -v $EXCLUDE \
        | grep -v NOTBUILT \
        | sed "s/\$RESET/\\$RESET/g" \
        | sed "s/\$BLUE_ANIME/\\$BLUE_ANIME/g" \
        | sed "s/\$BLUE/\\$BLUE/g" \
        | sed "s/\$RED_ANIME/\\$RED_ANIME/g" \
        | sed "s/\$RED/\\$RED/g" \
        | sed "s/\$YELLOW_ANIME/\\$YELLOW_ANIME/g" \
        | sed "s/\$YELLOW/\\$YELLOW/g" \
        | sed "s/\$ABORTED_ANIME/\\$ABORTED_ANIME/g" \
        | sed "s/\$ABORTED/\\$ABORTED/g" \
        | sed "s/\$DISABLED/\\$DISABLED/g"
    )
    echo -e "$BOLD # $TITLE\n$RESET"
    echo -e "$JOBS"

    if [ $LENGTH -gt 20 ]; then
        echo "   ..."
    fi
    echo -e "\n\n"
    # envsubst scrambles special characters...
    #| envsubst '$BLUE $BLUE_ANIME $RED $RED_ANIME $YELLOW $YELLOW_ANIME $RESET'`
}

function timeTillNextPoll
{
    currentDayOfWeek=$(date +%A | tr [:lower:] [:upper:])
    currentHour=$(date +%H)

    # Example: JENKINS_DASHBOARD_POLL_INTERVAL_MONDAY_06H
    name="JENKINS_DASHBOARD_POLL_INTERVAL_${currentDayOfWeek}_${currentHour}H"

    if [ -n "${!name}" ]; then
        echo "${!name}"
    elif [ -z "$JENKINS_DASHBOARD_POLL_INTERVAL" ]; then
        echo 30
    else
        echo $JENKINS_DASHBOARD_POLL_INTERVAL
    fi
}

# Print something while waiting for the first load
tput clear
tput cup $(tput lines) 0
echo -e -n "$YELLOW_ANIME Loading Dashboards $RESET $(date --iso-8601=minutes)"

dashboards=($(echo $JENKINS_DASHBOARD | tr ';' ' '))
WIDTH=45

while :
do
    max_lines=0
    col=0
    line=0

    # Set vars within loop to allow resizing
    TOTAL_LINES=$(tput lines)
    TOTAL_COLUMNS=$(( WIDTH * ( $(tput cols) / WIDTH) ))

    # Only redraw once everything is calculated.
    # Avoid stuttering.
    BUFFER=''

    for index in ${!dashboards[@]}; do
        dashboard=${dashboards[$index]}
        out=$(printDashboard $dashboard)

        BUFFER=$BUFFER$(tput cup $line $col)
        # https://unix.stackexchange.com/questions/405244/is-multi-line-alignment-possible-with-tput
        BUFFER=$BUFFER$(echo "$out" | PREFIX=$(tput cr; tput cuf $col) awk '{print ENVIRON["PREFIX"] $0}')

        curr_lines=$(echo "$out" | wc -l)
        max_lines=$(( curr_lines > max_lines ? curr_lines : max_lines))

        col=$(( ((index+1)*WIDTH) % TOTAL_COLUMNS ))
        line=$(( ((index+1)*WIDTH / TOTAL_COLUMNS) * (max_lines+1) ))

        if [ $line -gt $TOTAL_LINES ]; then
            break
        fi
    done

    BUFFER=$BUFFER$(tput cup $TOTAL_LINES 0)
    BUFFER=$BUFFER$(date --iso-8601=minutes)

    tput clear
    echo -n "$BUFFER"
    if [ $line -gt $TOTAL_LINES ]; then
        echo -n "Too many lines"
    fi

    sleep $(timeTillNextPoll)
done

