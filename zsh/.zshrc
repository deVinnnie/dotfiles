if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    source /etc/profile.d/vte.sh
fi

# Automatically launch tmux. But not tmux in tmux.
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

DOTFILES_DIR="$HOME/.dotfiles"
fpath=($DOTFILES_DIR/autocomplete $fpath)

# History
# ----------------------------------------------------------------------
# From ohmyzsh/history.zsh
HISTFILE="$HOME/.zsh_history"
HISTSIZE=500000
SAVEHIST=100000
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

# fc == fix command
#
# The zsh version has more options than defined in POSIX:
# https://zsh.sourceforge.io/Doc/Release/Shell-Builtin-Commands.html
#
# The builtin history command in zsh is apparently just an alias for 'fc -l'
# https://jdhao.github.io/2021/03/24/zsh_history_setup/
#
# Redefine it so it prints the dates in ISO8601 format (-i)
# and print all commands (1), not just the last 16.
alias history='fc -l -i 1'


# Key Bindings
# ----------------------------------------------------------------------
# https://jdhao.github.io/2019/06/13/zsh_bind_keys/
# Keycodes determined empirically with `showkey -a`
# or copied from the oh-my-zsh keybinds.
bindkey '^[[1~' beginning-of-line    # [Home]
bindkey '^[[4~' end-of-line          # [End]

bindkey '^[[1;5C' forward-word       # [Ctrl-RightArrow]
bindkey '^[[1;5D' backward-word      # [Ctrl-LeftArrow]

bindkey '^[[Z' reverse-menu-complete # [Shift-Tab]

bindkey '^?' backward-delete-char    # [Backspace]
bindkey '^[[3~' delete-char          # [Delete]


# Completions
# ----------------------------------------------------------------------
unsetopt menu_complete   # do not autoselect the first completion entry
setopt auto_menu
setopt complete_in_word
setopt always_to_end # Put cursor at end of completed word

# Highlight selected option.
# This zstyle thing is mostly voodo for me.
zstyle ':completion:*:*:*:*:*' menu select

autoload -Uz compinit
compinit -i -C -d ~/.zcompdump
_comp_options+=(globdots)


# Fzf
# ----------------------------------------------------------------------
source /usr/share/fzf/key-bindings.zsh
export FZF_DEFAULT_OPTS="--layout reverse"
# fd excludes files from .gitignore by default.
export FZF_CTRL_T_COMMAND="fd --hidden --exclude .git --type f"

# Directory Stacks
# ----------------------------------------------------------------------
# https://zsh.sourceforge.io/Intro/intro_6.html
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

# Path
# ----------------------------------------------------------------------
export PATH="$HOME/bin:/usr/lib/hardening-wrapper/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin"
PATH=~/bin:$PATH
export PATH

NPM_PACKAGES="${HOME}/.npm-packages"
PATH="$NPM_PACKAGES/bin:$PATH"

# Aliases
# ----------------------------------------------------------------------
alias grep='grep --color=auto'
alias ls='ls -h --color=auto'
alias wake='wol 00:19:d1:89:58:36'
alias diary='~/bin/diary.sh'
alias git-cola='~/bin/git-cola.sh'
alias ij='~/bin/idea . &'
alias l='ls'
alias g='git $@'
alias gh='git hist'
alias t='tig status'
alias mvn="mvn -s ~/.config/maven/settings.xml $@"
alias refresh="exec zsh"
alias newsboat="LANG=en LC_ALL=en_US.UTF-8 newsboat --quiet $@" # Make newsboat less noisy
alias nw=newsboat
export PYGMENTIZE_STYLE='zenburn' # Used as color theme to preview text-files in ranger.
alias r='ranger'

# Do file operations with 'interactive' mode,
# to avoid accidental mayhem.
alias cp='cp -iv'
alias rm='rm -iv'
alias mv='mv -iv'

function cd {
    builtin cd "$@" && ls
}

# Environment variables
# ----------------------------------------------------------------------
export EDITOR=/usr/bin/vim
export PROJECTS_DIR=~/Development/Repos

# Disable less search history
export LESSHISTFILE=-

# Functions
# ----------------------------------------------------------------------
source $DOTFILES_DIR/scripts/p.sh
source $DOTFILES_DIR/scripts/git-prompt.sh


# Magic incantantions to colorize man pages
# ----------------------------------------------------------------------
autoload colors
colors
# bold & blinking mode
export LESS_TERMCAP_mb="${fg_bold[red]}"
export LESS_TERMCAP_md="${fg_bold[red]}"
export LESS_TERMCAP_me="${reset_color}"
# standout mode / info box down the bottom thing
export LESS_TERMCAP_so="${fg_bold[yellow]}"
export LESS_TERMCAP_se="${reset_color}"
# underlining
export LESS_TERMCAP_us="${fg_bold[green]}"
export LESS_TERMCAP_ue="${reset_color}"


# Prompt
# ----------------------------------------------------------------------
setopt prompt_subst
NEWLINE=$'\n'
PROMPT='%F{cyan}%c%f'
PROMPT="$PROMPT"'`__fastgit_ps1`'
PROMPT="$PROMPT${NEWLINE}"
PROMPT="$PROMPT→ "

# Disable Ctrl-s / Ctrl-q
stty -ixon
