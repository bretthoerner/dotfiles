#!/bin/bash

function install-rust-tools() {
    cargo install --force rustsym
    cargo install --force mdbook
    cargo install --force cargo-asm
    rustup component add rustfmt-preview
    rustup component add clippy-preview
    rustup component add rls
    rustup component add rust-analysis
    rustup component add rust-src
}

function install-go-tools() {
    go get -u github.com/acroca/go-symbols
    go get -u github.com/cweill/gotests/...
    go get -u github.com/fatih/gomodifytags
    go get -u github.com/go-delve/delve/cmd/dlv
    go get -u github.com/golangci/golangci-lint/cmd/golangci-lint
    go get -u github.com/golang/mock/gomock
    go get -u github.com/josharian/impl
    go get -u github.com/pressly/goose/cmd/goose
    go get -u github.com/ramya-rao-a/go-outline
    go get -u github.com/rogpeppe/godef
    go get -u github.com/stamblerre/gocode
    go get -u github.com/tpng/gopkgs
    go get -u golang.org/x/lint/golint
    go get -u golang.org/x/tools/cmd/goimports
    go get -u golang.org/x/tools/cmd/gopls
    go get -u golang.org/x/tools/cmd/gorename
    go get -u golang.org/x/tools/cmd/guru
    go get -u sourcegraph.com/sqs/goreturns
    go install github.com/golang/mock/mockgen
}
