#!/bin/bash -ex

source CONFIG

cd ${dir}
source ${work}/common.sh

export GOPATH=${dir}/go
export PATH=${GOPATH}/bin:$PATH

mkdir -p ${dir}/go/{bin,pkg,src}
mkdir -p ${src}
cd ${src}

for r in ${repos}; do
    if [ ! -e ${r} ]; then
        git clone git@github.com:revel/${r}
    fi

    if [ "${develop}" != "develop" ]; then
        git -C ${src}/${r} checkout develop
    fi

    if [ "${master}" != "master" ]; then
        git -C ${src}/${r} checkout master
    fi
    echo ">>> ${r} <<<"
    if [ "${r}" = "revel.github.io" ]; then
        # website doesn't use develop branch
        git -C ${src}/${r} checkout ${master}
    else
        # everything else uses develop branch
        git -C ${src}/${r} checkout ${develop}
    fi

done
