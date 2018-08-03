export MAVEN_OPTS="-Xmx512m -XX:MaxPermSize=128m -XX:+TieredCompilation -XX:TieredStopAtLevel=1"
export OC_PROJECT=`oc.exe project --short`

# Make sure ruby can make SSL connections
export SSL_CERT_FILE=/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem

source $DOTFILES/secret.sh
source $DOTFILES/docker-config.sh
source $DOTFILES/aliases.sh
source $DOTFILES/functions.sh
source $DOTFILES/prompt.sh
source $DOTFILES/autocomplete.sh
