updatearch()
{
    yaourt -Syyu --aur
}

updatepip()
{
    pushd
    cd $HOME
    pip install --upgrade \
        autoflake \
        awscli \
        pip \
        yapf
    popd
}

updategems()
{
    pushd
    cd $HOME
    gem update \
        activesupport \
        awesome_print \
        chef \
        fpm \
        jekyll \
        knife-ec2 \
        pry \
        pry-doc
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

updateall()
{
    updaterepos
    updatepip
    updategems
    updaterust
    updategcloud
    updatearch
}
