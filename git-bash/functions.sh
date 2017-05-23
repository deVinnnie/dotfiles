function counttests
{
    LOGFILE=`pwd`/$1
    echo $LOGFILE
    echo 'Tests run: '; grep -oP '^Tests run\K(.*)' $LOGFILE  | cut -d "," -f 1 | awk '{total += $1} END {print total}'
    echo 'Failures: ';  grep -oP '^Tests run.*Failures\K(.*)' $LOGFILE  | cut -d "," -f 1 | awk '{total += $1} END {print total}'
    echo 'Errors: ';    grep -oP '^Tests run.*Errors\K(.*)' $LOGFILE  | cut -d "," -f 1 | awk '{total += $1} END {print total}'
    echo 'Skipped: ';   grep -oP '^Tests run.*Skipped\K(.*)' $LOGFILE  | cut -d "," -f 1 | awk '{total += $1} END {print total}'
}

# Switch to Project Directory.
function p
{
    cd $PROJECTS_DIR/$1
}

# Switch OpenShift Project
function op
{
    if [ "$#" -eq 0 ]; then
        return 0
    elif [ "$#" -eq 2 ]; then
        TENNANT='vas'
        ENV=$1
        PROJECT_NUMBER=$2
    elif [ "$#" -eq 3 ]; then
        TENNANT=$1
        ENV=$2
        PROJECT_NUMBER=$3
    elif [ "$#" -ne 2 ]; then
        echo "Usage: op [tennant] <env> <number>"
        echo "Example: op test 1"
        return 1
    fi

    PROJECT=$TENNANT-$ENV-00$PROJECT_NUMBER-${OC_PROJECTS[$TENNANT-$PROJECT_NUMBER]}
    oc.exe project $PROJECT &> /dev/null

    export OC_PROJECT=`oc.exe project --short`
    export SECRETS=`oc.exe get secrets --output=name | cut -d '/' -f 2 | sed 's/-secret//'`
}

# Switch Jenkins Server
function jp
{
    if [ "$1" == "clear" ]; then
        unset JENKINS_PROJECT
        unset JENKINS_URL
        return
    fi
    JENKINS_URL=$JENKINS_PREFIX''$1''$JENKINS_SUFFIX
    JENKINS_PROJECT=`echo $JENKINS_URL | grep -Eo "jenkins-[0-9]{3}"`
}

# Create secret
function os
{
    # Usages:
    #    os app resources-tst.yaml
    #    os app .
    APP_DIR=$1
    ARGS=${@:2}
    oc.exe delete secrets $APP_DIR-secret
    oc.exe secrets new $APP_DIR-secret $ARGS
}

# The killing curse for OpenShift pods
function avada-kadavra
{
    for var in "$@"
    do
        oc.exe delete pod $var --grace-period=0
    done
}

function docker-bash
{
    if [ "$#" -eq 1 ]; then
      docker exec -ti $1 bash
    else
      docker exec -ti `docker ps -q` bash
    fi
}

function java-8
{
    export JAVA_HOME=$JAVA_ROOT/sdk/1.8.0_60-x64/
}

function java-7
{
    export JAVA_HOME=$JAVA_ROOT/sdk/1.7.0_40-x64/
}
