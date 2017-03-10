function install-go-tools() {
    go get -u -v github.com/nsf/gocode
    go get -u -v github.com/rogpeppe/godef
    go get -u -v github.com/tools/godep
    go get -u -v golang.org/x/tools/cmd/goimports
    go get -u -v golang.org/x/tools/cmd/gorename
    go get -u -v golang.org/x/tools/cmd/guru
    go get -u -v github.com/golang/lint/golint
}

function link-go-tools() {
    for tool in gorename godep godef gocode goimports golint godep guru; do
        mkdir -p "${GOPATH}/bin/"
        ln -nsf "${HOME}/Development/go/bin/${tool}" "${GOPATH}/bin/${tool}"
    done
}

function workon-go() {
    project=$1
    export GOPATH=$HOME/Development/go/roots/$project
    version=$(cat $GOPATH/version)
    export GOROOT=$HOME/Development/go/versions/$version
    export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
}
