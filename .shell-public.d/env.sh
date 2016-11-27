# various
export EDITOR="vim"
export PAGER="less -R"
export GPGKEY="252426C1"
export EMAIL="brett@bretthoerner.com"
export DEBEMAIL=$EMAIL
export DEBFULLNAME="Brett Hoerner"
export PYTHONDONTWRITEBYTECODE=1
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PIP_RESPECT_VIRTUALENV=true
export BROWSER=/usr/bin/google-chrome-stable
export JAVA_HOME=/usr/lib/jvm/default

# lang
export LC_CTYPE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

function source-if-file() {
    _path=$1
    if [[ -f $_path ]]; then
        source $_path
    fi
}

# pyenv
if [[ -d "${HOME}/.pyenv/" ]]; then
    export PATH="${HOME}/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# rbenv
if [[ -d "${HOME}/.rbenv" ]]; then
    export PATH="${HOME}/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi

# local
export PATH="/usr/local/sbin:/usr/local/bin:$PATH"

# js
export PATH="${HOME}/.npm/bin:$PATH"

# go
if [[ -z ${GOPATH+x} ]]; then
    # only if another GOPATH isn't already set
    export GOPATH="${HOME}/Development/go"
fi
export PATH="${GOPATH}/bin:${PATH}"

# add ~/bin to PATH if it exists
[[ -d "${HOME}/bin" ]] && export PATH="${HOME}/bin:$PATH"

# mvn
export MAVEN_OPTS="-Xmx2G"

# scala
export SBT_OPTS="-Dscala.color -Xmx2G"
export JAVA_OPTS="-Dscala.color"

# travis
source-if-file "$HOME/.travis/travis.sh"

# node bin
[[ -d "$HOME/node_modules/.bin" ]] && export PATH="$HOME/node_modules/.bin:$PATH"

# cabal bin
[[ -d "$HOME/.cabal/bin" ]] && export PATH="$HOME/.cabal/bin:$PATH"

# rust/cargo
[[ -d "$HOME/.cargo/bin" ]] && export PATH="$HOME/.cargo/bin:$PATH"
[[ -d "$HOME/.cargo" ]] && export CARGO_HOME="$HOME/.cargo"
[[ -d "$HOME/Development/src-mirror/rust/src" ]] && export RUST_SRC_PATH="$HOME/Development/src-mirror/rust/src"
export RUST_NEW_ERROR_FORMAT=true

# vte
[[ -f /etc/profile.d/vte.sh ]] && source /etc/profile.d/vte.sh

