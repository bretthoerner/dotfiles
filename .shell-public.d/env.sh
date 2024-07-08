#!/bin/bash

# various
export EDITOR="vim"
export PAGER="less -R"
export GPGKEY="252426C1"
export GPG_TTY=$(tty)
export EMAIL="brett@bretthoerner.com"
export DEBEMAIL=$EMAIL
export DEBFULLNAME="Brett Hoerner"
export LANG="en_US.UTF-8"
#export LANGUAGE="en_US.UTF-8"
#export LC_CTYPE="en_US.UTF-8"
#export LC_ALL="en_US.UTF-8"

function source-if-file() {
    _path=$1
    if [[ -f $_path ]]; then
        source $_path
    fi
}

function add-to-path-if-dir() {
    _dir=$1
    [[ -d "$_dir" ]] && export PATH="$_dir:$PATH"
}

# ssh-agent
if [[ -S "${HOME}/.ssh/agent_sock" ]]; then
    export SSH_AUTH_SOCK="${HOME}/.ssh/agent_sock"
fi

# /usr/local
add-to-path-if-dir "/usr/local/bin"
add-to-path-if-dir "/usr/local/sbin"

# python
export PYTHONSTARTUP="${HOME}/bin/pystartup.py"
add-to-path-if-dir "${HOME}/.pyenv/bin"
if type pyenv &> /dev/null; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
    export PATH="$PYENV_ROOT/bin:$PATH"
    export WORKON_HOME="${HOME}/.pyenv/versions"
    function pyenv() {
        unset -f pyenv
        eval "$(pyenv init --path)"
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)"
        pyenv $@
    }
fi

export PIP_RESPECT_VIRTUALENV=true
export PYTHONDONTWRITEBYTECODE=1

# haskell
add-to-path-if-dir "${HOME}/.cabal/bin"

# add ~/bin to PATH if it exists
add-to-path-if-dir "${HOME}/bin"

# java
add-to-path-if-dir "/opt/homebrew/opt/openjdk/bin"

# rust & cargo
source-if-file $HOME/.cargo/env
#export RUSTFLAGS="-Z threads=8"

# go
add-to-path-if-dir "/opt/go/bin"
add-to-path-if-dir "${HOME}/go/bin"

# vte
source-if-file /etc/profile.d/vte.sh

# node
export PATH="./node_modules/.bin:$PATH"

# nvm
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
[ -s "/usr/share/nvm/init-nvm.sh" ] && . "/usr/share/nvm/init-nvm.sh"

# setup keychain ssh-agent for backup
if type keychain &> /dev/null; then
  eval $(keychain --eval --quiet id_ed25519 id_rsa)
fi

# custom clang
add-to-path-if-dir "/opt/clang/bin"

# mac postgres
add-to-path-if-dir "/opt/homebrew/opt/postgresql@15/bin"

# atuin
## if which atuin &> /dev/null; then
##     if [ -n "$BASH" ]; then
##         eval "$(atuin init bash)"
##     elif [ -n "$ZSH_NAME" ]; then
##         eval "$(atuin init zsh)"
##     fi
## fi

[[ -d "/Applications/Tailscale.app" ]] && alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

add-to-path-if-dir "/Applications/Ghostty.app/Contents/MacOS/"
