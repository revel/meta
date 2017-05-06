#!/bin/bash -ex

source CURRENT
source ${home}/common.sh

export GOPATH=${dir}/go
export PATH=$GOPATH/bin:$PATH

echo "# CHANGELOG"
echo
echo "## v${ver}"
echo

for r in ${repos}; do
    echo "[[$r](https://github.com/revel/$r)]"
    echo
    lines=$(git --no-pager -C ${src}/${r} log --oneline master..develop)
    if [ -z "$lines" ]; then
        echo "* no changes"
    else
        while read line; do echo "* $line"; done <<< "$lines"
    fi
    echo
done

