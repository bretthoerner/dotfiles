# various
export EDITOR="vim"
export PAGER="less -R"
export GPGKEY="252426C1"
export EMAIL="brett@bretthoerner.com"
export DEBEMAIL=$EMAIL
export DEBFULLNAME="Brett Hoerner"
export PYTHONDONTWRITEBYTECODE=1

# lang
export LC_CTYPE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# java
case $OSTYPE in
    darwin*)
        export JAVA_HOME=$(/usr/libexec/java_home -v 1.7.0_80)
        export PATH=$JAVA_HOME/bin:$PATH
    ;;
    *)
    ;;
esac

function source-if-file() {
    _path=$1
    if [[ -f $_path ]]; then
        source $_path
    fi
}

# virtualenv & virtualenvwrapper
export PIP_RESPECT_VIRTUALENV=true
export PIP_REQUIRE_VIRTUALENV=true
export WORKON_HOME="${HOME}/Development/virtualenvs"
source-if-file /usr/local/bin/virtualenvwrapper.sh

# /usr/local
export PATH="/usr/local/sbin:/usr/local/bin:$PATH"

# go
export GOPATH="${HOME}/Development/go"
export PATH="${GOPATH}/bin:${PATH}"

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
export RLS_ROOT="${HOME}/Development/src-mirror/rls"
export RUST_NEW_ERROR_FORMAT="true"

# vte
source-if-file /etc/profile.d/vte.sh

# fastlane
export PATH="$HOME/.fastlane/bin:$PATH"

# android
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
export ANDROID_NDK_HOME="$HOME/Library/Android/sdk/ndk-bundle"
export ANDROID_HOME="$HOME/Library/Android/sdk/"

# gpg agent
if which gpg-agent &> /dev/null && [[ ! -n "$(pgrep gpg-agent)" ]]; then
    eval $(gpg-agent --daemon)
fi
