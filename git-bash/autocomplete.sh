# Use same autocomplete for 'g' alias as git.
# By default the autocomplete is not triggered when using the alias.
# Existing autocompletions are listed with `complete -p git`
complete -o bashdefault -o default -o nospace -F __git_wrap__git_main g

__p_autocomplete()
{
    PROJECTS=`ls $PROJECTS_DIR`

    local cur prev
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    COMPREPLY=( $(compgen -W "${PROJECTS}" -- ${cur}) )

    return 0
}
complete -o nospace -F __p_autocomplete p

__os_autocomplete()
{
    local cur prev
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    if [ $COMP_CWORD -eq 1 ]; then
        COMPREPLY=( $(compgen -W "${SECRETS}" -- ${cur}) )
    else
        FILES=`ls`
        COMPREPLY=( $(compgen -W "${FILES}" -- ${cur}) )
    fi

    return 0
}
complete -o nospace -F __os_autocomplete os


__openshift_deployment_autocomplete()
{
    local cur prev
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    COMPREPLY=( $(compgen -W "${DEPLOYMENT_CONFIGS}" -- ${cur}) )

    return 0
}

complete -o nospace -F __openshift_deployment_autocomplete ocscale
complete -o nospace -F __openshift_deployment_autocomplete ocd


__op_autocomplete()
{
    ENVS='test int'
    local cur prev
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    COMPREPLY=( $(compgen -W "${ENVS}" -- ${cur}) )

    return 0
}

complete -o nospace -F __op_autocomplete op


# Generated with `gopass completion bash`
_gopass_bash_autocomplete() {
    local cur opts base
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    opts=$( ${COMP_WORDS[@]:0:$COMP_CWORD} --generate-bash-completion )
    local IFS=$'\n'
    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    return 0
}

# change 'gopass.exe' to 'gopass'
complete -F _gopass_bash_autocomplete gopass

