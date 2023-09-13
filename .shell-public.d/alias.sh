#!/bin/bash

alias gti="git"
alias gt="git"

alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

# show processes by cgroup
alias psc='ps xawf -eo pid,user,cgroup,args'

if which startx &> /dev/null; then
    alias x="ssh-agent -a ${HOME}/.ssh/agent_sock startx"
fi

alias k=kubectl
