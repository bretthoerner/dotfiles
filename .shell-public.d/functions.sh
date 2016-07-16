function install-go-tools() {
    go get -u -v github.com/nsf/gocode
    go get -u -v github.com/rogpeppe/godef
    go get -u -v github.com/tools/godep
    go get -u -v golang.org/x/tools/cmd/gorename
    go get -u -v golang.org/x/tools/cmd/oracle
    go get -u -v golang.org/x/tools/cmd/goimports
    go get -u -v github.com/tools/godep
}

function link-go-tools() {
    for tool in gorename oracle godep godef gocode goimports godep; do
        mkdir -p "${GOPATH}/bin/"
        ln -nsf "${HOME}/Development/go/bin/${tool}" "${GOPATH}/bin/${tool}"
    done
}
