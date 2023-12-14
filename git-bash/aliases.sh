alias oc='oc.exe'
function ocl() {
    server=$(cat ~/.kube/config | awk --field-separator=' ' '$1 == "server:" { print $2 }' | fzf)
    /c/dev/tools/oc.exe login --server=$server -u $OC_USERNAME -p $(/c/dev/tools/gopass/gopass show -o $OC_PASSWORD_SECRET_NAME)
}
alias ocd='oc.exe rollout latest $1'
alias ij='/c/dev/tools/idea.cmd'
alias jenkins='$JAVA_HOME/jre/bin/java -jar /c/dev/common/jenkins-cli/jenkins-cli.jar -s $JENKINS_URL $@'
alias refresh='source ~/.bashrc'
alias g='git $@'
alias gh='git hist'
alias mvn='/c/dev/tools/apache-maven-3.8.6/bin/mvn.cmd $@'
alias mvnd='winpty /c/dev/tools/mvnd-0.8.2-windows-amd64/bin/mvnd $@'
alias jq='/c/dev/tools/jq-win64.exe -C $@'
alias t='tig status'
alias docker='winpty docker $@' # Fixes 'The handle is invalid.' when running docker with interactive flag.
alias real-docker='/c/Program\ Files/Docker/Docker/Resources/bin/docker $@' # Fixes fix when running docker in subshell
# Change directory to root of the current git repo.
alias root='cd "$(git rev-parse --show-toplevel)"' # https://stackoverflow.com/questions/1571461/git-a-quick-command-to-go-to-root-of-the-working-tree
# Add bin directory to path
PATH=$PATH:$DOTFILES/bin/

