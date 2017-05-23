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
