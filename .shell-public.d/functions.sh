function install-rust-tools() {
    cargo install --force rustsym
    cargo install --force racer
    cargo install --force mdbook
    cargo install --force cargo-asm
    rustup component add rustfmt-preview
    rustup component add clippy-preview
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

function f() {
    code $(fzf)
}
