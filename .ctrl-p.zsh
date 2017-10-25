#!/usr/bin/env zsh
#
# # Ctrl-P - cd to dir or edit file with fzf
# Put in /usr/local/share/zsh/site-functions/ 
# and add to .zshrc
# source /usr/local/share/zsh/site-functions/ctrl-p 
# inspired by
# https://adamheins.com/blog/ctrl-p-in-the-terminal-with-fzf


fzf-edit-file-or-open-dir() {
    local out key file helpline
    helpline="Ctrl-f to reveal in Finder | Enter to edit file"
    # IFS=$'\n' out=($(ag -g "" | fzf --header="$helpline" \
    # IFS=$'\n' out=($(bfs | fzf --header="$helpline" \
    IFS=$'\n' out=($(rg --files --hidden --glob "!.git/*" | fzf --header="$helpline" \
            --exit-0 \
            --expect=ctrl-f \
            --preview '[ -f {} ] && head -n 50 {}' \
            --preview-window down:4 \
            --bind='?:toggle-preview' ))
    key=$(head -1 <<< "$out")
    file=$(head -2 <<< "$out" | tail -1)

    if [ "$key" = ctrl-f ]; then
        nautilus "$file"
    else
        if [ -f "$file" ]; then
            emacsclient -n "$file"
        elif [ -d "$file" ]; then
            cd "$file"
        fi
        zle reset-prompt
    fi
    zle accept-line
}
zle     -N   fzf-edit-file-or-open-dir
bindkey '^P' fzf-edit-file-or-open-dir

