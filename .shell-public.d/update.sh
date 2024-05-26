#!/bin/bash

updatearch()
{(
    set -e
    if which yay &> /dev/null; then
        yay -Syu --devel --timeupdate
    fi
)}


updategit()
{(
    set -e
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
              -P "$PARALLELISM" \
              bash -c "echo && cd {}/.. && pwd && git up"
)}

updateapt()
{(
    set -e
    if which apt-get &> /dev/null; then
        sudo apt-get update
        sudo apt-get dist-upgrade
    fi
)}

updaterepos()
{(
    set -e
    pushd
    cd "${HOME}/Development/"
    updategit 8
    popd
)}

updaterust()
{(
    set -e
    if which rustup &> /dev/null; then
        [[ -f /etc/arch-release ]] || rustup self update
        rustup update
    fi

    cargo install-update --list
    cargo install-update --all
)}

updategcloud() {
    yes | gcloud components update
}

updatebrew() {(
    set -e
    if which brew &> /dev/null; then
        brew update
        brew upgrade
        # brew cask upgrade
    fi
)}

updateall()
{
    updaterepos
    updaterust
    updatearch
    updateapt
    updatebrew
}
