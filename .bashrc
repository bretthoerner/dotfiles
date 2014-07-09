# ~/.bashrc: executed by bash(1) for non-login shells.

# platform specific stuff
case $OSTYPE in
    linux*)
        # linux specific

        # make less more friendly for non-text input files, see lesspipe(1)
        [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

        if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
            eval "$(dircolors -b)"
        fi

        function ls { command ls -Fh --color=auto "$@"; }

        # source the bash-completion file
        if [ -r "/etc/bash_completion" ]; then
            . "/etc/bash_completion"
        fi

        alias v="cd /home/brett/Development/mr/chef/vagrant/ && vagrant ssh"
        alias t="cd /home/brett/Development/mr/tweetriver"
        alias c="cd /home/brett/Development/mr/chef"
        alias m="cd /home/brett/Development/mr"

        updategit ()
        {
            find . -maxdepth 2 -name ".git" -type d -print0 | xargs -0 -n 1 -I {} -P 8 bash -c "echo && cd {}/.. && pwd && git up"
        }

        updaterepos ()
        {
            prev=$(pwd)
            cd /home/brett/Development/src-mirror/
            updategit
            cd ~/Development/mr/
            updategit
            cd "$prev"
        }

        updaterust ()
        {
            prev=$(pwd)
            rustdate=$(date "+%Y-%m-%d")
            rustfile="rust-${rustdate}-x86_64-unknown-linux-gnu.tar.gz"
            rusttmpdir="${HOME}/Downloads/tmp"
            rustinnerdir="rust-nightly-x86_64-unknown-linux-gnu"
            mkdir -p "$rusttmpdir" && \
            cd "$rusttmpdir" && \
            wget "http://rustly.kokakiwi.net/files/${rustfile}" && \
            tar zxf "$rustfile" && \
            sudo /usr/bin/rm -rf "/opt/${rustinnerdir}" && \
            sudo /usr/bin/mv "$rustinnerdir" "/opt/" && \
            cd "$prev" && \
            rm -rf "$rusttmpdir"
        }

        alias open="gnome-open"

        # lsof -nPp
        # -n don't convert addresses
        # -P don't convert ports

        # strace -ttTp
        # -ttT print time in microseconds

        # strace -cp
        # -c count times and print summary at exit

        # tcpdump -i eth0 -s 0 -nqA tcp dst port 3306
        # -s snarf X bytes of data from each packet
        # -n don't convert addresses
        # -q quiet protocol information
        # -A print packet in ASCII

        # socat TCP-LISTEN:6379,reuseaddr,fork TCP:10.79.29.210:6379
    ;;
    *)
    ;;
esac

# lang
export LC_CTYPE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# aws
export PATH="${PATH}:${HOME}/.virtualenv/bin"

# local should come first
export PATH=/usr/local/sbin:/usr/local/bin:$PATH

# go
export GOPATH=${HOME}/.go
export PATH="${HOME}/.go/bin/:${PATH}"

# rust
export PATH="/opt/rust/bin/:${PATH}"

# add ~/bin to PATH if it exists
if [ -d "${HOME}/bin" ]; then
    export PATH=${HOME}/bin:$PATH
fi

# sbt
export SBT_OPTS=-XX:MaxPermSize=256M

# node bin
[[ -d "$HOME/node_modules/.bin" ]] && export PATH="$HOME/node_modules/.bin:$PATH"

# cabal bin
[[ -d "$HOME/.cabal/bin" ]] && export PATH="$HOME/.cabal/bin:$PATH"

# use cabal bins if available
[[ -d "$HOME/.cabal/bin" ]] && export PATH="/home/brett/.cabal/bin:$PATH"

# rvm
source /home/brett/.rvm/scripts/rvm

# z
test -f "$HOME/.z.sh" && source "$HOME/.z.sh"

# setup various ENV variables
export EDITOR="vim"
export PAGER="less -R"
export GPGKEY="252426C1"
export EMAIL="brett@bretthoerner.com"
export DEBEMAIL=$EMAIL
export DEBFULLNAME="Brett Hoerner"
export PYTHONDONTWRITEBYTECODE=1
export PIP_RESPECT_VIRTUALENV=true

##################################################
# if not running interactively, don't go further #
[ -z "$PS1" ] && return                          #
##################################################

# tmux completion
[[ -f "$HOME/bin/bash_completion_tmux.sh" ]] && source "$HOME/bin/bash_completion_tmux.sh"

# erase duplicate lines from the history; ignore lines that begin with a space
HISTCONTROL=erasedups:ignorespace

# extend the history (default 500)
HISTSIZE=1000000
HISTFILESIZE=1000000

# append to history rather than overwriting
shopt -s histappend

# don't try to complete on nothing
shopt -s no_empty_cmd_completion

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# fix backspace in vim and others
# stty erase 

# don't print ^C, etc
stty -echoctl

function ll { ls -l "$@"; }

alias gti="git"
alias irctunnel="autossh -M 0 -p 443 -L 6668:localhost:6668 -N martini.bretthoerner.com"

alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

# prompt colors
BGREEN='\[\033[1;32m\]'
GREEN='\[\033[0;32m\]'
BRED='\[\033[1;31m\]'
RED='\[\033[0;31m\]'
BBLUE='\[\033[1;34m\]'
BLUE='\[\033[0;34m\]'
NORMAL='\[\033[00m\]'

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    linux)
        # caps lock = control
        echo -e "$(dumpkeys | grep ^keymaps)\nkeycode 58 = Control" | sudo loadkeys &> /dev/null
        ;;
    xterm-*color|xterm|eterm-color|screen*)
        # color based on host
        case $(hostname) in
            scumbag*|wigi*|passenger*|parasite*)
                HOSTCOLOR="$BGREEN"
            ;;
            *)
                HOSTCOLOR="$BRED"
            ;;
        esac

        # don't show user if it's brett
        case $(whoami) in
            brett*)
                USERPART=""
            ;;
            *)
                USERPART="\u@"
            ;;
        esac
        PS1="${HOSTCOLOR}${USERPART}\h${NORMAL}:${BBLUE}\w${NORMAL}\$ "
    ;;
    *)
        PS1="\u@\h:\w\$ "
    ;;
esac

