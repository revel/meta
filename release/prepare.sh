#!/bin/bash -ex

ver=${1#"v"}
min=${2#"go"}
if [ -z "$ver" -o -z "${min}" ]; then
  echo "Usage: $0 <version> <go min version>"
  echo "  Example: > $0 0.15.0 1.7"
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
min="${min}"
date="$(date +'%Y-%m-%d')"
master="testing"
develop="testdev"
release="release/v${ver}"

repos="revel cmd config modules cron examples revel.github.io heroku-buildpack-go-revel"

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

    if [ "${develop}" != "develop" ]; then
        git -C ${src}/${r} checkout develop
        # if we're testing, make sure the develop branch exists
        git -C ${src}/${r} checkout -b ${develop} || true
    fi

    echo ">>> ${r} <<<"
    git -C ${src}/${r} checkout ${develop}
    git -C ${src}/${r} merge master
    git -C ${src}/${r} checkout -b ${release}

    if [ "${master}" != "master" ]; then
        git-C ${src}/${r} checkout master
        # if we're testing, make sure the destination branch exists
        git -C ${src}/${r} checkout -b ${master} || true
        # after creating branch, put us back on release branch
        git -C ${src}/${r} checkout ${release}
    fi
done

cd ${dir}

update_version ${src}/revel/version.go ${ver} ${date} ${min}
update_web ${src}/revel.github.io/_data/version.yaml ${ver} ${date} ${min}
update_readme ${src}/revel/README.md ${ver} ${date}
update_changelog ${src}/revel/CHANGELOG.md

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
