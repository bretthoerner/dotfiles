if which hub &> /dev/null; then
    alias git="hub"
fi

_emacs_path="/Applications/Emacs.app/Contents/MacOS/Emacs"
if [[ -f $_emacs_path ]]; then
    alias emacs=$_emacs_path
fi
unset _emacs_path

alias gti="git"

alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

alias x="ssh-agent startx"
