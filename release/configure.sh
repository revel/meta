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

cat <<EOF > CONFIG
ver=${ver}
work=${work}
dir=${dir}
src=${dir}/go/src/github.com/revel
min="${min}"
date="$(date +'%Y-%m-%d')"
master="master"
develop="develop"
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
deps+=" github.com/bradfitz/gomemcache/memcache"
deps+=" github.com/garyburd/redigo/redis"
deps+=" github.com/robfig/go-cache"

tests="booking chat"

export dir src min date repos deps tests work
EOF
