export MAVEN_OPTS="-Xmx512m -XX:MaxPermSize=128m -XX:+TieredCompilation -XX:TieredStopAtLevel=1"
export OC_PROJECT=`oc.exe project --short`

source $DOTFILES/secret.sh
source $DOTFILES/aliases.sh
source $DOTFILES/functions.sh
source $DOTFILES/prompt.sh
source $DOTFILES/autocomplete.sh
