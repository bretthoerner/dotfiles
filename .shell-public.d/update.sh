updatearch()
{
    yaourt -Syyu --aur
}

updatepip()
{
    pip install --upgrade pip awscli yapf autoflake
}

updategems()
{
    gem update --user-install pry pry-doc activesupport awesome_print jekyll fpm t chef ruby_parser knife-ec2 travis
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
