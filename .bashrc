# ~/.bashrc: executed by bash(1) for non-login shells.

# if not running interactively, don't do anything
[ -z "$PS1" ] && return

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

        export JAVA_HOME="/usr/lib/jvm/java-6-sun"

        alias acs="sudo apt-cache search"
        alias acsh="sudo apt-cache show"
        alias agd="sudo apt-get dist-upgrade"
        alias agi="sudo apt-get install"
        alias agu="sudo apt-get update"
        alias addkey="sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys"

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

# awesome function that sorts du by size
function duf {
    du -sk "$@" \
    | sort -n \
    | while read size fname;
        do for unit in k M G T P E Z Y;
            do if [ $size -lt 1024 ]; then
                echo -e "${size}${unit}\t${fname}";
                break;
            fi;
            size=$((size/1024));
        done;
    done
}

# local should come first
export PATH=/usr/local/sbin:/usr/local/bin:$PATH

# add ~/bin to PATH if it exists
if [ -d "${HOME}/bin" ]; then
    export PATH=${HOME}/bin:$PATH
fi

# use rvm if available
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# prefixed home installs
# [[ -d "$HOME/.opt/bin" ]] && export PATH="/home/brett/.opt/bin:$PATH"

# use cabal bins if available
[[ -d "$HOME/.cabal/bin" ]] && export PATH="/home/brett/.cabal/bin:$PATH"

# use z if available
[[ -f "$HOME/bin/z.sh" ]] && source "$HOME/bin/z.sh"

# use virtualenvwrapper if available
[[ -f "/usr/local/bin/virtualenvwrapper.sh" ]] && source "/usr/local/bin/virtualenvwrapper.sh"

# tmux completion
[[ -f "$HOME/bin/bash_completion_tmux.sh" ]] && source "$HOME/bin/bash_completion_tmux.sh"

# erase duplicate lines from the history; ignore lines that begin with a space
HISTCONTROL=erasedups:ignorespace

# extend the history (default 500)
HISTSIZE=10000
HISTFILESIZE=10000

# append to history rather than overwriting
shopt -s histappend

# don't try to complete on nothing
shopt -s no_empty_cmd_completion

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# fix backspace in vim and others
# stty erase 

# setup various ENV variables
export EDITOR="vim"
export PAGER="less -R"
export GPGKEY="57E06189"
export EMAIL="brett@bretthoerner.com"
export PYTHONDONTWRITEBYTECODE=1
export WORKON_HOME="${HOME}/Development/python"

function ll { ls -l "$@"; }

shorten (){
    googl shorten $1 | pbcopy
    echo "$1 shortened and copied to clipboard"
}

alias rctags="ctags -R --extra=+f"
alias rcetags="rctags -e"
alias emacscompile="emacs -batch -f batch-byte-compile"
alias e="emacsclient -t"

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
    xterm-*color|xterm|eterm-color|screen*)
        # color based on host
        case `hostname` in
            pissant*|wigi*|passenger*|parasite*)
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
