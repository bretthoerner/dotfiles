# ~/.bashrc: executed by bash(1) for non-login shells.

# platform specific stuff
case $OSTYPE in
    linux*)
        # linux specific

        # make less more friendly for non-text input files, see lesspipe(1)
        [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

        if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
            eval "`dircolors -b`"
        fi

        function ls { command ls -Fh --color=auto "$@"; }

        # source the bash-completion file
        if [ -r "/etc/bash_completion" ]; then
            . "/etc/bash_completion"
        fi

        alias v="cd /home/brett/Development/mr/chef/vagrant/ && vagrant ssh"
        alias t="cd /home/brett/Development/mr/tweetriver"

        alias open="gnome-open"

        # cope
        # export PATH=/usr/local/share/perl/5.10.1/auto/share/dist/Cope:$PATH

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
    ;;
    darwin*)
        # mac specific

        export LC_CTYPE="en_US.UTF-8"
        export LANG="en_US.UTF-8"
        export LANGUAGE="en_US.UTF-8"
        export LC_ALL="en_US.UTF-8"

        # homebrew python
        export PYTHONPATH=/usr/local/lib/python2.6/site-packages
        export PATH=/usr/local/Cellar/python/2.6.5/bin:$PATH

        # functions
        function ls { command gls -Fh --color=auto "$@"; }
        function manp { man -t "${1}" | open -f -a Preview; }

        if [ -f `brew --prefix`/etc/bash_completion ]; then
          . `brew --prefix`/etc/bash_completion
        fi

        alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs -nw"
    ;;
    solaris*)
        # solaris specific

        function ls { command gls -Fh --color=auto "$@"; }

        alias man='GROFF_NO_SGR= TCAT="less -s" TROFF="groff -Tascii" man -t'

        export MAIL=/usr/mail/${LOGNAME:?}
        export MANPATH="/opt/local/man:/opt/local/share/man:/usr/share/man:/usr/sfw/share/man:/usr/openwin/share/man"
        export PATH="/opt/local/bin:/opt/local/sbin:/usr/xpg4/bin:/usr/bin:/usr/sbin:/usr/sfw/bin:/usr/openwin/bin:/opt/SUNWspro/bin:/usr/ccs/bin:/usr/ucb/"
        export PKG_PATH="http://pkgsrc.joyent.com/2008Q2/All"
    ;;
    *)
    ;;
esac

# aws
export PATH="${HOME}/.aws-cli/bin:$PATH"

# local should come first
export PATH=/usr/local/sbin:/usr/local/bin:$PATH

# go
export GOPATH=${HOME}/.go
export PATH="~/.go/bin/:${PATH}"

# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# add ~/bin to PATH if it exists
if [ -d "${HOME}/bin" ]; then
    export PATH=${HOME}/bin:$PATH
fi

# node bin
[[ -d "$HOME/node_modules/.bin" ]] && export PATH="$HOME/node_modules/.bin:$PATH"

# use cabal bins if available
[[ -d "$HOME/.cabal/bin" ]] && export PATH="/home/brett/.cabal/bin:$PATH"

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
        case `hostname` in
            scumbag*|wigi*|passenger*|parasite*)
                HOSTCOLOR="$BGREEN"
            ;;
            *)
                HOSTCOLOR="$BRED"
            ;;
        esac

        # don't show user if it's brett
        case `whoami` in
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
