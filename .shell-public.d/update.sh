updatearch()
{
    if which yaourt &> /dev/null; then
        yaourt -Syyu --aur
    fi
}

updategems()
{
    pushd
    cd $HOME
    gem update
    popd
}

updategit()
{
    find . \
         -maxdepth 3 \
         -name ".git" \
         -type d \
         -print0 \
        | xargs \
              -0 \
              -n 1 \
              -I {} \
              -P 8 \
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
    rustup self update
    rustup update
}

updategcloud() {
    yes | gcloud components update
}

updatebrew() {
    if which brew &> /dev/null; then
        brew update
        brew upgrade
    fi
}

updateall()
{
    updaterepos
    updategems
    updaterust
    updategcloud
    updatearch
    updatebrew
}
