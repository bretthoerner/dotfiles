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
    go install github.com/acroca/go-symbols@latest
    go install github.com/cweill/gotests/...@latest
    go install github.com/fatih/gomodifytags@latest
    go install github.com/go-delve/delve/cmd/dlv@latest
    go install github.com/golang/mock/gomock@latest
    go install github.com/josharian/impl@latest
    go install github.com/pressly/goose/cmd/goose@latest
    go install github.com/ramya-rao-a/go-outline@latest
    go install github.com/rogpeppe/godef@latest
    go install github.com/stamblerre/gocode@latest
    go install github.com/tpng/gopkgs@latest
    go install golang.org/x/lint/golint@latest
    go install golang.org/x/tools/cmd/goimports@latest
    go install golang.org/x/tools/cmd/gopls@latest
    go install golang.org/x/tools/cmd/gorename@latest
    go install golang.org/x/tools/cmd/guru@latest
    go install sourcegraph.com/sqs/goreturns@latest
    go install github.com/tomnomnom/gron@latest
    go install github.com/golang/mock/mockgen@latest
    go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
}
