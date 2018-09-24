#!/bin/bash -ex

source CONFIG

cd ${dir}
source ${work}/common.sh

export GOPATH=${dir}/go
export PATH=$GOPATH/bin:$PATH

for r in ${repos}; do
    git -C ${src}/${r} checkout ${release}
    git -C ${src}/${r} push origin ${release}
    git -C ${src}/${r} push --tags
done
