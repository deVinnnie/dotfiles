#!/bin/sh
export BLUE="\e[92m"
export BLUE_ANIME="\e[92m"
export GREEN="\e[92m"
export RED="\e[91m"
export RED_ANIME="\e[91m"
export YELLOW="\e[33m"
export YELLOW_ANIME="\e[33m"
export RESET="\e[0m"

while :
do
   JOBS=`curl -s $JENKINS_DASHBOARD | jq-win64.exe '.jobs[] | "$" + (.color | ascii_upcase) + " " + .name + "$RESET"' | tr -d '"' | envsubst '$BLUE $BLUE_ANIME $RED $RED_ANIME $YELLOW $YELLOW_ANIME $RESET'`
   clear
   echo -e "$JOBS"

   echo ""
   echo "Hit [CTRL+C] to stop!"
   sleep 30
done
