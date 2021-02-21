export VIMINIT='let $MYVIMRC="$DOTFILES/../vim/.vimrc" | source $MYVIMRC'

# --------------------------
# Maven
# --------------------------
MAVEN_OPTS=$MAVEN_OPTS" -Xms1024m -Xmx4096m"
MAVEN_OPTS=$MAVEN_OPTS" -XX:+TieredCompilation -XX:TieredStopAtLevel=1 -Xverify:none"
MAVEN_OPTS=$MAVEN_OPTS" -Djava.io.tmpdir=C:\\dev\\tmp"

export MAVEN_OPTS
