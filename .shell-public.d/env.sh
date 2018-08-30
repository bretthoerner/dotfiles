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

# python
if [[ -d "${HOME}/.pyenv" ]]; then
	export PATH="${HOME}/.pyenv/bin:$PATH"
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
fi
export PIP_RESPECT_VIRTUALENV=true
export PYTHONDONTWRITEBYTECODE=1

# /usr/local
export PATH="/usr/local/sbin:/usr/local/bin:$PATH"

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

# vte
source-if-file /etc/profile.d/vte.sh

# android
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
export ANDROID_NDK_HOME="$HOME/Library/Android/sdk/ndk-bundle"
export ANDROID_HOME="$HOME/Library/Android/sdk/"

# sentry
export DB=sqlite
export SENTRY_LIGHT_BUILD=1
export SENTRY_SOUTH_TESTS_MIGRATE=0

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

