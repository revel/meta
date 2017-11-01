#!/bin/bash -ex

source CONFIG

cd ${dir}
source ${work}/common.sh

export GOPATH=${dir}/go
export PATH=${GOPATH}/bin:$PATH

mkdir -p ${dir}/go/{bin,pkg,src}
mkdir -p ${src}
cd ${src}

# Third step is to create branches
for r in ${repos}; do
    if [ "${develop}" != "develop" ]; then
        # if we're testing, make sure the testing develop branch exists
        git -C ${src}/${r} checkout -b ${develop} || true
    fi

    if [ "${master}" != "master" ]; then
        # if we're testing, make sure the testing master branch exists
        git -C ${src}/${r} checkout -b ${master} || true
    fi
    echo ">>> ${r} <<<"
#     if [ "${r}" = "revel.github.io" ]; then
#         # website doesn't use develop branch
#         git -C ${src}/${r} checkout -b ${release}
#     else
        # everything else uses develop branch
        git -C ${src}/${r} checkout -b ${release}
#     fi
done

