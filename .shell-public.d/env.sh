# various
export EDITOR="vim"
export PAGER="less -R"
export GPGKEY="252426C1"
export GPG_TTY=$(tty)
export EMAIL="brett@bretthoerner.com"
export DEBEMAIL=$EMAIL
export DEBFULLNAME="Brett Hoerner"

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

# ssh-agent
[[ -S "/run/user/$(id -u)/ssh-agent.socket" ]] && export SSH_AUTH_SOCK="/run/user/$(id -u)/ssh-agent.socket"

# /usr/local
export PATH="/usr/local/sbin:/usr/local/bin:$PATH"

# python
if type pyenv > /dev/null; then
    export PATH="${HOME}/.pyenv/bin:${HOME}/.pyenv/shims:${PATH}"
    export WORKON_HOME="${HOME}/.pyenv/versions"
    function pyenv() {
        unset -f pyenv
        eval "$(command pyenv init -)"
        eval "$(command pyenv virtualenv-init -)"
        pyenv $@
    }
fi

export PIP_RESPECT_VIRTUALENV=true
export PYTHONDONTWRITEBYTECODE=1

# haskell
export PATH="${HOME}/.cabal/bin:$PATH"

# add ~/bin to PATH if it exists
[[ -d "${HOME}/bin" ]] && export PATH="${HOME}/bin:$PATH"

# mvn
export MAVEN_OPTS="-Xmx2G"

# scala
export SBT_OPTS="-Dscala.color -Xmx2G"
export JAVA_OPTS="-Dscala.color"

# rust & cargo
[[ -d "$HOME/.cargo/bin" ]] && export PATH="$HOME/.cargo/bin:$PATH"
[[ -d "$HOME/.cargo" ]] && export CARGO_HOME="$HOME/.cargo"
export RUST_SRC_PATH="$HOME/.rustup/toolchains/nightly-x86_64-apple-darwin/lib/rustlib/src/rust/src/"
export DYLD_LIBRARY_PATH="${HOME}/.rustup/toolchains/nightly-x86_64-apple-darwin/lib"
# export RLS_ROOT="${HOME}/Development/src-mirror/rls"
export RUST_NEW_ERROR_FORMAT="true"
export CARGO_INCREMENTAL=1

# go
[[ -d "$HOME/go/bin" ]] && export PATH="$HOME/go/bin:$PATH"

# vte
source-if-file /etc/profile.d/vte.sh

# android
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
export ANDROID_NDK_HOME="$HOME/Library/Android/sdk/ndk-bundle"
export ANDROID_HOME="$HOME/Library/Android/sdk/"

# sentry
export DB=sqlite
export SENTRY_SOUTH_TESTS_MIGRATE=0

# node
export PATH="./node_modules/.bin:$PATH"

# depot_tools
export PATH="$HOME/Development/src-mirror/depot_tools:$PATH"
