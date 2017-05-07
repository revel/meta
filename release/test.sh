#!/bin/bash -ex

source CONFIG
source ${work}/common.sh

export GOPATH=${dir}/go
export PATH=$GOPATH/bin:$PATH

for r in revel cmd/revel config cron; do
    cd ${src}/${r}
    echo "# go test ${r}"
    go test -v
done

for e in ${tests}; do
    echo "# revel test github.com/revel/examples/${e}"
    revel test github.com/revel/examples/${e}
done
