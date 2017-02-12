updatearch()
{
    yaourt -Syyu --aur
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
    brew update
    brew upgrade
}

updateall()
{
    updaterepos
    updategems
    updaterust
    updategcloud
    updatebrew
}
