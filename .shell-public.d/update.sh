updatearch()
{
    yaourt -Syyu --aur
}

updatepip()
{
    pip install --upgrade \
        autoflake \
        awscli \
        matplotlib \
        pip \
        yapf
}

updategems()
{
    gem update --user-install \
        activesupport \
        awesome_print \
        chef \
        fpm \
        jekyll \
        knife-ec2 \
        pry \
        pry-doc \
        ruby_parser \
        travis
}

updategit ()
{
    find . -maxdepth 3 -name ".git" -type d -print0 | xargs -0 -n 1 -I {} -P 8 bash -c "echo && cd {}/.. && pwd && git up"
}

updaterepos ()
{
    prev=$(pwd)
    cd "${HOME}/Development/"
    updategit
    cd "$prev"
}

updateall()
{
    updaterepos
    updatepip
    updategems
    updatearch
}
