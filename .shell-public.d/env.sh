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

function add-to-path-if-dir() {
    _dir=$1
    [[ -d "$_dir" ]] && export PATH="$_dir:$PATH"
}

# ssh-agent
[[ -S "/run/user/$(id -u)/ssh-agent.socket" ]] && export SSH_AUTH_SOCK="/run/user/$(id -u)/ssh-agent.socket"

# /usr/local
add-to-path-if-dir "/usr/local/bin"
add-to-path-if-dir "/usr/local/sbin"

# python
if type pyenv &> /dev/null; then
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
add-to-path-if-dir "${HOME}/.cabal/bin"

# add ~/bin to PATH if it exists
add-to-path-if-dir "${HOME}/bin"

# mvn
export MAVEN_OPTS="-Xmx2G"

# scala
export SBT_OPTS="-Dscala.color -Xmx2G"
export JAVA_OPTS="-Dscala.color"

# rust & cargo
add-to-path-if-dir "${HOME}/.cargo/bin"
[[ -d "$HOME/.cargo" ]] && export CARGO_HOME="$HOME/.cargo"
export RUST_SRC_PATH="$HOME/.rustup/toolchains/nightly-x86_64-apple-darwin/lib/rustlib/src/rust/src/"
export DYLD_LIBRARY_PATH="${HOME}/.rustup/toolchains/nightly-x86_64-apple-darwin/lib"
# export RLS_ROOT="${HOME}/Development/src-mirror/rls"
export RUST_NEW_ERROR_FORMAT="true"
export CARGO_INCREMENTAL=1

# go
add-to-path-if-dir "/opt/go/bin"
add-to-path-if-dir "${HOME}/go/bin"

# vte
source-if-file /etc/profile.d/vte.sh

# node
add-to-path-if-dir "/usr/local/opt/node@10/bin"
export PATH="./node_modules/.bin:$PATH"

# depot_tools
add-to-path-if-dir "${HOME}/Development/src-mirror/depot_tools"

# ruby
add-to-path-if-dir "${HOME}/.gem/ruby/2.5.0/bin"
add-to-path-if-dir "${HOME}/.gem/ruby/2.6.0/bin"

# wrangler
add-to-path-if-dir "${HOME}/.wrangler/wrangler/node_modules/.bin"
