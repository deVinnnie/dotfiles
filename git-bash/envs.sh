export VIMINIT='let $MYVIMRC="$DOTFILES/../vim/.vimrc" | source $MYVIMRC'

# Retain more history.
export HISTSIZE=100000
export HISTFILESIZE=100000

# --------------------------
# Maven
# --------------------------
# https://binkley.blogspot.com/2017/04/maven-color-logging-on-cygwin.html
MAVEN_OPTS="-Djansi.passthrough=true"
MAVEN_OPTS=$MAVEN_OPTS" -Xms1024m -Xmx4096m"
MAVEN_OPTS=$MAVEN_OPTS" -XX:+TieredCompilation -XX:TieredStopAtLevel=1 -Xverify:none"
MAVEN_OPTS=$MAVEN_OPTS" -Djava.io.tmpdir=C:\\dev\\tmp"

export MAVEN_OPTS
