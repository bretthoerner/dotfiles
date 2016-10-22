# Don't setup before launching X11 and not on an ssh connection
([ -z ${DISPLAY+x} ] && [ -z ${SSH_CONNECTION+x} ]) && return

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    adb
    bundler
    colored-man-pages
    command-not-found
    docker
    docker-compose
    gem
    go
    knife
    knife_ssh
    mosh
    mvn
    tmux
    vagrant
)

source $ZSH/oh-my-zsh.sh

# keep trailing slash on dir autocomplete
setopt no_auto_remove_slash

# source files in common between bash and zsh
if [ -d "${HOME}/.shell-private.d" ]; then
    for s in ${HOME}/.shell-private.d/*; do
        source $s
    done
fi

if [ -d "${HOME}/.shell-public.d" ]; then
    for s in ${HOME}/.shell-public.d/*; do
        source $s
    done
fi

# gcloud
if [ -d "${HOME}/google-cloud-sdk" ]; then
    source "${HOME}/google-cloud-sdk/path.zsh.inc"
    source "${HOME}/google-cloud-sdk/completion.zsh.inc"
fi

# awscli
_aws_zsh_completer_path="${HOME}/.pyenv/versions/2.7.11/bin/aws_zsh_completer.sh"
if [ -x $_aws_zsh_completer_path ]; then
    source $_aws_zsh_completer_path
fi
unset _aws_zsh_completer_path

# kubectl
if which kubectl &> /dev/null; then
    source <(kubectl completion zsh)
fi

PROMPT='${ret_status} %{$fg[cyan]%}%~%{$reset_color%} $(git_prompt_info)'

