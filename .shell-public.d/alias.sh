#!/bin/bash

alias gti="git"
alias gt="git"
alias gcm="git checkout main && git pull"

alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

alias dstat=dool

# show processes by cgroup
alias psc='ps xawf -eo pid,user,cgroup,args'

alias k=kubectl

alias utcnow='python3 -c "from datetime import datetime, UTC; import time; print(datetime.fromtimestamp(time.time(), UTC).strftime(\"%Y-%m-%d %H:%M:%S UTC\"))"'
