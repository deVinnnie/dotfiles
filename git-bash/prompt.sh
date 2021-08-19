function __jenkins_ps1
{
    if [ -n "$JENKINS_URL" ]; then
        echo -e "\033[37m<$JENKINS_PROJECT>\033[0m"
    fi
}

PS1='\['${COLOR_CYAN_BOLD}'\]\W\['${COLOR_RESET}'\]'
PS1="$PS1"'`__fastgit_ps1`'
PS1="$PS1"'\n'
PS1="$PS1→ "
