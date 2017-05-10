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
        # if we're testing, make sure the testing develop branch exists
        git -C ${src}/${r} checkout -b ${develop} || true
    fi

    if [ "${master}" != "master" ]; then
        git -C ${src}/${r} checkout master
        # if we're testing, make sure the testing master branch exists
        git -C ${src}/${r} checkout -b ${master} || true
    fi

    echo ">>> ${r} <<<"
    if [ "${r}" = "revel.github.io" ]; then
        # website doesn't use develop branch
        git -C ${src}/${r} checkout ${master}
        git -C ${src}/${r} checkout -b ${release}
    else
        # everything else uses develop branch
        git -C ${src}/${r} checkout ${develop}
        git -C ${src}/${r} merge ${master}
        git -C ${src}/${r} checkout -b ${release}
    fi
done

cd ${dir}

update_version ${src}/revel/version.go ${ver} ${date} ${min}
update_web ${src}/revel.github.io/_data/version.yaml ${ver} ${date} ${min}
update_readme ${src}/revel/README.md ${ver} ${date}
# TODO: come up with a better changelog
#update_changelog ${src}/revel/CHANGELOG.md

for d in ${deps}; do
  echo getting ${d}
  go get -u ${d}
done

go build github.com/revel/revel
go install github.com/revel/cmd/revel

revel version

echo "# changes in revel/revel"
git -C ${src}/revel add .
git --no-pager -C ${src}/revel diff --staged

echo "# changes in revel/revel.github.io"
git -C ${src}/revel.github.io add .
git --no-pager -C ${src}/revel.github.io diff --staged

echo "# code is in: ${src}"
