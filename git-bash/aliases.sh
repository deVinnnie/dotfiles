alias oc='oc.exe'
alias ocl='oc.exe login -u '$OC_USERNAME' -p '$OC_PASSWORD
alias ocd='oc.exe deploy $1 --latest'
alias ij='idea.sh'
alias jenkins='$JAVA_HOME/jre/bin/java -jar /c/dev/common/jenkins-cli/jenkins-cli.jar -s $JENKINS_URL $@'
alias compose-up='docker-compose up --force-recreate'
alias refresh='source ~/.bashrc'
alias parallel-mvn='mvn -T 1C $@'

# Change directory to root of the current git repo.
alias root='cd "$(git rev-parse --show-toplevel)"' # https://stackoverflow.com/questions/1571461/git-a-quick-command-to-go-to-root-of-the-working-tree
alias gitk='gitk &'
# Add bin directory to path
PATH=$PATH:$DOTFILES/bin/
