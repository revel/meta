#!/bin/bash

source CONFIG
source ${work}/common.sh

export GOPATH=${dir}/go
export PATH=$GOPATH/bin:$PATH

for r in ${repos}; do
    (
        cd ${src}/${r}
        hub issue
    )
done
