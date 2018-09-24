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
deps+=" github.com/revel/pathtree"
deps+=" golang.org/x/net/websocket"
deps+=" gopkg.in/fsnotify/fsnotify.v1"
deps+=" github.com/go-gorp/gorp"
deps+=" github.com/mattn/go-sqlite3"
deps+=" golang.org/x/crypto/bcrypt"
deps+=" github.com/bradfitz/gomemcache/memcache"
deps+=" github.com/garyburd/redigo/redis"
deps+=" github.com/go-stack/stack"
deps+=" github.com/revel/log15"
deps+=" github.com/xeonx/timeago"
deps+=" gopkg.in/natefinch/lumberjack.v2"
deps+=" github.com/jessevdk/go-flags"
deps+=" github.com/stretchr/testify/assert"


# Deprecated, remove v 21
deps+=" github.com/klauspost/compress/gzip"
deps+=" github.com/klauspost/compress/zlib"

# Casbin module auth
deps+=" github.com/casbin/casbin"

# GORP module
deps+=" gopkg.in/Masterminds/squirrel.v1"
deps+=" gopkg.in/gorp.v2"

# Remove github.com/robfig/go-cache release v0.20.0
deps+=" github.com/robfig/go-cache"
deps+=" github.com/patrickmn/go-cache"


# From gorm module
deps+=" github.com/jinzhu/gorm"
deps+=" github.com/go-sql-driver/mysql"
deps+=" github.com/lib/pq"

# From pongo2 module, would be nice to remove if possible (it allows you to store something in current thread)
deps+=" github.com/tylerb/gls"
deps+=" github.com/flosch/pongo2"
# From ace template module
deps+=" github.com/yosssi/ace"

# From server engine fasthttp
deps+=" github.com/valyala/fasthttp"
# From server engine newrelic
deps+=" github.com/newrelic/go-agent"

# From examples
deps+=" github.com/mrjones/oauth"
deps+=" golang.org/x/oauth2"

tests="booking chat orm/gorm upload"
echo deps
export dir src min date repos deps tests work
EOF
