#!/bin/bash -ex

source CONFIG

cd ${dir}
source ${work}/common.sh

export GOPATH=${dir}/go
export PATH=${GOPATH}/bin:$PATH

mkdir -p ${dir}/go/{bin,pkg,src}
mkdir -p ${src}
cd ${src}

# Perform merge in second step to avoid a conflict interrupting the process
for r in ${repos}; do

    echo ">>> ${r} <<<"
    if [ "${r}" = "revel.github.io" ]; then
        # website doesn't use develop branch
        echo "Website merge skipped"
    else
        # everything else uses develop branch
        git -C ${src}/${r} merge ${master}
    fi
done
