#!/bin/bash -ex

ver=${1#"v"}
if [ -z "$ver" ]; then
  echo "Usage: $0 <version>"
  echo "  Example: > $0 0.15.0"
  exit 1
fi

work=`pwd`
dir="/tmp/release/v${ver}"
rm -rf ${dir}
mkdir -p ${dir}

cd ${dir}

cat <<EOF > CONFIG
ver=${ver}
work=${work}
dir=${dir}
src=${dir}/go/src/github.com/revel
min="go1.7"
date="$(date +'%Y-%m-%d')"

repos="revel cmd config modules cron examples revel.github.io"

deps=""
deps+=" github.com/agtorre/gocolorize"
deps+=" github.com/klauspost/compress/gzip"
deps+=" github.com/klauspost/compress/zlib"
deps+=" github.com/robfig/pathtree"
deps+=" golang.org/x/net/websocket"
deps+=" gopkg.in/fsnotify.v1"
deps+=" github.com/go-gorp/gorp"
deps+=" github.com/mattn/go-sqlite3"
deps+=" golang.org/x/crypto/bcrypt"

tests="booking chat"

export dir src min date repos deps tests work
EOF

source CONFIG
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

    echo ">>> ${r} <<<"
    (
        cd ${r}
        git checkout develop
        git merge master
        git checkout -b release/v${ver}
        git status
    )
done

cd ${dir}

update_version ${src}/revel/version.go ${ver} ${date} ${min}
update_readme ${src}/revel/README.md ${ver} ${date}
update_changelog ${src}/revel/CHANGELOG.md

for d in ${deps}; do
  echo getting ${d}
  go get -u ${d}
done

go build github.com/revel/revel
go install github.com/revel/cmd/revel

revel version

git -C ${src}/revel add .
git --no-pager -C ${src}/revel diff --staged
