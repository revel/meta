#!/bin/bash -ex

source CURRENT
source ${home}/common.sh

export GOPATH=${dir}/go
export PATH=$GOPATH/bin:$PATH
