export MAVEN_OPTS="-Xms1024m -Xmx4096m -XX:+TieredCompilation -XX:TieredStopAtLevel=1 -Xverify:none -Djava.io.tmpdir=C:\\dev\\tmp"

# Make sure ruby can make SSL connections
export SSL_CERT_FILE=/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem

# Retain more history.
export HISTSIZE=100000
export HISTFILESIZE=100000

source $DOTFILES/secret.sh
source $DOTFILES/docker-config.sh
source $DOTFILES/aliases.sh
source $DOTFILES/functions.sh
source $DOTFILES/prompt.sh
source $DOTFILES/autocomplete.sh
