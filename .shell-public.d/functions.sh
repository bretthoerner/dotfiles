function install-rust-tools() {
    cargo install --force rustsym
    cargo install --force racer
    cargo install --force mdbook
    cargo +nightly install --force rustfmt-nightly
}

function install-go-tools() {
    go get -u -v github.com/nsf/gocode
    go get -u -v github.com/rogpeppe/godef
    go get -u -v github.com/tools/godep
    go get -u -v golang.org/x/tools/cmd/goimports
    go get -u -v golang.org/x/tools/cmd/gorename
    go get -u -v golang.org/x/tools/cmd/guru
    go get -u -v github.com/golang/lint/golint
    go get -u -v github.com/tpng/gopkgs
    go get -u -v github.com/ramya-rao-a/go-outline
    go get -u -v github.com/acroca/go-symbols
    go get -u -v github.com/fatih/gomodifytags
    go get -u -v sourcegraph.com/sqs/goreturns
    go get -u -v github.com/cweill/gotests/...
    go get -u -v github.com/josharian/impl
}

function link-go-tools() {
    for tool in gorename godep godef gocode goimports golint godep guru gopkgs go-outline go-symbols gomodifytags goreturns gotests; do
        mkdir -p "${GOPATH}/bin/"
        ln -nsf "${HOME}/Development/go/bin/${tool}" "${GOPATH}/bin/${tool}"
    done
}

function workon-go() {
    project=$1
    export GOPATH="$HOME/Development/go/roots/$project"
#    version=$(cat $GOPATH/version)
#    export GOROOT=$HOME/Development/go/versions/$version
#    export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
    export PATH="$GOPATH/bin:$PATH"
    PS1="($project) $PS1"
}

function f() {
    code $(fzf)
}
