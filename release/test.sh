#!/bin/bash -ex

source CONFIG

cd ${dir}
source ${work}/common.sh

export GOPATH=${dir}/go
export PATH=$GOPATH/bin:$PATH

for r in revel cmd/revel config cron; do #  modules/csrf/app
    cd ${src}/${r}
    echo "# go test ${r}"
    go test -v ./
done

go build github.com/revel/revel
go install github.com/revel/cmd/revel

revel version

for e in ${tests}; do
    echo "# revel test github.com/revel/examples/${e}"
    revel test github.com/revel/examples/${e}
done

echo "# tests passed. no errors."
