alias oc='oc.exe'
alias ocl='oc.exe login -u '$OC_USERNAME' -p '$OC_PASSWORD
alias ocd='oc.exe rollout latest $1'
alias ij='/c/dev/tools/idea.cmd'
alias jenkins='$JAVA_HOME/jre/bin/java -jar /c/dev/common/jenkins-cli/jenkins-cli.jar -s $JENKINS_URL $@'
alias refresh='source ~/.bashrc'
alias l='ls'
alias g='git $@'
alias mvn='/c/dev/tools/apache-maven-3.6.3/bin/mvn.cmd $@'
alias jq='/c/dev/tools/jq-win64.exe -C $@'
alias t='tig status'
alias docker='winpty docker $@' # Fixes 'The handle is invalid.' when running docker with interactive flag.
alias real-docker='/c/Program\ Files/Docker/Docker/Resources/bin/docker $@' # Fixes fix when running docker in subshell
# Change directory to root of the current git repo.
alias root='cd "$(git rev-parse --show-toplevel)"' # https://stackoverflow.com/questions/1571461/git-a-quick-command-to-go-to-root-of-the-working-tree
alias gitk='gitk $@ &'
# Add bin directory to path
PATH=$PATH:$DOTFILES/bin/

