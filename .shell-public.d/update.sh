#!/bin/bash

updatearch()
{
    if which yay &> /dev/null; then
        yay -Syu --devel --timeupdate
    fi
}


updategit()
{
    PARALLELISM=${1:-8}
    find . \
         -maxdepth 3 \
         -name ".git" \
         -type d \
         -print0 \
        | xargs \
              -0 \
              -n 1 \
              -I {} \
              -P $PARALLELISM \
              bash -c "echo && cd {}/.. && pwd && git up"
}

updaterepos()
{
    pushd
    cd "${HOME}/Development/"
    updategit
    popd
}

updaterust()
{
    if which rustup &> /dev/null; then
        [[ -f /etc/arch-release ]] || rustup self update
        rustup update
    fi
}

updategcloud() {
    yes | gcloud components update
}

updatebrew() {
    if which brew &> /dev/null; then
        brew update
        brew upgrade
        # brew cask upgrade
    fi
}

updateall()
{
    updaterepos
    updaterust
    updatearch
    updatebrew
}
