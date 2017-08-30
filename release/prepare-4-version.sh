#!/bin/bash -ex

source CONFIG

cd ${dir}
source ${work}/common.sh

export GOPATH=${dir}/go
export PATH=${GOPATH}/bin:$PATH

cd ${dir}

update_version ${src}/revel/version.go ${ver} ${date} ${min}
update_web ${src}/revel.github.io/_data/version.yaml ${ver} ${date} ${min}
update_readme ${src}/revel/README.md ${ver} ${date}
# TODO: come up with a better changelog
#update_changelog ${src}/revel/CHANGELOG.md

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
