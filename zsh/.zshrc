if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    source /etc/profile.d/vte.sh
fi

# Automatically launch tmux. But not tmux in tmux.
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

DOTFILES_DIR="$HOME/.dotfiles"
fpath=($DOTFILES_DIR/autocomplete $fpath)

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh_reload)


source $ZSH/oh-my-zsh.sh

# Fzf
# ----------------------------------------------------------------------
source /usr/share/fzf/key-bindings.zsh
export FZF_DEFAULT_OPTS="--layout reverse"
# fd excludes files from .gitignore by default.
export FZF_CTRL_T_COMMAND="fd --hidden --exclude .git --type f"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

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
