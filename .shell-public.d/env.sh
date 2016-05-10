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
export BROWSER=/usr/bin/firefox
export JAVA_HOME=/usr/lib/jvm/default

# lang
export LC_CTYPE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# pyenv
if [[ -d "${HOME}/.pyenv/" ]]; then
    export PATH="${HOME}/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# local
export PATH=/usr/local/sbin:/usr/local/bin:$PATH

# ruby
export PATH="${HOME}/.gem/ruby/2.3.0/bin:$PATH"

# js
export PATH="${HOME}/.npm/bin:$PATH"

# go
export GOPATH="${HOME}/Development/go"
export PATH="${GOPATH}/bin:${PATH}"

# add ~/bin to PATH if it exists
if [ -d "${HOME}/bin" ]; then
    export PATH=${HOME}/bin:$PATH
fi

# sbt
export SBT_OPTS=-XX:MaxPermSize=256M

# mvn
export MAVEN_OPTS="-Xmx512m -XX:MaxPermSize=256m"

# travis
[ -f "$HOME/.travis/travis.sh" ] && source "$HOME/.travis/travis.sh"

# node bin
[[ -d "$HOME/node_modules/.bin" ]] && export PATH="$HOME/node_modules/.bin:$PATH"

# cabal bin
[[ -d "$HOME/.cabal/bin" ]] && export PATH="$HOME/.cabal/bin:$PATH"

# cargo bin
[[ -d "$HOME/.cargo/bin" ]] && export PATH="$HOME/.cargo/bin:$PATH"

# rvm
[[ -f "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# scala
export SBT_OPTS="-Dscala.color"
export JAVA_OPTS="-Dscala.color"

# vte
[[ -f /etc/profile.d/vte.sh ]] && source /etc/profile.d/vte.sh
