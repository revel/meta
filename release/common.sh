#!/bin/bash

function update_version() {
    file=$1
    ver=$2
    date=$3
    min=$4
    cat <<EOF > $file
// Copyright (c) 2012-2017 The Revel Framework Authors, All rights reserved.
// Revel Framework source code and usage is governed by a MIT style
// license that can be found in the LICENSE file.

package revel

const (
	// Version current Revel version
	Version = "${ver}"

	// BuildDate latest commit/release date
	BuildDate = "${date}"

	// MinimumGoVersion minimum required Go version for Revel
	MinimumGoVersion = ">= ${min}"
)
EOF
}

function update_readme() {
    file=$1
    ver=$2
    date=$3
    sed -i".old" "s/Current\ Version.*/Current\ Version: ${ver} \(${date}\)/" ${file} && rm ${file}.old
}

function update_changelog() {
    file=$1
    ${home}/changelog.sh > ${file}.new
    if [ -e "${file}" ]; then
        cat ${file} | grep -v ^"# CHANGELOG" >> ${file}.new
    fi
    mv ${file}.new ${file}
}
