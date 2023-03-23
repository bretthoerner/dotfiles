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
[[ -S "${HOME}/.ssh/agent_sock" ]] && export SSH_AUTH_SOCK="${HOME}/.ssh/agent_sock"

# /usr/local
add-to-path-if-dir "/usr/local/bin"
add-to-path-if-dir "/usr/local/sbin"

# python
export PYTHONSTARTUP="${HOME}/bin/pystartup.py"
add-to-path-if-dir "${HOME}/.pyenv/bin"
if type pyenv &> /dev/null; then
    export PYENV_ROOT="$HOME/.pyenv"
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

# mvn
export MAVEN_OPTS="-Xmx2G"

# java
add-to-path-if-dir "/opt/homebrew/opt/openjdk/bin"

# scala
export SBT_OPTS="-Dscala.color -Xmx2G"
export JAVA_OPTS="-Dscala.color"

# rust & cargo
source-if-file $HOME/.cargo/env

# go
add-to-path-if-dir "/opt/go/bin"
add-to-path-if-dir "${HOME}/go/bin"

# vte
source-if-file /etc/profile.d/vte.sh

# node
add-to-path-if-dir "/usr/local/opt/node@10/bin"
export PATH="./node_modules/.bin:$PATH"

# GNU utils on macOS
add-to-path-if-dir "/opt/homebrew/opt/grep/libexec/gnubin"
add-to-path-if-dir "/opt/homebrew/opt/findutils/libexec/gnubin"

# depot_tools
add-to-path-if-dir "${HOME}/Development/src-mirror/depot_tools"

# wrangler
add-to-path-if-dir "${HOME}/.wrangler/wrangler/node_modules/.bin"

# multipass
add-to-path-if-dir "${HOME}/Library/Application Support/multipass/bin"

function load-nvm() {
    export NVM_DIR="$HOME/.nvm"
    [ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
}

# setup keychain ssh-agent for backup
if type keychain &> /dev/null; then
  eval $(keychain --eval --quiet id_ed25519 id_rsa)
fi
