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
    cd $PROJECTS_DIR/$1 2> /dev/null
    if [ $? -ne 0 ]; then
        echo "Project directory not found. Should I look in git repos?"
        read -p "Press enter to continue, CTRL^C to exit"
        REPO=`$DOTFILES/../bin/findRepo $1`

        if [ $? -eq 0 ]; then
            cd $PROJECTS_DIR
            git clone $REPO $1
            cd $PROJECTS_DIR/$1
        else
            echo "ERROR: No repository found for $1"
        fi
    fi
}

# Switch between OpenShift Projects.
# `op [tennant] <env> <number>`
# Shorthand for `oc project <project-name>`
function op
{
    if [ "$#" -eq 0 ]; then
        oc_project_refresh
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

    oc_project_refresh
}

# Set the number of replicas for a deployment-config.
# Defaults to 1 replica if no argument if given.
function ocscale
{
    DC=$1
    if [ "$#" -eq 1 ]; then
        REPLICAS=1
    else
        REPLICAS=$2
    fi
    oc.exe scale dc $DC --replicas=$REPLICAS
}

# Refresh info for prompt, and autocomplete functions.
function oc_project_refresh
{
    export OC_PROJECT=`oc.exe project --short`
    export SECRETS=`oc.exe get secrets --output=name | cut -d '/' -f 2 | sed 's/-secret//'`
    export DEPLOYMENT_CONFIGS=`oc.exe get dc --output=name | grep -oP '^deploymentconfig/\K.*'`
}

# Switch between Jenkins Servers
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

# Create secret:
#    os app resources-tst.yaml
#    os app .
# Results in 'app-secret' being created on the current OpenShift Project.
function os
{
    APP_DIR=$1
    ARGS=${@:2}
    oc.exe delete secrets $APP_DIR-secret
    oc.exe secrets new $APP_DIR-secret $ARGS
}

# The killing curse for OpenShift pods
# Usage: `avada-kedavra pod-name-1 pod-name-2 ...`
function avada-kedavra
{
    for var in "$@"
    do
        oc.exe delete pod $var --grace-period=0
    done
}

# Start a bash shell on the docker container with the given container-id.
# Usage:
#   `docker-bash [container-id]`
#
# If only one container is running you can ommit the container-id argument.
#
function docker-bash
{
    if [ "$#" -eq 1 ]; then
      docker exec -ti $1 bash
    else
      docker exec -ti `docker ps -q` bash
    fi
}

# Do a docker push with the image name from the last run of docker build.
#
# Usage:
#   ```
#   docker build -t repo.something.be/some-image:some-tag
#   docker-push-last
#   ```
#
function docker-push-last
{
    IMAGE_FROM_LAST_BUILD=`docker images --format "{{.Repository}}:{{.Tag}}" | head -n 1`
    echo "> docker push $IMAGE_FROM_LAST_BUILD"
    docker push $IMAGE_FROM_LAST_BUILD
}

function docker-cleanup
{
    # Remove running containers
    docker rm $(docker ps -aq)
    # Remove all images
    docker rmi -f $(docker images -q -f dangling=true)
}


function java-8
{
    export JAVA_HOME=$JAVA_ROOT/sdk/1.8.0_101-x64/
}

function java-7
{
    export JAVA_HOME=$JAVA_ROOT/sdk/1.7.0_40-x64/
}

# Run `mvn clean` for each specified project.
#
# Usage: `clean project-1 project-2 ...`
#
function clean
{
    for var in "$@"
    do
        cd $var
        mvn clean
        cd ..
    done
}

# Run `mvn clean` in all subdirectories.
function cleanAll
{
    DIRS=$(find . -maxdepth 2 -name pom.xml | grep -oP "./\K.*" | cut -d '/' -f 1)
    clean $DIRS
}

function failed
{
    FAILED_PODS=`oc.exe get pods -o template --template='{{range .items}}{{ if eq .status.phase "Failed" }}{{ .metadata.name }} {{ end }}{{ end }}'`
    echo $FAILED_PODS # | sed "s/%/\\n/g" | grep "deploy" | grep -v "jenkins"
}

function removeFailed
{
  FAILED_PODS=`oc.exe get pods -o template --template='{{range .items}}{{ if eq .status.phase "Failed" }}{{ .metadata.name }} {{ end }}{{ end }}'`
  oc.exe delete pod $FAILED_PODS --grace-period=0
}

# Initialize
oc_project_refresh


function dc_trace_cmd() {
  local parent=`docker inspect -f '{{ .Parent }}' $1` 2>/dev/null
  declare -i level=$2
  echo ${level}: `docker inspect -f '{{ .ContainerConfig.Cmd }}' $1 2>/dev/null`
  level=level+1
  if [ "${parent}" != "" ]; then
    echo ${level}: $parent
    dc_trace_cmd $parent $level
  fi
}
