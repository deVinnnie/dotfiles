#!/bin/sh
COLOR_CYAN_BOLD='\033[36;1m'
COLOR_MAGENTA_BOLD='\033[35;1m'
COLOR_RED_BOLD='\033[31;1m'
COLOR_YELLOW_BOLD='\033[33;1m'
COLOR_RESET='\033[0m'

# Based of https://gist.github.com/Ragnoroct/c4c3bf37913afb9469d8fc8cffea5b2f
#
# Goal is not to be annoyingly slow on Windows machines.
# (The default __git_ps1 on Windows is just a pain.)
# This means doing as much as possible in pure shell script,
# without calling any other processes.
# Starting a process on Windows takes tens of milliseconds.
#
# `time __fastgit_ps1`
# Linux: ~5ms
# Windows: ~90ms
#
# Regarding '\[   \]' and '\001 \002':
# https://superuser.com/questions/301353/escape-non-printing-characters-in-a-function-for-a-bash-prompt/301355#301355
# Dixit arch wiki: This helps Bash ignore non-printable characters so that it correctly calculates the size of the prompt. The wrap will not work with command substitution, in which case use the raw \1 \2
#
# Example output:
# .dotfiles on  master [4]
function __fastgit_ps1 () {
    local headfile head branch
    local dir="$PWD"
    local counter state
    local gitdir

    while [ -n "$dir" ]; do
        if [ -e "$dir/.git/HEAD" ]; then
            gitdir="$dir/.git/"
            break
        fi

        # worktrees...
        if [ -f "$dir/.git" ]; then
            read -r gitdir < $dir/.git || return
            gitdir=${gitdir##gitdir: }
            break
        fi

        dir="${dir%/*}"
    done

    headfile="$gitdir/HEAD"

    if [ -e "$headfile" ]; then
        read -r head < "$headfile" || return
        case "$head" in
            ref:*) branch="${head##*/}" ;;
            "") branch="" ;;
            *) branch="detached ${head:0:7}" ;;
        esac
    fi

    if [ -z "$branch" ]; then
        return 0
    fi


    # Ahead / Behind
    # Dixit docs for git rev-list:
    # "When used together with --left-right, instead print the counts for left and right commits, separated by a tab."
    # Three dots are necessary, two dots does not give expected result.
    aheadAndBehind=`git rev-list --left-right --count @{upstream}...HEAD 2> /dev/null || echo -n ''`
    if [ ! -z "$aheadAndBehind" ]; then
        rightahead=${aheadAndBehind%%$'\t'*}
        leftahead=${aheadAndBehind##*$'\t'}

        # Only show counters when there are commits to pushed/pulled
        [ "$leftahead" != "0" ] && counter=$counter"${leftahead}"
        [ "$rightahead" != "0" ] && counter=$counter"${rightahead}"
        # Only show brackets when there's something in between them.
        [ -n "$counter" ] && counter="\001$COLOR_RED_BOLD\002[$counter]\001$COLOR_RESET\002 "
    fi

    # Rebase / Merge / ...
    if [ -d "$gitdir/rebase-merge" ]; then
        read -r end < "$gitdir/rebase-merge/end"
        read -r msgnum < "$gitdir/rebase-merge/msgnum"
        state="\001$COLOR_YELLOW_BOLD\002(REBASING $msgnum/$end)\001$COLOR_RESET\002 "

    # Revert
    elif [ -e "$gitdir/REVERT_HEAD" ]; then
        read -r revert_head < "$gitdir/REVERT_HEAD"
        state="\001$COLOR_YELLOW_BOLD\002(REVERTING ${revert_head:0:7})\001$COLOR_RESET\002 "

    # Cherry Pick
    elif [ -e "$gitdir/CHERRY_PICK_HEAD" ]; then
        read -r cherry_pick_head < "$gitdir/CHERRY_PICK_HEAD"
        state="\001$COLOR_YELLOW_BOLD\002(CHERRY-PICKING ${cherry_pick_head:0:7})\001$COLOR_RESET\002 "
    fi

    echo -e " on \001$COLOR_MAGENTA_BOLD\002 $branch\001$COLOR_RESET\002 $state$counter"
}
