#!/bin/bash -ex

source CONFIG
cd ${dir}
source ${work}/common.sh

export GOPATH=${dir}/go
export PATH=$GOPATH/bin:$PATH

echo "# CHANGELOG"
echo
echo "## v${ver}"
echo

for r in ${repos}; do
#    if [ "${r}" != "revel.github.io" ]; then
        # website doesn't use develop branch
        echo "[[revel/$r](https://github.com/revel/$r)]"
        echo
        lines=$(git --no-pager -C ${src}/${r} log --oneline ${master}..${develop})
        if [ -z "$lines" ]; then
            echo "* no changes"
        else
            while read line; do echo "* $line"; done <<< "$lines"
        fi
        echo
#    fi
done

